//
//  WAPhotoBrowserTableViewController.m
//  weiai
//
//  Created by Morphine on 2016/10/22.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WAPhotoBrowserTableViewController.h"
#import "WAPhotoBrowserTableViewCell.h"

@interface WAPhotoBrowserTableViewController ()<PhotoDelegate>
{
    
}
@end

@implementation WAPhotoBrowserTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//分割线没旋转，设为无分割线
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setShowsHorizontalScrollIndicator:NO];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    self.tableView.pagingEnabled = YES;
//    self.tableView.allowsSelection = NO;
    [self.tableView registerClass:[WAPhotoBrowserTableViewCell class] forCellReuseIdentifier:@"photoBrowser"];
    [self.tableView scrollToRowAtIndexPath:self.indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"openAnimation"];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)show{
    
    //借助UIApplication中的window
    UIApplication *app = [UIApplication sharedApplication];
    UIWindow *window = app.keyWindow;
    [window addSubview:self.tableView];
    
//    //记住视图控制器
//    [window.rootViewController addChildViewController:self];
    
    [self performSelector:@selector(changeBackgroundColor) withObject:nil afterDelay:0.5];

}
- (void)changeBackgroundColor {
    self.tableView.backgroundColor = [UIColor blackColor];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.imageArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"photoBrowser";
    
    WAPhotoBrowserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[WAPhotoBrowserTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        cell.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    }

    cell.delegate = self;
    
    cell.convertFrame = [self.frameArray[indexPath.row] CGRectValue];
    cell.image.image = _imageArray[indexPath.row];
    // Configure the cell...
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [UIScreen mainScreen].bounds.size.width;
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath {
//    NSLog(@"%@",indexPath);
    WAPhotoBrowserTableViewCell *photoCell = (WAPhotoBrowserTableViewCell *)cell;
    photoCell.scrollView.zoomScale = 1.0;
}
- (void)singleTap:(WAPhotoBrowserTableViewCell *)cell {
    self.tableView.backgroundColor = [UIColor clearColor];
}
- (void)endScan:(WAPhotoBrowserTableViewCell *)cell {
    // 1) 清除根视图
    [self.tableView removeFromSuperview];
    // 2) 清除子视图控制器
//    [self removeFromParentViewController];
}
//#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"%f",scrollView.contentOffset.y);
//    if (scrollView.contentOffset.y < 0) {
//        scrollView.contentOffset = CGPointMake(0, 0);
//        
//    }
//}
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
