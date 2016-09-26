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
@interface SelfInfoViewController ()<UINavigationControllerDelegate>
@property (strong, nonatomic)PeopleInfo     *peopleInfo;
@property (strong, nonatomic)UIImageView    *faceImage;
@property (strong, nonatomic)UITapGestureRecognizer *ges;

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
        [_faceImage sd_setImageWithURL:url];
    }
    [_faceImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
    [_faceImage autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_faceImage autoSetDimensionsToSize:CGSizeMake(80*BalanceWidth, 80*BalanceHeight)];
    [self creatLabel:self.peopleInfo.peopleName withIndex:0];
    [self creatLabel:self.peopleInfo.position withIndex:1];
    [self creatLabel:self.peopleInfo.teamName withIndex:2];
    [self creatLabel:self.peopleInfo.groupName withIndex:3];
    [self creatLabel:self.peopleInfo.phone withIndex:4];
    [self creatLabel:self.peopleInfo.telephone withIndex:5];
}
- (void)creatLabel:(NSString *)message withIndex:(NSInteger)index{
    UILabel *label=[[UILabel alloc]initForAutoLayout];
    label.text=message;
    label.font=[UIFont systemFontOfSize:16];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];
    [label autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [label autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [label autoSetDimension:ALDimensionHeight toSize:50];
    [label autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.faceImage withOffset:20+50*index];
    
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
        _faceImage.layer.cornerRadius=5;
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
     NSData* imageData=UIImageJPEGRepresentation(image, 0.3);
     NSDictionary *dic=@{
     @"peopleId":GetUserDefault(peopleId)
     };
         
     [SwpRequest swpPOSTAddFile:@"http://139.129.218.191:8080/web/contacts/uploadPhoto" parameters:dic isEncrypt:NO fileName:@"photo" fileData:imageData swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
         self.peopleInfo.photo=[resultObject objectForKey:@"message"];
         [self setUI];
         [SVProgressHUD showSuccessWithStatus:[resultObject objectForKey:@"message"]];
     } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
     
     }];
     }
     
     }];
     //4. 显示XMNPhotoPicker
     [[XMNPhotoPicker sharePhotoPicker] showPhotoPickerwithController:self animated:YES];
     
}
@end
