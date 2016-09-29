//
//  SelfInfoViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/26.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "SelfInfoViewController.h"
#import "PeopleInfo.h"
#import "XMNPhotoPickerFramework.h"
#import "VPImageCropperViewController.h"
@interface SelfInfoViewController ()<UINavigationControllerDelegate,VPImageCropperDelegate>
@property (strong, nonatomic)PeopleInfo     *peopleInfo;
@property (strong, nonatomic)UIImageView    *faceImage;
@property (strong, nonatomic)UITapGestureRecognizer *ges;
@property (strong, nonatomic)VPImageCropperViewController *firVC;

@end

@implementation SelfInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rdv_tabBarController.tabBarHidden=YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rdv_tabBarController.tabBarHidden=NO;
}
- (void)setUI{
    [self.view addSubview:self.faceImage];
    if (self.peopleInfo.photo.length>0) {
        NSString *urlString=[NSString stringWithFormat:@"http://139.129.218.191:8080/web/%@",self.peopleInfo.photo];
        NSURL *url=[NSURL URLWithString:urlString];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *image=[UIImage imageWithData:data];
        _faceImage.image =image;
    }
    [_faceImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
    [_faceImage autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_faceImage autoSetDimensionsToSize:CGSizeMake(110*BalanceWidth, 110*BalanceWidth)];
    [self creatLabel:self.peopleInfo.peopleName withIndex:0];
    [self creatLabel:self.peopleInfo.position withIndex:1];
    [self creatLabel:self.peopleInfo.teamName withIndex:2];
    [self creatLabel:self.peopleInfo.groupName withIndex:3];
    [self creatLabel:self.peopleInfo.phone withIndex:4];
}
- (void)creatLabel:(NSString *)message withIndex:(NSInteger)index{
    UILabel *label=[[UILabel alloc]initForAutoLayout];
    label.text=message;
    label.textColor=[UIColor darkGrayColor];
    label.font=[UIFont systemFontOfSize:16];
    label.textAlignment=NSTextAlignmentCenter;
    label.backgroundColor=[UIColor swpColorFromHEX:0xff5927];
    label.layer.cornerRadius=5;
    label.clipsToBounds=YES;
    [self.view addSubview:label];
    [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40];
    [label autoSetDimension:ALDimensionHeight toSize:30];
    [label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.faceImage withOffset:30+50*index+8*index];
    
}

#pragma mark ---VPImageCropperDelegate
- (void)imageCropper:(VPImageCropperViewController *)cropperViewController didFinished:(UIImage *)editedImage{
    [_firVC dismissViewControllerAnimated:YES completion:nil];
    [SVProgressHUD showWithStatus:@"正在上传"];
    NSData* imageData=UIImageJPEGRepresentation(editedImage, 0.3);
    NSDictionary *dic=@{
                        @"peopleId":GetUserDefault(peopleId)
                        };
    
    [SwpRequest swpPOSTAddFile:@"http://139.129.218.191:8080/web/contacts/uploadPhoto" parameters:dic isEncrypt:NO fileName:@"photo" fileData:imageData swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        self.peopleInfo.photo=[resultObject objectForKey:@"message"];
        [self setUI];
        [SVProgressHUD showSuccessWithStatus:@"上传成功"];
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
}

- (void)imageCropperDidCancel:(VPImageCropperViewController *)cropperViewController{
     [_firVC dismissViewControllerAnimated:YES completion:nil];
    return;
}
- (PeopleInfo *)peopleInfo{
    if (!_peopleInfo) {
        
        _peopleInfo=[[PeopleInfo alloc]init];
        [_peopleInfo mj_setKeyValues:GetUserDefault(myInfoDic)];
    }
    return _peopleInfo;
}

- (UIImageView *)faceImage{
    if (!_faceImage) {
        _faceImage=[[UIImageView alloc]initForAutoLayout];
        _faceImage.userInteractionEnabled=YES;
        _faceImage.layer.cornerRadius=55*BalanceWidth;
        _faceImage.clipsToBounds=YES;
        _faceImage.image=[UIImage imageNamed:@"placeholderImage"];
        [_faceImage addGestureRecognizer:self.ges];

    }
    return _faceImage;
}

- (UITapGestureRecognizer *)ges{
    if (!_ges) {
        _ges=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesAction)];
        
    }
    return _ges;
}

- (void)gesAction{

     [XMNPhotoPicker sharePhotoPicker].frame=CGRectMake(0, -64, SCREEN_WIDTH, SCREEN_HEIGHT);
     [XMNPhotoPicker sharePhotoPicker].maxCount=1;
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
         _firVC=[[VPImageCropperViewController alloc]initWithImage:image cropFrame:CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200) limitScaleRatio:2];
         _firVC.delegate=self;
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.36 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self presentViewController:_firVC animated:YES completion:nil];
         });
     }
     
     }];
     //4. 显示XMNPhotoPicker
     [[XMNPhotoPicker sharePhotoPicker] showPhotoPickerwithController:self animated:YES];
     
}
@end
