//
//  WAPhotoBrowserTableViewCell.h
//  weiai
//
//  Created by Morphine on 2016/10/22.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WAPhotoBrowserTableViewCell;

@protocol PhotoDelegate <NSObject>

- (void)singleTap:(WAPhotoBrowserTableViewCell *)cell;
- (void)endScan:(WAPhotoBrowserTableViewCell *)cell;
@end


@interface WAPhotoBrowserTableViewCell : UITableViewCell

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *image;

@property (nonatomic, assign) CGRect convertFrame;


@property (nonatomic, strong) id<PhotoDelegate> delegate;
@end
