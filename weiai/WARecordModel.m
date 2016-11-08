//
//  WARecordModel.m
//  weiai
//
//  Created by Morphine on 2016/10/9.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WARecordModel.h"

@implementation WARecordModel

- (instancetype)initWithDictionary:(NSDictionary *)dataDictionary {
    
    self = [[WARecordModel alloc] init];
    if (self) {
        
        self.times = [dataDictionary valueForKey:@"times"];
        self.startDate = [dataDictionary valueForKey:@"startDate"];
        self.endDate = [dataDictionary valueForKey:@"endDate"];
        self.cycle = [dataDictionary valueForKey:@"cycle"];
        self.number = [dataDictionary valueForKey:@"number"];
    }
    return self;
}
@end
