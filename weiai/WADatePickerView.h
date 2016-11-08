//
//  WADatePickerView.h
//  weiai
//
//  Created by Morphine on 2016/10/10.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WADatePickerDelegate;

@interface WADatePickerView : UIView


@property (strong, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
//@property (strong, nonatomic) IBOutlet UIView *dateView;
@property (nonatomic, weak) id<WADatePickerDelegate> datePickerDelegate;
@property (nonatomic) BOOL isShow;


- (void)show;
//- (void)close;

- (IBAction)closeDatePicker:(UIButton *)sender;
- (IBAction)saveStartDate:(UIButton *)sender;
+ (WADatePickerView *)sharedWADatePickerView;
@end

@protocol WADatePickerDelegate <NSObject>

@required
- (void)saveDataWith:(NSDate *)date;

@optional
- (void)closeDatePicker:(NSDate *)date;
@end
