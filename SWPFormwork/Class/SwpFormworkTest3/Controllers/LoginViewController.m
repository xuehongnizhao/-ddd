//
//  LoginViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "LoginViewController.h"
#import "SwpTabBarController.h"
#import "ChangePasswordViewController.h"
@interface LoginViewController ()
@property (strong, nonatomic)UITextField    *name;
@property (strong, nonatomic)UITextField    *password;
@property (strong, nonatomic)UIButton       *login;
@property (strong, nonatomic)UIButton       *lostPassword;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI{
    UIView *naviView =[[UIView alloc]initForAutoLayout];
    [self.view addSubview:naviView];
    naviView.backgroundColor =[UIColor swpColorFromHEX:0xd20a0c];
    [naviView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [naviView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [naviView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [naviView autoSetDimension:ALDimensionHeight toSize:64];
    UILabel *title=[[UILabel alloc]initForAutoLayout];
    title.text=@"用户登录";
    title.font=[UIFont systemFontOfSize:20];
    title.textColor=[UIColor whiteColor];
    [naviView addSubview:title];
    [title autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:30];
    [title autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [title autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [title autoSetDimension:ALDimensionWidth toSize:88];
    UIImageView *logo=[[UIImageView alloc]initForAutoLayout];
    logo.image=[UIImage imageNamed:@"logo"];
    [self.view addSubview:logo];
    [logo autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:naviView withOffset:20];
    [logo autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [logo autoSetDimensionsToSize:CGSizeMake(120*BalanceWidth, 120*BalanceHeight)];
    
    [self.view addSubview:self.name];
    [_name autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:logo withOffset:10];
    [_name autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_name autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_name autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.view addSubview:self.password];
    [_password autoSetDimension:ALDimensionHeight toSize:30];
    [_password autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_password autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_password autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.name];
    
    [self.view addSubview:self.login];
    [_login autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.password withOffset:10];
    [_login autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [_login autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_login autoSetDimension:ALDimensionHeight toSize:30];
    
    [self.view addSubview:self.lostPassword];
    [_lostPassword autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:10];
    [_lostPassword autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
    [_lostPassword autoSetDimensionsToSize:CGSizeMake(80, 20)];
}


- (UITextField *)name{
    if (!_name) {
    
        _name = [[UITextField alloc]initForAutoLayout];
        _name.placeholder=@"请输入手机号";
        _name.textAlignment=NSTextAlignmentCenter;
        _name.backgroundColor=[UIColor whiteColor];
        if (GetUserDefault(lastName)) {
            _name.text=GetUserDefault(lastName);
        }

    }
    return _name;
}

- (UITextField *)password{
    if (!_password) {
        _password=[[UITextField alloc]initForAutoLayout];
        _password.placeholder=@"请输入密码";
        _password.textAlignment=NSTextAlignmentCenter;
        _password.backgroundColor=[UIColor whiteColor];
        _password.layer.borderWidth=1;
        _password.layer.borderColor=[UIColor colorWithWhite:.8 alpha:1].CGColor;
        _password.secureTextEntry=YES;
    }
    return _password;
}

- (UIButton *)login{
    if (!_login) {
        _login=[[UIButton alloc]initForAutoLayout];
        [_login addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
        _login.backgroundColor=[UIColor swpColorFromHEX:0xd20a0c];
        [_login setTitle:@"登录" forState:UIControlStateNormal];
        _login.layer.cornerRadius=5;
    }
    return _login;
}


- (void)loginAction{
    NSString *name=self.name.text;
    NSString *password=self.password.text;
    SetUserDefault(name, lastName);
    if (self.name.text.length==0||self.password.text.length==0) {
        
        [SVProgressHUD showErrorWithStatus:@"账户名或密码不能为空"];

        return;
    }

    NSDictionary *dic = @{
                          @"userName":name,
                          @"userPassword":password
                          };
    [SwpRequest swpPOST:@"http://139.129.218.191:8080/web/contacts/userLogin" parameters:dic isEncrypt:NO swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject){
        if ([[resultObject objectForKey:@"code"]isEqualToString:@"0000" ]) {
            
            SetUserDefault([resultObject objectForKey:@"message"], peopleId);
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:isLogin];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [UIApplication sharedApplication].keyWindow.rootViewController=[SwpTabBarController shareInstance];
        }else{
            [SVProgressHUD showErrorWithStatus:[resultObject objectForKey:@"message"]];
        }

    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
       
    }];

    
}

- (UIButton *)lostPassword{
    if (!_lostPassword) {
        _lostPassword=[[UIButton alloc]initForAutoLayout];
        [_lostPassword addTarget:self action:@selector(lostPasswordAction) forControlEvents:UIControlEventTouchUpInside];
        [_lostPassword setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_lostPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    }
    return _lostPassword;
}

- (void)lostPasswordAction{
    ChangePasswordViewController *firvc=[[ChangePasswordViewController alloc]init];
    [self presentViewController:firvc animated:NO completion:nil];
}
@end
