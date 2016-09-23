//
//  AddressListViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "AddressListViewController.h"
#import "XMNPhotoPickerFramework.h"
@interface AddressListViewController ()

@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromNet];
    [self setUI];
    
}

- (void)setUI{
    [self setNavigationBarTitle:@"通讯录" textColor:[UIColor whiteColor] titleFontSize:@20];

}
//    139.129.218.191:mis/contacts/images/photo/1002045100001.png
//    :8080/web/contacts/getAllByPeopleId
//     1002045100001
/* //    1. 推荐使用XMNPhotoPicker 的单例
 //    2. 设置选择完照片的block回调
 [XMNPhotoPicker sharePhotoPicker].frame=CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT);
 [XMNPhotoPicker sharePhotoPicker].maxCount=3;
 [XMNPhotoPicker sharePhotoPicker].pickingVideoEnable=NO;
 [[XMNPhotoPicker sharePhotoPicker] setDidFinishPickingPhotosBlock:^(NSArray<UIImage *> *images, NSArray<XMNAssetModel *> *assets) {
 NSMutableArray *myImages=[NSMutableArray arrayWithArray:images];
 id image=myImages[0];
 if (myImages.count<=0||[image isKindOfClass:[XMNAssetModel class]]) {
 for (XMNAssetModel *model in assets) {
 UIImage *image=model.originImage;
 [myImages addObject:image];
 }
 }
 for (UIImage *image in myImages) {
 NSData* imageData=UIImageJPEGRepresentation(image, 0.3);
 NSDictionary *dic=@{
 @"peopleId":@"1002045100001"
 };
 [SwpRequest swpPOSTAddFile:@"http://139.129.218.191:8080/web/contacts/uploadPhoto" parameters:dic isEncrypt:NO fileName:@"photo" fileData:imageData swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
 
 } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
 
 }];
 }
 
 }];
 //4. 显示XMNPhotoPicker
 [[XMNPhotoPicker sharePhotoPicker] showPhotoPickerwithController:self animated:YES];
 */
- (void)getDataFromNet{


}
@end
