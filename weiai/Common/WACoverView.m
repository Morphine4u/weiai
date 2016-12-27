//
//  WACoverView.m
//  weiai
//
//  Created by Morphine on 2016/10/8.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WACoverView.h"

@implementation WACoverView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (void)show
{
    WACoverView *cover = [[WACoverView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.3;
    [[UIApplication sharedApplication].keyWindow addSubview:cover];
}

+ (void)dismiss
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    for (UIView *cover in keyWindow.subviews) {
        if ([cover isKindOfClass:self]) {
            [cover removeFromSuperview];
        }
    }
}
@end
