//
//  ChangePasswordViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
@property (strong, nonatomic)UITextField        *phoneNumber;
@property (strong, nonatomic)UITextField        *authCode;
@property (strong, nonatomic)UITextField        *zqNewPassword;
@property (strong, nonatomic)UIButton           *sendAuthCode;
@property (strong, nonatomic)UIButton           *complete;
//@property (strong, nonatomic)UITextField        *confirmNewPassword;
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    
    self.title=@"修改密码";
    UIView *headView=[[UIView alloc]initForAutoLayout];
    headView.backgroundColor=[UIColor swpColorFromHEX:0xd20a0c];
    [self.view addSubview:headView];
    [headView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [headView autoPinEdgeToSuperviewEdge: ALEdgeLeft];
    [headView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [headView autoSetDimension:ALDimensionHeight toSize:64];
    
    UILabel *title=[[UILabel alloc]initForAutoLayout];
    title.text=@"修改密码";
    title.textAlignment=NSTextAlignmentCenter;
    title.textColor=[UIColor whiteColor];
    [headView addSubview:title];
    [title autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:20];
    [title autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [title autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [title autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    UIButton *dissmiss=[[UIButton alloc]initForAutoLayout];
    [dissmiss addTarget:self action:@selector(dissmissAction) forControlEvents:UIControlEventTouchUpInside];
    [dissmiss setImage:[UIImage imageNamed:@"back_no"] forState:UIControlStateNormal];
    [headView addSubview:dissmiss];
    [dissmiss autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:22];
    [dissmiss autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:2];
    [dissmiss autoSetDimensionsToSize:CGSizeMake(40, 40)];

//    UIImageView *imageV1=[[UIImageView alloc]initForAutoLayout];
//    imageV1.image=[UIImage imageNamed:@"dianhuahao"];
//    [self.view addSubview:imageV1];
//    [imageV1 autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:headView withOffset:30];
//    [imageV1 autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
//    [imageV1 autoSetDimensionsToSize:CGSizeMake(30, 30)];
    
    [self.view addSubview:self.phoneNumber];
    [_phoneNumber autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_phoneNumber autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_phoneNumber autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:headView withOffset:20];
    [_phoneNumber autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.view addSubview:self.sendAuthCode];
    [_sendAuthCode autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.phoneNumber withOffset:10];
    [_sendAuthCode autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [_sendAuthCode autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_sendAuthCode autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.view addSubview:self.authCode];
    [_authCode autoSetDimension:ALDimensionHeight toSize:40];
    [_authCode autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.sendAuthCode withOffset:10];
    [_authCode autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_authCode autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    [self.view addSubview:self.zqNewPassword];
    [_zqNewPassword autoSetDimension:ALDimensionHeight toSize:40];
    [_zqNewPassword autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_zqNewPassword autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_zqNewPassword autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.authCode withOffset:10];
//    [self.view addSubview:self.confirmNewPassword];
//    [_confirmNewPassword autoSetDimension:ALDimensionHeight toSize:40];
    
    [self.view addSubview:self.complete];
    [_complete autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.zqNewPassword withOffset:20];
    [_complete autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_complete autoSetDimensionsToSize:CGSizeMake(80, 30)];
}

- (void)dissmissAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UITextField *)phoneNumber{
    if (!_phoneNumber) {
        _phoneNumber=[[UITextField alloc]initForAutoLayout];
        _phoneNumber.placeholder=@"请输入手机号";
        _phoneNumber.textAlignment=NSTextAlignmentCenter;
        _phoneNumber.layer.borderWidth=1;
        _phoneNumber.layer.borderColor=[UIColor colorWithWhite:.8 alpha:1].CGColor;
        if (GetUserDefault(lastName)) {
            _phoneNumber.text=GetUserDefault(lastName);
        }

    }
    return _phoneNumber;
}

- (UIButton *)sendAuthCode{
    if (!_sendAuthCode) {
        _sendAuthCode=[[UIButton alloc]initForAutoLayout];
        [_sendAuthCode addTarget:self action:@selector(sendAuthCodeAction) forControlEvents:UIControlEventTouchUpInside];
        [_sendAuthCode setTitle:@"发送验证码" forState:UIControlStateNormal];
        _sendAuthCode.layer.cornerRadius=5;
        _sendAuthCode.backgroundColor=[UIColor swpColorFromHEX:0xd20a0c];
    }
    return _sendAuthCode;
}

- (void)sendAuthCodeAction{
    NSDictionary *dic=@{
                        @"userName":self.phoneNumber.text
                        };
    [SwpRequest swpPOST:@"http://139.129.218.191:8080/web/contacts/getCode" parameters:dic isEncrypt:NO swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if ([[resultObject objectForKey:@"code"]isEqualToString:@"0002"]) {
            [SVProgressHUD showErrorWithStatus:[resultObject objectForKey:@"message"]];
        }else{
            [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            SetUserDefault([resultObject objectForKey:@"message"], peopleId);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
    
}
- (UITextField *)authCode{
    if (!_authCode) {
        _authCode=[[UITextField alloc]initForAutoLayout];
        _authCode.layer.borderWidth=1;
        _authCode.layer.borderColor=[UIColor colorWithWhite:.8 alpha:1].CGColor;
        _authCode.placeholder=@"请输入验证码";
        _authCode.textAlignment=NSTextAlignmentCenter;
    }
    return _authCode;
}

- (UITextField *)zqNewPassword{
    if (!_zqNewPassword) {
        _zqNewPassword=[[UITextField alloc]initForAutoLayout];
        _zqNewPassword.layer.borderWidth=1;
        _zqNewPassword.layer.borderColor=[UIColor colorWithWhite:.8 alpha:1].CGColor;
        _zqNewPassword.placeholder=@"请输入新密码";
        _zqNewPassword.textAlignment=NSTextAlignmentCenter;
        
    }
    return _zqNewPassword;
}

- (UIButton *)complete{
    if (!_complete) {
        _complete=[[UIButton alloc]initForAutoLayout];
        [_complete addTarget:self action:@selector(completeAction) forControlEvents:UIControlEventTouchUpInside];
        [_complete setTitle:@"完成" forState:UIControlStateNormal];
        _complete.layer.cornerRadius=5;
        _complete.backgroundColor=[UIColor swpColorFromHEX:0xd20a0c];
    }
    return _complete;
}

- (void)completeAction{
    NSDictionary *dic=@{
                        @"peopleId":GetUserDefault(peopleId),
                        @"userName":self.phoneNumber.text,
                        @"userPassword":self.zqNewPassword.text,
                        @"authCode":self.authCode.text
                        };
    [SwpRequest swpPOST:@"http://139.129.218.191:8080/web/contacts/updatePassword" parameters:dic isEncrypt:NO swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if ([[resultObject objectForKey:@"code"]isEqualToString:@"0001"]) {
            [SVProgressHUD showErrorWithStatus:[resultObject objectForKey:@"message"]];
        }else if ([[resultObject objectForKey:@"code"]isEqualToString:@"0002"]){
            [SVProgressHUD showErrorWithStatus:[resultObject objectForKey:@"message"]];
        }else{
            [SVProgressHUD showSuccessWithStatus:[resultObject objectForKey:@"message"]];
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
}
//- (UITextField *)confirmNewPassword{
//    if (!_confirmNewPassword) {
//        _confirmNewPassword=[[UITextField alloc]initForAutoLayout];
//        _confirmNewPassword.layer.borderWidth=1;
//        _confirmNewPassword.layer.borderColor=[UIColor colorWithWhite:.8 alpha:1].CGColor;
//        _confirmNewPassword.placeholder=@"请确认新密码";
//
//        
//    }
//    return _confirmNewPassword;
//}
@end
