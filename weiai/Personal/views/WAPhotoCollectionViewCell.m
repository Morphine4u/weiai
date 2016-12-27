//
//  WAPhotoCollectionViewCell.m
//  weiai
//
//  Created by Morphine on 2016/10/17.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WAPhotoCollectionViewCell.h"


@implementation WAPhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notice:) name:@"deleteImages" object:nil];
}
- (void)notice:(NSNotification *)notification {
    
    self.deleteButton.hidden = !self.deleteButton.hidden;
}
- (IBAction)deletePhotos:(UIButton *)sender {
    [self.delegate deletePhotos:self];
}
@end
