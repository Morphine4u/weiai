//
//  WASettingTableViewController.m
//  weiai
//
//  Created by Morphine on 2016/10/16.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WASettingTableViewController.h"

@interface WASettingTableViewController ()

@end

@implementation WASettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 2;
    }
    return 1;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (0) {
        
    } else if (indexPath.section == 3) {
        [self logOut];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
- (void)logOut {
    // 初始化一个一个UIAlertController
    // 参数preferredStyle:是IAlertController的样式
    // UIAlertControllerStyleAlert 创建出来相当于UIAlertView
    // UIAlertControllerStyleActionSheet 创建出来相当于 UIActionSheet
    //    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"静" preferredStyle:(UIAlertControllerStyleAlert)];
    //
    //    // 创建按钮
    //    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
    //        NSLog(@"确定");
    //    }];
    //    // 创建按钮
    //    // 注意取消按钮只能添加一个
    //    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
    //        // 点击按钮后的方法直接在这里面写
    //        NSLog(@"取消");
    //    }];
    //
    //    // 创建警告按钮
    //    UIAlertAction *structlAction = [UIAlertAction actionWithTitle:@"警告" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *action) {
    //        NSLog(@"警告");
    //    }];
    //
    //    // 添加按钮 将按钮添加到UIAlertController对象上
    //    [alertController addAction:okAction];
    //    [alertController addAction:cancelAction];
    //    [alertController addAction:structlAction];
    //
    //    // 只有在UIAlertControllerStyleAlert情况下才可以添加文本框
    //    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
    //        textField.placeholder = @"用户名";
    //        textField.secureTextEntry = YES;
    //    }];
    //    // 取出文本
    //    UITextField *text = alertController.textFields.firstObject;
    //    UIAlertAction *action = alertController.actions.firstObject;
    

    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"退出后不会删除数据"preferredStyle:UIAlertControllerStyleActionSheet];
    
        // 创建按钮
    // 注意取消按钮只能添加一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        // 点击按钮后的方法直接在这里面写
        NSLog(@"取消");
    }];
    
    // 创建警告按钮
    UIAlertAction *structlAction = [UIAlertAction actionWithTitle:@"退出登录" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *action) {
        NSLog(@"退出登录");
        UIAlertController *alerView = [UIAlertController alertControllerWithTitle:nil message:@"已退出该账号!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alerView addAction:sureAction];
        [self presentViewController:alerView animated:YES completion:nil];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"logIn"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }];
    

    [actionSheet addAction:cancelAction];
    [actionSheet addAction:structlAction];
    
    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
    //    [self presentViewController:alertController animated:YES completion:nil];
    [self presentViewController:actionSheet animated:YES completion:nil];

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
