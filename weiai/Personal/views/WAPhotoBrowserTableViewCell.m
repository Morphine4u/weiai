//
//  WAPhotoBrowserTableViewCell.m
//  weiai
//
//  Created by Morphine on 2016/10/22.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WAPhotoBrowserTableViewCell.h"
@interface WAPhotoBrowserTableViewCell ()<UIScrollViewDelegate>
{
//    UIScrollView *_scrollView;
}
@end

@implementation WAPhotoBrowserTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initViews];
    }
    return self;
}
- (void)initViews {
    //        self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [_scrollView setBackgroundColor:[UIColor blackColor]];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    //        [_scrollView setPagingEnabled:YES];
    _scrollView.decelerationRate = 0.0;
    _scrollView.minimumZoomScale = 1.0;
    _scrollView.maximumZoomScale = 2.0;//不加倍数不调用代理方法
    _scrollView.userInteractionEnabled = YES;
    _scrollView.delegate = self;
    
    _image = [[UIImageView alloc] initWithFrame:_scrollView.bounds];
    _image.backgroundColor = [UIColor clearColor];
    _image.clipsToBounds = YES;
    _image.contentMode = UIViewContentModeScaleAspectFit;
    
    
    [_scrollView addSubview:_image];
    [self addSubview:_scrollView];
    
    
    //添加单击手势监听
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap)];
    [singleTap setNumberOfTapsRequired:1];
    [_scrollView addGestureRecognizer:singleTap];
    
    //添加双击手势监听
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    [self addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
}
- (void)drawRect:(CGRect)rect {
    _image.image = self.image.image;
    bool show = [[NSUserDefaults standardUserDefaults] boolForKey:@"openAnimation"];
    if (show) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"openAnimation"];

        [_scrollView setBackgroundColor:[UIColor clearColor]];
        _image.frame = _convertFrame;
        [UIView animateWithDuration:.3f animations:^{
            
            [_image setFrame:_scrollView.bounds];
            [_scrollView setBackgroundColor:[UIColor blackColor]];
            
            [self.delegate singleTap:self];
        } completion:^(BOOL finished) {
            
        }];
    }
}
#pragma mark - 单击返回/双击放大事件
- (void)singleTap {

    [self.delegate singleTap:self];
    
    [UIView animateWithDuration:.3f animations:^{
        
        _image.frame = _convertFrame;
        
        // 动画过程中，背景视图透明
        [_scrollView setBackgroundColor:[UIColor clearColor]];
    } completion:^(BOOL finished) {
        // 动画完成后，通知代理从window中删除
        // 2. 关闭视图控制器
        
        [self.delegate endScan:self];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"openAnimation"];
    }];
}
- (void)doubleTap:(UITapGestureRecognizer *)recognizer{

    // 如果图像视图放大到两倍，还原初始大小
    if (_scrollView.zoomScale == _scrollView.maximumZoomScale) {
        [_scrollView setZoomScale:1.0f animated:YES];
    } else {
        // 否则，从手势触摸位置开始放大
        CGPoint location = [recognizer locationInView:self];
        [_scrollView zoomToRect:CGRectMake(location.x, location.y, 1, 1) animated:YES];
    }
}
#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return _image;
}
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
