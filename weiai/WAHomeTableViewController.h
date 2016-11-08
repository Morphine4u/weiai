//
//  WAHomeTableViewController.h
//  weiai
//
//  Created by Morphine on 2016/10/7.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAHomeTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableDictionary *recordDic;
@property (weak, nonatomic) IBOutlet UILabel *predictiveTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;

@end
