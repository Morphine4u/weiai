//
//  WALogInTableViewController.h
//  weiai
//
//  Created by Morphine on 2016/10/15.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WALogInTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *account;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)closeLogIn:(UIButton *)sender;
- (IBAction)logIn:(UIButton *)sender;

@end
