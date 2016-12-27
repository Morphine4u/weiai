//
//  WAPhotoCollectionViewController.m
//  weiai
//
//  Created by Morphine on 2016/10/17.
//  Copyright © 2016年 Morphine. All rights reserved.
//

#import "WAPhotoCollectionViewController.h"
#import "WAPhotoCollectionViewCell.h"
#import "WAPhotoBrowserTableViewController.h"

@interface WAPhotoCollectionViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CollectionViewCellDelegate>
@property (nonatomic, strong)NSMutableArray *images;
@property (nonatomic, strong)NSMutableArray *frames;

@end

@implementation WAPhotoCollectionViewController

//static NSString * const reuseIdentifier = @"imageCell";
static WAPhotoCollectionViewController *sharedWAPhotoCollectionViewControllerInstance = nil;

+ (WAPhotoCollectionViewController *)sharedWAPhotoCollectionViewController {
    @synchronized(self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
//            instance = [[self alloc] init];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            sharedWAPhotoCollectionViewControllerInstance = (WAPhotoCollectionViewController *)[storyboard instantiateViewControllerWithIdentifier:@"photosCVC"];
});
}
    return sharedWAPhotoCollectionViewControllerInstance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    self.collectionView.collectionViewLayout
    // Do any additional setup after loading the view.
    self.images = [NSMutableArray array];
    [self getDocumentImages];
    self.frames = [NSMutableArray arrayWithCapacity:self.images.count];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WAPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.imageView.image = self.images[indexPath.item];
    // Configure the cell
    
    
    //将collectionViewCell视图frame转换成浏览图片TVC的frame
    CGRect convertFrame = [collectionView convertRect:cell.frame toView:[UIApplication sharedApplication].keyWindow];
    [self.frames insertObject:[NSValue valueWithCGRect:convertFrame] atIndex:indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSIndexPath *selectedIndex = [NSIndexPath indexPathForRow:indexPath.item inSection:0];
    
    WAPhotoBrowserTableViewController *photoBTVC = [[WAPhotoBrowserTableViewController alloc] init];
    photoBTVC.imageArray = self.images;
    photoBTVC.indexPath = selectedIndex;//查看大图时 直接让tableview展示此indexpath
    
    photoBTVC.frameArray = self.frames;
    
    [photoBTVC show];
}

//#pragma mark <UICollectionViewDelegate>
// Uncomment this method to specify if the specified item should be highlighted during tracking
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
//	return YES;
//}
//
////定义每个Cell的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGSize size = CGSizeMake(315/4.0,315/4.0);
//    return size;
//}
//
////定义每个Section的四边间距
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
//}
//
////两个cell之间的间距（同一行的cell的间距）
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 2;
//}
////这个是两行cell之间的间距（上下行cell的间距）
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 2;
//}

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

- (IBAction)addPhotos:(UIButton *)sender {
    [self showActionSheet];
}

- (IBAction)editPhotos:(UIButton *)sender {
    if ([self.editButton.titleLabel.text isEqualToString:@"编辑"]) {
        [self.editButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.editButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    } else {
        [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [self.editButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteImages" object:nil userInfo:nil];
}
#pragma mark - CollectionViewCellDelegate
- (void)deletePhotos:(WAPhotoCollectionViewCell *)cell {
    NSIndexPath *deleteIndex = [self.collectionView indexPathForCell:cell];
    [self.images removeObjectAtIndex:deleteIndex.item];
    [self.collectionView deleteItemsAtIndexPaths:@[deleteIndex]];//要先把数据删除再删除cell 然后collectionview自动更新
    
    [self deleteImagesAtIndex:deleteIndex.item];
}
// 读取并存贮到相册
- (void)getDocumentImages {

    // 读取沙盒路径图片
    NSString *imageDir = [NSString stringWithFormat:@"%@/Documents/photos",NSHomeDirectory()];
    NSLog(@"%@",imageDir);
    NSArray *imageNames = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:imageDir error:nil];
    
    // 拿到沙盒路径图片
    for (int i=0; i<imageNames.count; i++) {
        NSString *filePath = [imageDir stringByAppendingPathComponent:imageNames[i]];
        
        UIImage *image = [[UIImage alloc]initWithContentsOfFile:filePath];
        if (image) {
            
            [self.images addObject:image];
        } else {
            NSLog(@"保存里没图片");
        }
    }
    
    NSInteger photoNum = [[NSUserDefaults standardUserDefaults] integerForKey:@"photoNumber"];
    if (photoNum == 0) {
        [[NSUserDefaults standardUserDefaults] setInteger:10000 forKey:@"photoNumber"];//设置10000防止文件按首位数字大小排序
    }
}
- (void)saveImageToPhotos:(UIImage *)image {
    [self.images addObject:image];
    //保存到系统相册
//    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    NSInteger photoNum = [[NSUserDefaults standardUserDefaults] integerForKey:@"photoNumber"];
    //保存到沙盒下
    NSString *imageDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/photos"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![[NSFileManager defaultManager] fileExistsAtPath:imageDir]) {
        [fileManager createDirectoryAtPath:imageDir withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *fileName = [NSString stringWithFormat:@"photo%ld.png",photoNum+1];
    NSString  *imagePath = [imageDir stringByAppendingPathComponent:fileName];
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    
    
    [[NSUserDefaults standardUserDefaults] setInteger:photoNum+1 forKey:@"photoNumber"];
    NSIndexPath *saveIndexPath = [NSIndexPath indexPathForItem:_images.count-1 inSection:0];
//    if (_images.count < 2) {
//        
//        saveIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
//    }
    //可以插入比cell最大indexpath还大的
    [self.collectionView insertItemsAtIndexPaths:@[saveIndexPath]];
//    [self.collectionView reloadData];
}
- (void)deleteImagesAtIndex:(NSInteger)index {
    NSString *imageDir = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/photos"];
    NSArray *imageNames = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:imageDir error:nil];
    NSString *fileName = imageNames[index];
    NSString  *imagePath = [imageDir stringByAppendingPathComponent:fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager removeItemAtPath:imagePath error:NULL]) {
        NSLog(@"删除图片成功");
    }
}
- (void)showActionSheet {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:@"添加图片"preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        NSLog(@"拍照");
        [self openCamera];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        NSLog(@"从相册选择");
        [self openPhoto];
    }];
//    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"保存图片至相册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
//        NSLog(@"保存图片");
//        
//        UIImage *savedImage = [UIImage imageNamed:@"background1"];
//        
//        [self saveImageToPhotos:savedImage];
//    }];
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
//    [actionSheet addAction:action3];
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self saveImageToPhotos:image];
}
@end
