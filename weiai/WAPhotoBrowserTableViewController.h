//
//  WAPhotoBrowserTableViewController.h
//  weiai
//
//  Created by Morphine on 2016/10/22.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAPhotoBrowserTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *imageArray;/**<图片数组*/
@property (nonatomic, strong) NSArray *frameArray;///<在collectionview里的frame数组
///显示的图片在collectionview中的indexpath
@property (nonatomic, strong) NSIndexPath *indexPath;
- (void)show;
@end
