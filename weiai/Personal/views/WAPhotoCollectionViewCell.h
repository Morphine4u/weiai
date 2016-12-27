//
//  WAPhotoCollectionViewCell.h
//  weiai
//
//  Created by Morphine on 2016/10/17.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CollectionViewCellDelegate;

@interface WAPhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, strong) id<CollectionViewCellDelegate> delegate;
- (IBAction)deletePhotos:(UIButton *)sender;
@end

@protocol CollectionViewCellDelegate <NSObject>

@optional
- (void)deletePhotos:(WAPhotoCollectionViewCell *)cell;

@end
