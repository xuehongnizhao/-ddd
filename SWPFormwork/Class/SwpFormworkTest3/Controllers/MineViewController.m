//
//  MineViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "PeopleInfo.h"
#import "ChangePasswordViewController.h"
#import "SelfInfoViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface MineViewController ()
@property (strong, nonatomic)UIImageView    *headImage;
@property (strong, nonatomic)UILabel        *nameLabel;
@property (strong, nonatomic)UIButton       *selfInfo;
@property (strong, nonatomic)UIButton       *changePassword;
@property (strong, nonatomic)UIButton       *erWeiMa;
@property (strong, nonatomic)UIButton       *verionInfo;
@property (strong, nonatomic)UIButton       *quitLogin;
@property (strong, nonatomic)PeopleInfo     *myInfo;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden=YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
    [self getDataFromNet];
    [self setUI];
}
- (void)getDataFromNet{
    
    NSDictionary *dic=@{
                        @"peopleId":GetUserDefault(peopleId)
                        };
    [SwpRequest swpPOST:@"http://address.hongdingnet.com/web/contacts/getPeopleById" parameters:dic isEncrypt:NO swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        NSDictionary *dic=resultObject;
        SetUserDefault(dic, myInfoDic);
        
        [self.myInfo mj_setKeyValues:resultObject];
        
        [self setUI];
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
}
- (void)setUI{
    
    UIView *backGroundView=[[UIView alloc]initForAutoLayout];
    backGroundView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backGroundColor"]];
    [self.view addSubview:backGroundView];
    [backGroundView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [backGroundView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [backGroundView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [backGroundView autoSetDimension:ALDimensionHeight toSize:200*BalanceHeight];
    
    [backGroundView addSubview:self.headImage];
    NSDictionary *dic=GetUserDefault(myInfoDic);
    NSString *imageUrl=[dic objectForKey:@"photo"];
    if (imageUrl.length>0) {
        NSString *urlString=[NSString stringWithFormat:@"http://address.hongdingnet.com/web/%@",imageUrl];
        NSURL *url=[NSURL URLWithString:urlString];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *imageddd=[UIImage imageWithData:data];
        _headImage.image=imageddd;
    }
    [_headImage autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_headImage autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_headImage autoSetDimensionsToSize:CGSizeMake(110*BalanceWidth, 110*BalanceWidth)];
    
    [backGroundView addSubview:self.nameLabel];
    _nameLabel.text=self.myInfo.peopleName;
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headImage];
    [_nameLabel autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.view addSubview:self.selfInfo];
    [_selfInfo autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:backGroundView withOffset:30];
    [_selfInfo autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_selfInfo autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_selfInfo autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.view addSubview:self.changePassword];
    [_changePassword autoSetDimension:ALDimensionHeight toSize:40];
    [_changePassword autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_changePassword autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_changePassword autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.selfInfo];
    
    [self.view addSubview:self.erWeiMa];
    [_erWeiMa autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.changePassword];
    [_erWeiMa autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_erWeiMa autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_erWeiMa autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.view addSubview:self.verionInfo];
    [_verionInfo autoSetDimension:ALDimensionHeight toSize:40];
    [_verionInfo autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_verionInfo autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_verionInfo autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.erWeiMa];
    
    [self.view addSubview:self.quitLogin];
    [_quitLogin autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.verionInfo withOffset:50*BalanceHeight];
    [_quitLogin autoSetDimension:ALDimensionHeight toSize:40];
    [_quitLogin autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [_quitLogin autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40];
}

- (UIImageView *)headImage{
    if (!_headImage) {
        _headImage=[[UIImageView alloc]initForAutoLayout];
        _headImage.layer.cornerRadius=55*BalanceWidth;
        _headImage.clipsToBounds=YES;
        _headImage.image=[UIImage imageNamed:@"placeholderImage"];
  
    }
    return _headImage;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]initForAutoLayout];
        _nameLabel.textColor=[UIColor whiteColor];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UIButton *)selfInfo{
    if (!_selfInfo) {
        _selfInfo=[[UIButton alloc]initForAutoLayout];
        [_selfInfo addTarget:self action:@selector(selfInfoAction) forControlEvents:UIControlEventTouchUpInside];
        [_selfInfo setTitle:@" 个人信息" forState:UIControlStateNormal];
        [_selfInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_selfInfo setImage:[UIImage imageNamed:@"selfInfo"] forState:UIControlStateNormal];
    }
    return _selfInfo;
}

- (void)selfInfoAction{
    SelfInfoViewController *firVC=[[SelfInfoViewController alloc]init];
    [self.navigationController pushViewController:firVC animated:NO];
}

- (UIButton *)changePassword{
    if (!_changePassword) {
        _changePassword=[[UIButton alloc]initForAutoLayout];
        [_changePassword addTarget:self action:@selector(changePasswordAction) forControlEvents:UIControlEventTouchUpInside];
        _changePassword.layer.borderWidth=1;
        _changePassword.layer.borderColor=[UIColor colorWithWhite:.8 alpha:1].CGColor;
        [_changePassword setTitle:@" 修改密码" forState:UIControlStateNormal];
        [_changePassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_changePassword setImage:[UIImage imageNamed:@"changePassword"] forState:UIControlStateNormal];
    }
    return _changePassword;
}

- (void)changePasswordAction{
    [self presentViewController:[[ChangePasswordViewController alloc]init] animated:NO completion:nil];
    
    
}

- (UIButton *)erWeiMa{
    if (!_erWeiMa) {
        _erWeiMa=[[UIButton alloc]initForAutoLayout];
        [_erWeiMa addTarget:self action:@selector(erWeiMaAction) forControlEvents:UIControlEventTouchUpInside];
        [_erWeiMa setTitle:@"   二维码  " forState:UIControlStateNormal];
        [_erWeiMa setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_erWeiMa setImage:[UIImage imageNamed:@"erWeiMa"] forState:UIControlStateNormal];
    }
    return _erWeiMa;
}

- (void)erWeiMaAction{
    UIViewController *firVC=[[UIViewController alloc]init];
    UIImageView *imagview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"downloadCode"]];
    [firVC.view addSubview:imagview];
    [imagview autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [imagview autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [imagview autoSetDimensionsToSize:CGSizeMake(329*BalanceWidth, 409*BalanceHeight)];
    [self.navigationController pushViewController:firVC animated:NO];
    
}

- (UIButton *)verionInfo{
    if (!_verionInfo) {
        _verionInfo=[[UIButton alloc]initForAutoLayout];
        [_verionInfo addTarget:self action:@selector(verionInfoAction) forControlEvents:UIControlEventTouchUpInside];
        _verionInfo.layer.borderWidth=1;
        _verionInfo.layer.borderColor=[UIColor colorWithWhite:.8 alpha:1].CGColor;
        [_verionInfo setTitle:@" 版本信息" forState:UIControlStateNormal];
        [_verionInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_verionInfo setImage:[UIImage imageNamed:@"versionInfo"] forState:UIControlStateNormal];
    }
    return _verionInfo;
}


- (void)verionInfoAction{
    [SVProgressHUD showSuccessWithStatus:@"宏鼎科技提供技术支持\n当前版本为1.0 无需更新"];
}

- (UIButton *)quitLogin{
    if (!_quitLogin) {
        _quitLogin=[[UIButton alloc]initForAutoLayout];
        [_quitLogin addTarget:self action:@selector(quitLoginAction) forControlEvents:UIControlEventTouchUpInside];
        _quitLogin.backgroundColor=[UIColor redColor];
        [_quitLogin setTitle:@"退出登录" forState:UIControlStateNormal];
        _quitLogin.layer.cornerRadius=5;
    }
    return _quitLogin;
}

- (void)quitLoginAction{
    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:isLogin];
    
    [UIApplication sharedApplication].keyWindow.rootViewController=[[LoginViewController alloc]init];
}
- (PeopleInfo *)myInfo{
    if (!_myInfo) {
        _myInfo=[[PeopleInfo alloc]init];
    }
    return _myInfo;
}
@end
