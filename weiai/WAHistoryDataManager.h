//
//  WAHistoryDataManager.h
//  weiai
//
//  Created by Morphine on 2016/10/12.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WAHistoryDataManager : NSObject


+ (NSMutableArray *)addDataWithFilePath:(NSString *)filePath andDate:(NSDate *)date andDictionary:(NSMutableDictionary *)dic;
+ (NSMutableArray *)modifyDataWithFilePath:(NSString *)filePath andDate:(NSDate *)date andCell:(id)cell andLeftOrRightTextField:(NSString *)string;
+ (NSMutableArray *)deleteDataWithFilePath:(NSString *)filePath andDate:(NSDate *)date andDictionary:(NSMutableDictionary *)dic;
@end
