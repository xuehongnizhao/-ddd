//
//  MineViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()
@property (strong, nonatomic)UIImageView    *headImage;
@property (strong, nonatomic)UILabel        *nameLabel;
@property (strong, nonatomic)UIButton       *selfInfo;
@property (strong, nonatomic)UIButton       *changePassword;
@property (strong, nonatomic)UIButton       *erWeiMa;
@property (strong, nonatomic)UIButton       *verionInfo;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
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
    [_headImage autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [_headImage autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_headImage autoSetDimensionsToSize:CGSizeMake(80, 80)];
    
    [backGroundView addSubview:self.nameLabel];
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_nameLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_nameLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headImage];
    [_nameLabel autoSetDimension:ALDimensionHeight toSize:30];
}

- (UIImageView *)headImage{
    if (!_headImage) {
        _headImage=[[UIImageView alloc]initForAutoLayout];
        _headImage.image=[UIImage imageNamed:@"placeholderImage"];
    }
    return _headImage;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel=[[UILabel alloc]initForAutoLayout];
        _nameLabel.text=@"解放军";
        _nameLabel.textColor=[UIColor whiteColor];
        _nameLabel.textAlignment=NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (UIButton *)selfInfo{
    if (!_selfInfo) {
        _selfInfo=[[UIButton alloc]initForAutoLayout];
        [_selfInfo addTarget:self action:@selector(selfInfoAction) forControlEvents:UIControlEventTouchUpInside];
        _selfInfo.layer.borderWidth=1;
        _selfInfo.layer.borderColor=[UIColor colorWithWhite:.8 alpha:1].CGColor;
        [_selfInfo setTitle:@"    个人信息" forState:UIControlStateNormal];
//        _selfInfo setImage:[UIImage imageNamed:<#(nonnull NSString *)#>] forState:<#(UIControlState)#>
    }
    return _selfInfo;
}

- (void)selfInfoAction{
    
}

- (UIButton *)changePassword{
    if (!_changePassword) {
        _changePassword=[[UIButton alloc]initForAutoLayout];
        [_changePassword addTarget:self action:@selector(changePasswordAction) forControlEvents:UIControlEventTouchUpInside];
        _changePassword.layer.borderWidth=1;
        _changePassword.layer.borderColor=[UIColor colorWithWhite:.8 alpha:1].CGColor;
        [_changePassword setTitle:@"    修改密码" forState:UIControlStateNormal];
    }
    return _changePassword;
}

- (void)changePasswordAction{
    
}

- (UIButton *)erWeiMa{
    if (!_erWeiMa) {
        _erWeiMa=[[UIButton alloc]initForAutoLayout];
        [_erWeiMa addTarget:self action:@selector(erWeiMaAction) forControlEvents:UIControlEventTouchUpInside];
        _erWeiMa.layer.borderWidth=1;
        _erWeiMa.layer.borderColor=[UIColor colorWithWhite:.8 alpha:1].CGColor;
        [_erWeiMa setTitle:@"    二维码" forState:UIControlStateNormal];
    }
    return _erWeiMa;
}

- (void)erWeiMaAction{
    
}

- (UIButton *)verionInfo{
    if (!_verionInfo) {
        _verionInfo=[[UIButton alloc]initForAutoLayout];
        [_verionInfo addTarget:self action:@selector(verionInfoAction) forControlEvents:UIControlEventTouchUpInside];
        _verionInfo.layer.borderWidth=1;
        _verionInfo.layer.borderColor=[UIColor colorWithWhite:.8 alpha:1].CGColor;
        [_verionInfo setTitle:@"    版本信息" forState:UIControlStateNormal];
    }
    return _verionInfo;
}

- (void)verionInfoAction{
    
}
@end
