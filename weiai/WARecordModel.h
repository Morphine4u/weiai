//
//  WARecordModel.h
//  weiai
//
//  Created by Morphine on 2016/10/9.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WARecordModel : NSObject

@property (nonatomic, strong) NSString *times;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *endDate;
@property (nonatomic, strong) NSString *cycle;
@property (nonatomic, strong) NSString *number;

- (instancetype)initWithDictionary:(NSDictionary *)dataDictionary;

@end
