//
//  WAHistoryTableViewController.m
//  weiai
//
//  Created by Morphine on 2016/10/9.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WAHistoryTableViewController.h"
#import "WARecordModel.h"
#import "WAHistoryDataManager.h"


@interface WAHistoryTableViewController ()
{
    NSMutableArray *_dataArray;
    
//    NSIndexPath *_indexPath;
    WAHistoryCell *_clickedCell;
    NSString *_fieldString;
}
@property (weak, nonatomic) IBOutlet UILabel *averageCycle;

@end

@implementation WAHistoryTableViewController

//static WAHistoryTableViewController *sharedWAHistoryTableViewControllerInstance = nil;
//
//+ (WAHistoryTableViewController *)sharedWAHistoryTableViewController {
//    @synchronized(self) {
//        static dispatch_once_t history;
//        dispatch_once(&history, ^{
////            instance = [[self alloc] init];
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            sharedWAHistoryTableViewControllerInstance = (WAHistoryTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"historyTVC"];
//});
//}
//    return sharedWAHistoryTableViewControllerInstance;
//}
//+ (WAHistoryTableViewController *)sharedWAHistoryTableViewController {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    WAHistoryTableViewController *historyTVC = (WAHistoryTableViewController *)[storyboard instantiateViewControllerWithIdentifier:@"historyTVC"];
//    return historyTVC;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSArray *documentDirectory=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath =[documentDirectory objectAtIndex:0];
    NSString *fileName = @"history.plist";
    NSString *filePath=[documentPath stringByAppendingPathComponent:fileName];
    if (filePath) {
        //取出数据
        NSMutableArray *historyArray = [NSMutableArray arrayWithContentsOfFile:filePath];
        _dataArray = historyArray;
        
        if (historyArray.count > 1) {
            int sum=0;
            for (int i=0; i<historyArray.count-1; i++) {
                int cycle = [[historyArray[i] objectForKey:@"cycle"] intValue];
                sum += cycle;
            }
            
            self.averageCycle.text = [NSString stringWithFormat:@"%.0lu",sum/(historyArray.count-1)];
        }
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 30;
    } else {
        return 50;
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _dataArray.count+1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
//    UITableViewCell *cell = nil;
    
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleCell" forIndexPath:indexPath];
        return cell;
        
    }else{
        WARecordModel *model = [[WARecordModel alloc] initWithDictionary:[_dataArray objectAtIndex:indexPath.row-1]];
        
        WAHistoryCell *cell = (WAHistoryCell *)[tableView dequeueReusableCellWithIdentifier:@"historyCell" forIndexPath:indexPath];
        cell.model = model;
        cell.indexPath = indexPath;
        cell.delegate = self;
        return cell;
    }
    
    // Configure the cell...
    
//    return cell;
}
#pragma mark - CellReloadTextFieldDelegate
- (void)reloadTextFieldWithCell:(WAHistoryCell *)cell whichTextField:(NSString *)textFieldString{
    _clickedCell = cell;
    _fieldString = textFieldString;
    
    
    WADatePickerView *datePickerView = [WADatePickerView sharedWADatePickerView];
    
    datePickerView.datePickerDelegate = self;
    
    
        
    datePickerView.datePicker.maximumDate = [NSDate date];
    //        datePickerView.frame = CGRectMake(0, 667, 375, 667);
    [datePickerView show];
    
}
#pragma mark - WADatePickerDelegate
- (void)saveDataWith:(NSDate *)date{
    
    NSArray *documentDirectory=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath =[documentDirectory objectAtIndex:0];
    NSString *historyFile = @"history.plist";
    NSString *historyFilePath = [documentPath stringByAppendingPathComponent:historyFile];
    
//    NSDateFormatter *f = [[NSDateFormatter alloc] init];
//    [f setDateFormat:@"YYYY/MM/dd"];
//    NSString *dateStr = [f stringFromDate:date];
//    NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
//    [f1 setDateFormat:@"YYYYMMdd"];
//    NSString *num = [f1 stringFromDate:date];


//    WAHistoryCell *cell = (WAHistoryCell *)[self.tableView cellForRowAtIndexPath:_indexPath];//为什么cell=nil
    
    //刷新数据
    if ((_dataArray = [WAHistoryDataManager modifyDataWithFilePath:historyFilePath andDate:date andCell:_clickedCell andLeftOrRightTextField:_fieldString])) {
        
        [self.tableView reloadData];
        
    }
    //刷新平均周期
    if ([_fieldString isEqualToString:@"start"]) {
        if (_dataArray.count > 1) {
            int sum=0;
            for (int i=0; i<_dataArray.count-1; i++) {
                int cycle = [[_dataArray[i] objectForKey:@"cycle"] intValue];
                sum += cycle;
            }
            
            self.averageCycle.text = [NSString stringWithFormat:@"%.0lu",sum/(_dataArray.count-1)];
        }
    }
}
- (void)closeDatePicker:(NSDate *)date{
}

@end
