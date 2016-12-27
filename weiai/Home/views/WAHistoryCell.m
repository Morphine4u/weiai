//
//  WAHistoryCell.m
//  weiai
//
//  Created by Morphine on 2016/10/9.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WAHistoryCell.h"


@implementation WAHistoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    

//    //获取通知中心单例对象
//    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
//    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
//    [center addObserver:self selector:@selector(notice:) name:@"closetextfield" object:nil];
    
    
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    WADatePickerViewController *datePickerVC = [storyboard instantiateViewControllerWithIdentifier:@"datePickerVC"];
//    WADatePickerView *datePickerView = (WADatePickerView *)[datePickerVC.view viewWithTag:101];
//    
//    WAHistoryTableViewController *historyTVC = [WAHistoryTableViewController sharedInstance];
//    datePickerView.datePickerDelegate = historyTVC;
//    
//    self.startField.inputView = datePickerVC.view;
//    self.endField.inputView = datePickerVC.view;

    
    
}
- (void)setModel:(WARecordModel *)model{
    if (model != _model) {
        _model = model;
    }
    self.timesLabel.text = self.model.times;
    self.startField.text = self.model.startDate;
    self.endField.text = self.model.endDate;
    self.cycleLabel.text = self.model.cycle;
}
//-(void)notice:(NSNotification *)notification{
//    [self.startField resignFirstResponder];
//    [self.endField resignFirstResponder];
//}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    
    
//    historyTVC.cellIndexPath = self.indexPath;
    if (textField == self.startField) {
//        historyTVC.textField = @"start";
        [self.delegate reloadTextFieldWithCell:self whichTextField:@"start"];
    }else{
//        historyTVC.textField = @"end";
        [self.delegate reloadTextFieldWithCell:self whichTextField:@"end"];
    }
    
    return NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
