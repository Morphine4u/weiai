//
//  WAHistoryCell.h
//  weiai
//
//  Created by Morphine on 2016/10/9.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WARecordModel.h"
@protocol CellReloadTextFieldDelegate;

@interface WAHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timesLabel;
@property (weak, nonatomic) IBOutlet UITextField *startField;
@property (weak, nonatomic) IBOutlet UITextField *endField;
@property (weak, nonatomic) IBOutlet UILabel *cycleLabel;
@property (nonatomic, strong) WARecordModel *model;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id <CellReloadTextFieldDelegate> delegate;
@end

@protocol CellReloadTextFieldDelegate <NSObject>

- (void)reloadTextFieldWithCell:(WAHistoryCell *)cell whichTextField:(NSString *)textFieldString;

@end
