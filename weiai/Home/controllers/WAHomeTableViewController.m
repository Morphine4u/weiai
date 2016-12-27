//
//  WAHomeTableViewController.m
//  weiai
//
//  Created by Morphine on 2016/10/7.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WAHomeTableViewController.h"
#import "WADatePickerViewController.h"
#import "WADatePickerView.h"
#import "WAHistoryDataManager.h"

@interface WAHomeTableViewController ()<WADatePickerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
//    NSDate *_recordDate;
}
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

- (IBAction)touchHeaderView:(id)sender;
- (IBAction)recordStartTime:(id)sender;


@end

@implementation WAHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.recordDic = [NSMutableDictionary dictionary];
//    _recordDate = [[NSDate alloc] init];
    
//    //获取通知中心单例对象
//    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
//    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
//    [center addObserver:self selector:@selector(notice:) name:@"changePredictiveDate" object:nil];
    
    
    NSArray *documentDirectory=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath =[documentDirectory objectAtIndex:0];
    NSString *latelyDateFile = @"latelyDate.plist";
    NSString *latelyDateFilePath=[documentPath stringByAppendingPathComponent:latelyDateFile];
    if (latelyDateFilePath) {
//        NSMutableArray *latelyDateArray = [NSMutableArray arrayWithCapacity:1];
       NSMutableArray *latelyDateArray = [NSMutableArray arrayWithContentsOfFile:latelyDateFilePath];
        NSDate *latelyDate = latelyDateArray[0];
        //---------------------改变主页的日期和天数--------------
        // 格式化日期格式
        NSDateFormatter *formatter = [NSDateFormatter new];
        // 设置显示的格式     这里的格式 2016 / 08 / 08
        [formatter setDateFormat:@"YYYY/MM/dd"];
        
        NSDate *date = [latelyDate dateByAddingTimeInterval:28*24*60*60];
        // UIDatePicker 滚动也就是日期改变 我们就改变对应的 textFile 的 text
        self.predictiveTimeLabel.text = [formatter stringFromDate:date];
        //    NSTimeInterval interval = [date timeIntervalSinceDate:[NSDate date]];
        NSTimeInterval interval = [date timeIntervalSinceNow];
        NSString *day = [NSString stringWithFormat:@"%.0f",interval/(24*60*60)];
//        NSLog(@"%@",day);
        
        self.daysLabel.text = day;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

#pragma mark - 更换头视图
- (IBAction)touchHeaderView:(id)sender {
    [self showActionSheet];
}

- (IBAction)recordStartTime:(id)sender {
    WADatePickerView *datePickerView = [WADatePickerView sharedWADatePickerView];
//    datePickerView.frame = CGRectMake(0, 667, 375, 667);
    datePickerView.datePicker.maximumDate = [NSDate date];
    datePickerView.datePickerDelegate = self;
    [datePickerView show];
}
#pragma mark - WADatePickerDelegate
- (void)saveDataWith:(NSDate *)date{
    
//    _recordDate = date;
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"YYYY/MM/dd"];
    NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
    [f1 setDateFormat:@"YYYYMMdd"];
    //    第一步:获得文件即将保存的路径:
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentPath = [documentDirectory objectAtIndex:0];

    //保存最近一次的开始日期
    NSString *latelyDateFile = @"latelyDate.plist";
    NSString *latelyDateFilePath=[documentPath stringByAppendingPathComponent:latelyDateFile];
//    NSMutableArray *latelyDateArray = [NSMutableArray arrayWithCapacity:1];
    NSMutableArray *latelyDateArray = [WAHistoryDataManager addDataWithFilePath:latelyDateFilePath andDate:date andDictionary:nil];
    

    
        //通知 预测日期和天数 改变值
    NSDate *latelyDate = [latelyDateArray objectAtIndex:0];
        NSDate *date1 = [latelyDate dateByAddingTimeInterval:28*24*60*60];
//        [latelyDateArray replaceObjectAtIndex:0 withObject:date1];
        // UIDatePicker 滚动也就是日期改变 我们就改变对应的 textFile 的 text
        self.predictiveTimeLabel.text = [f stringFromDate:date1];
        //    NSTimeInterval interval = [date timeIntervalSinceDate:[NSDate date]];
        NSTimeInterval interval = [date1 timeIntervalSinceNow];
        NSString *day = [NSString stringWithFormat:@"%.0f",interval/(24*60*60)];
//        NSLog(@"%@",day);
    
        self.daysLabel.text = day;
        

    
    
    //------------------保存数据到历史记录------------------
    
    //    　　第二步:生成在该路径下的文件:
    NSString *historyFile = @"history.plist";
    NSString *historyFilePath=[documentPath stringByAppendingPathComponent:historyFile];//fileName就是保存文件的文件名
    

    
        NSString *startDate = [f stringFromDate:date];
        NSString *num = [f1 stringFromDate:date];

        [self.recordDic setValue:startDate forKey:@"startDate"];
    
        [self.recordDic setValue:@"" forKey:@"endDate"];
    
//        NSString *times = [NSString stringWithFormat:@"%lu",(unsigned long)[historyArray count]+1];
        [self.recordDic setValue:@"" forKey:@"times"];
        [self.recordDic setValue:num forKey:@"number"];
    
//        [historyArray insertObject:self.recordDic atIndex:0];
    
    
    [WAHistoryDataManager addDataWithFilePath:historyFilePath andDate:date andDictionary:self.recordDic];
 

}
- (void)closeDatePicker:(NSDate *)date{
    
}
- (void)showActionSheet {
        
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"更换背景图片"preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        NSLog(@"拍照");
        [self openCamera];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        NSLog(@"从相册选择");
        [self openPhoto];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"保存图片至相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        NSLog(@"保存图片");
        
        UIImage *savedImage = [UIImage imageNamed:@"background1"];
        
        [self saveImageToPhotos:savedImage];
    }];
    // 创建按钮
    // 注意取消按钮只能添加一个
    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
        // 点击按钮后的方法直接在这里面写
        NSLog(@"取消");
    }];
    
    // 创建警告按钮
//    UIAlertAction *structlAction1 = [UIAlertAction actionWithTitle:@"警告" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *action) {
//        NSLog(@"警告");
//    }];
    
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    [actionSheet addAction:cancelAction1];
    //    [actionSheet addAction:structlAction1];
    
    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
    //    [self presentViewController:alertController animated:YES completion:nil];
    [self presentViewController:actionSheet animated:YES completion:nil];

}
- (void)openCamera {
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        //来源:相机
        sourceType = UIImagePickerControllerSourceTypeCamera;
        
    }

    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];
}
- (void)openPhoto {
    NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //来源:相册
    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // 跳转到相机或相册页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
    }];

}
- (void)saveImageToPhotos:(UIImage*)image {
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo {
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
        
    }else{
        
        msg = @"保存图片成功" ;
        
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                          
                                                    message:msg
                          
                                                   delegate:self
                          
                                          cancelButtonTitle:@"确定"
                          
                                          otherButtonTitles:nil];
    
    [alert show];
    
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.backgroundView.image = image;
}
@end
