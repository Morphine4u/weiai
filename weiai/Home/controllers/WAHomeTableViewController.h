//
//  WAHomeTableViewController.h
//  weiai
//
//  Created by Morphine on 2016/10/7.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAHomeTableViewController : UITableViewController

/**
*  顶部注释多行
*/
@property (nonatomic, strong) NSMutableDictionary *recordDic;

/** 顶部注释一行 */
@property (weak, nonatomic) IBOutlet UILabel *predictiveTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *daysLabel;/**< 右侧注释 */

@end
