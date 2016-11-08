//
//  WAPersonalTableViewController.h
//  weiai
//
//  Created by Morphine on 2016/10/15.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAPersonalTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIImageView *header;
@property (weak, nonatomic) IBOutlet UILabel *account;
@property (weak, nonatomic) IBOutlet UIImageView *levelIcon;
@property (weak, nonatomic) IBOutlet UILabel *waMoney;
@property (weak, nonatomic) IBOutlet UILabel *prompt;

@end
