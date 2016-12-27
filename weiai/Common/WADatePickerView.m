//
//  WADatePickerView.m
//  weiai
//
//  Created by Morphine on 2016/10/10.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WADatePickerView.h"
#import "WADatePickerViewController.h"

@implementation WADatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
*/
static WADatePickerView *sharedWADatePickerViewInstance = nil;

+ (WADatePickerView *)sharedWADatePickerView {
    @synchronized(self) {
        static dispatch_once_t t;
        dispatch_once(&t, ^{ 
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            WADatePickerViewController *datePickerVC = [storyboard instantiateViewControllerWithIdentifier:@"datePickerVC"];
            sharedWADatePickerViewInstance = (WADatePickerView *)[datePickerVC.view viewWithTag:101];});
        sharedWADatePickerViewInstance.frame = CGRectMake(0, 0, 375, 667);
        sharedWADatePickerViewInstance.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        sharedWADatePickerViewInstance.backView.frame = CGRectMake(0,667,375,240);
    }
    return sharedWADatePickerViewInstance;
}
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    self.backView.frame = CGRectMake(0,667,375,240);
    self.datePicker.backgroundColor = [UIColor colorWithRed:255/255.0 green:187/255.0 blue:208/255.0 alpha:1];
    [self.datePicker addTarget:self action:@selector(rollAction:) forControlEvents:(UIControlEventValueChanged)];
}
- (void)rollAction:(UIDatePicker *)sender
{
    
    self.datePicker.date = sender.date;
    
    
}
- (void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.backView.frame = CGRectMake(0, 667-240, 375, 240);
        
    }];
    
}
- (void)close{
    //    self.isShow = !self.isShow;
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
        self.backView.frame = CGRectMake(0, 667, 375, 240);
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}
- (IBAction)closeDatePicker:(UIButton *)sender {

    [self close];
    [self.datePickerDelegate closeDatePicker:self.datePicker.date];
}

- (IBAction)saveStartDate:(UIButton *)sender {
    [self close];
    [self.datePickerDelegate saveDataWith:self.datePicker.date];
}

@end
