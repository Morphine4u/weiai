//
//  WAHistoryDataManager.m
//  weiai
//
//  Created by Morphine on 2016/10/12.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WAHistoryDataManager.h"
#import "WAHistoryCell.h"
@interface WAHistoryDataManager ()
{
    UIView *_alertView;
}
- (void)showAlertView;
@end
@implementation WAHistoryDataManager

+ (NSMutableArray *)addDataWithFilePath:(NSString *)filePath andDate:(NSDate *)date andDictionary:(NSMutableDictionary *)dic{
    
//    //    第一步:获得文件即将保存的路径:
//    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *documentPath = [documentDirectory objectAtIndex:0];
    
    
    NSMutableArray *array = [NSMutableArray array];
#warning  //不加这个判断 就读不出文件？？？
    if ([NSMutableArray arrayWithContentsOfFile:filePath]) {
        
        array = [NSMutableArray arrayWithContentsOfFile:filePath];
        //        NSLog(@"-------------%@",latelyDateArray);
    }
    
    
    //区分是latelyDate.plist还是history.plist
    NSString *str = [filePath substringFromIndex:filePath.length-16];
    NSString *str1 = [filePath substringFromIndex:filePath.length-13];
    //latelyDate.plist
    if ([str isEqualToString:@"latelyDate.plist"]) {
        
        if (array.count == 0 || [date timeIntervalSinceDate:array[0]] > 0) {
            
            [array insertObject:date atIndex:0];
            [array writeToFile:filePath atomically:YES];
        }
        return array;
        //history.plist
    }else if ([str1 isEqualToString:@"history.plist"]){
        
        [array insertObject:dic atIndex:0];
        
        //计算times
        NSString *times = [NSString stringWithFormat:@"%lu",(unsigned long)array.count];
        [array[0] setValue:times forKey:@"times"];
        NSString *num = [dic objectForKey:@"number"];
        int a=0;
        for (int i=0; i<array.count; i++) {
            //调整次数
            if ([num intValue] < [[array[i] objectForKey:@"number"] intValue]) {
                //这次日期较小 num=大的次数
                int n = [[array[i] objectForKey:@"times"] intValue];
                [array[i] setValue:[NSString stringWithFormat:@"%d",n+1] forKey:@"times"];
                [array[a] setValue:[NSString stringWithFormat:@"%d",n] forKey:@"times"];
                [array exchangeObjectAtIndex:a withObjectAtIndex:i];
                a=i;
            }
            
        }
        
        
        //计算cycle
        if (array.count > 1) {
            NSDateFormatter *f = [[NSDateFormatter alloc] init];
            [f setDateFormat:@"YYYY/MM/dd"];
            //本次时间
            //            NSString *date = [historyArray[a] objectForKey:@"startDate"];
            
            //新日期小 a=i
            if (a != 0) {
                
                //下次时间
                NSString *nextDate = [array[a-1] objectForKey:@"startDate"];
                //下次cycle=
                NSString *nextCycle = [NSString stringWithFormat:@"%.0f",[[f dateFromString:nextDate] timeIntervalSinceDate:date]/(24*60*60) ];
                [array[a-1] setValue:nextCycle forKey:@"cycle"];
            }
            
            if (a != array.count-1) {
                //这次cycle= 这次date-上次date
                //上次时间
                NSString *lastDate = [array[a+1] objectForKey:@"startDate"];
                
                NSString *cycle = [NSString stringWithFormat:@"%.0f",[date timeIntervalSinceDate:[f dateFromString:lastDate]]/(24*60*60) ];
                [array[a] setValue:cycle forKey:@"cycle"];
            }
            
        }
        //往文件中写入数据
        [array writeToFile:filePath atomically:YES];
    }
    
    
    return array;
}
+ (NSMutableArray *)modifyDataWithFilePath:(NSString *)filePath andDate:(NSDate *)date andCell:(id)cell andLeftOrRightTextField:(NSString *)string {
    
    WAHistoryCell *clickedCell = (WAHistoryCell *)cell;
    
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"YYYY/MM/dd"];
    NSString *dateStr = [f stringFromDate:date];
    NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
    [f1 setDateFormat:@"YYYYMMdd"];
    NSString *num = [f1 stringFromDate:date];
    
    NSMutableArray *historyArray = [NSMutableArray array];
    if ([NSMutableArray arrayWithContentsOfFile:filePath]) {
        
        historyArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    }
    if ([string isEqualToString:@"start"]) {
        //修改开始日期和序号
        [[historyArray objectAtIndex:clickedCell.indexPath.row-1] setValue:dateStr forKey:@"startDate"];
        [[historyArray objectAtIndex:clickedCell.indexPath.row-1] setValue:num forKey:@"number"];
        
        //调整位置 点击的位置a  i是比a的日期小的第一个位置
        int a = (int)clickedCell.indexPath.row-1;
        for (int i=0; i<historyArray.count; i++) {
            //调整次数
            
            if ([num intValue] > [[historyArray[i] objectForKey:@"number"] intValue]){
                int n = [[historyArray[i] objectForKey:@"times"] intValue];
                
                //插入到i位置 取代times
                [historyArray[a] setValue:[NSString stringWithFormat:@"%d",n] forKey:@"times"];
                [historyArray insertObject:historyArray[a] atIndex:i];
                if (a > i) {
                    [historyArray removeObjectAtIndex:a+1];
                    //a和i（包括i）之间的times都-1
                    for (int j = i+1; j<=a; j++) {
                        int oldTimes = [[historyArray[j] objectForKey:@"times"] intValue];
                        NSString *newTimes = [NSString stringWithFormat:@"%d",oldTimes-1];
                        [historyArray[j] setValue:newTimes forKey:@"times"];
                    }
                    
                } else if (a < i) {
                    [historyArray removeObjectAtIndex:a];
                    //a和i之间的times都+1
                    for (int j = a+1; j<i; j++) {
                        int oldTimes = [[historyArray[j] objectForKey:@"times"] intValue];
                        NSString *newTimes = [NSString stringWithFormat:@"%d",oldTimes+1];
                        [historyArray[j] setValue:newTimes forKey:@"times"];
                    }
                    
                }
                break;
                
            }else if (i == historyArray.count-1 && [num intValue] < [[historyArray[i] objectForKey:@"number"] intValue]) {
                //插入到i位置 取代times
                [historyArray[a] setValue:[NSString stringWithFormat:@"%d",1] forKey:@"times"];
                [historyArray addObject:historyArray[a]];
                if (a <= i) {
                    [historyArray removeObjectAtIndex:a];
                }
                //i位置之前的times都+1
                for (int j = a; j<i; j++) {
                    int oldTimes = [[historyArray[j] objectForKey:@"times"] intValue];
                    NSString *newTimes = [NSString stringWithFormat:@"%d",oldTimes+1];
                    [historyArray[j] setObject:newTimes forKey:@"times"];
                }
                break;
                
            }else if (a != i && [num intValue] == [[historyArray[i] objectForKey:@"number"] intValue]) {
                NSLog(@"已登记过");
                break;
            }
            
            
        }

        //计算周期
        
        for (int i=0; i<historyArray.count; i++) {
            if (i != historyArray.count-1) {
                
                //本次开始日期
                NSString *start = [historyArray[i] objectForKey:@"startDate"];
                NSDate *startDate = [f dateFromString:start];
                //上次开始日期
                NSString *lastStart = [historyArray[i+1] objectForKey:@"startDate"];
                NSDate *lastStartDate = [f dateFromString:lastStart];
                double difference = [startDate timeIntervalSinceDate:lastStartDate]/(24*60*60);
                //赋值本次cycle
                [historyArray[i] setValue:[NSString stringWithFormat:@"%.0f",difference] forKey:@"cycle"];
            } else {
                [historyArray[i] setValue:@"" forKey:@"cycle"];
            }
        }
        
    }else if ([string isEqualToString:@"end"]){
        NSString *start = [[historyArray objectAtIndex:clickedCell.indexPath.row-1] objectForKey:@"startDate"];
        NSDate *startDate = [f dateFromString:start];
        NSTimeInterval a = [date timeIntervalSinceDate:startDate];
        if (a <= 0) {
//            NSLog(@"登记信息有误！");
            [[[self alloc] init] showAlertView];
            
            return nil;
        } else {
        [[historyArray objectAtIndex:clickedCell.indexPath.row-1] setValue:dateStr forKey:@"endDate"];
        }
    }
    [historyArray writeToFile:filePath atomically:YES];

    return historyArray;
}
+ (NSMutableArray *)deleteDataWithFilePath:(NSString *)filePath andDate:(NSDate *)date andDictionary:(NSMutableDictionary *)dic {
    
    return nil;
}
- (void)showAlertView {
    _alertView = [[UIView alloc] initWithFrame:CGRectMake(375/2.0-200/2.0, 667/2.0, 200, 60)];
    _alertView.backgroundColor = [UIColor blackColor];
    _alertView.layer.cornerRadius = 0.5;
    UILabel *label = [[UILabel alloc] initWithFrame:_alertView.bounds];
    label.text = @"登记信息有误";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    
    [_alertView addSubview:label];
    [[UIApplication sharedApplication].keyWindow addSubview:_alertView];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(closeAlertView) userInfo:nil repeats:NO];
}
- (void)closeAlertView {
    [_alertView removeFromSuperview];
}
@end
