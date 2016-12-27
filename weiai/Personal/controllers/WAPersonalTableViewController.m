//
//  WAPersonalTableViewController.m
//  weiai
//
//  Created by Morphine on 2016/10/15.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WAPersonalTableViewController.h"
#import "WAInformationTableViewController.h"
#import "WALogInTableViewController.h"
#import "WAPhotoCollectionViewController.h"

@interface WAPersonalTableViewController ()

@end

@implementation WAPersonalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"logIn"]) {
        //已登录
        self.prompt.hidden = YES;
        self.header.userInteractionEnabled = NO;
        self.header.image = [UIImage imageNamed:@"touxiang"];
        
    } else {
        //未登录
        self.header.userInteractionEnabled = YES;
        self.prompt.hidden = NO;
        self.header.image = [UIImage imageNamed:@"touxiang_nan"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 5;
    }
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
 
    // Configure the cell...
    
    return cell;
}
*/
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 150;
    } else if (indexPath.section == 1) {
        return 50;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BOOL logIn = [[NSUserDefaults standardUserDefaults] boolForKey:@"logIn"];
    if (logIn) {
        //已登录 进入个人信息
        if (indexPath.section == 0) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                WAInformationTableViewController *informationTVC = (WAInformationTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"informationTVC"];
            [self.navigationController pushViewController:informationTVC animated:YES];
            
        } else if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                WAPhotoCollectionViewController *photoCVC = [WAPhotoCollectionViewController sharedWAPhotoCollectionViewController];
                [self.navigationController pushViewController:photoCVC animated:YES];
            }
        }
    } else if (!logIn) {
        
    }
     [tableView deselectRowAtIndexPath:indexPath animated:NO]; 
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
