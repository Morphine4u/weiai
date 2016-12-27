//
//  WAHistoryTableViewController.h
//  weiai
//
//  Created by Morphine on 2016/10/9.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WADatePickerViewController.h"
#import "WADatePickerView.h"
#import "WAHistoryCell.h"


@interface WAHistoryTableViewController : UITableViewController<WADatePickerDelegate,CellReloadTextFieldDelegate>

//@property (nonatomic, strong) NSIndexPath *cellIndexPath;
//@property (nonatomic, strong) NSString *textField;

//+ (WAHistoryTableViewController *)sharedWAHistoryTableViewController;
@end
