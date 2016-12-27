//
//  WAPhotoCollectionViewController.h
//  weiai
//
//  Created by Morphine on 2016/10/17.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WAPhotoCollectionViewController : UICollectionViewController
@property (weak, nonatomic) IBOutlet UIButton *editButton;

- (IBAction)addPhotos:(UIButton *)sender;
- (IBAction)editPhotos:(UIButton *)sender;

+ (WAPhotoCollectionViewController *)sharedWAPhotoCollectionViewController;
@end
