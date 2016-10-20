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
@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UIImageView    *headImage;
@property (strong, nonatomic)UILabel        *nameLabel;
@property (strong, nonatomic)UITableView    *tableView;
//@property (strong, nonatomic)UIButton       *selfInfo;
//@property (strong, nonatomic)UIButton       *changePassword;
//@property (strong, nonatomic)UIButton       *erWeiMa;
//@property (strong, nonatomic)UIButton       *verionInfo;
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
    
    [self.view addSubview:self.tableView];
    [_tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:backGroundView withOffset:20];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_tableView autoPinEdgeToSuperviewEdge: ALEdgeRight];
    [_tableView autoSetDimension:ALDimensionHeight toSize:160];
    [self.view addSubview:self.quitLogin];
    [_quitLogin autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.tableView withOffset:50*BalanceHeight];
    [_quitLogin autoSetDimension:ALDimensionHeight toSize:40];
    [_quitLogin autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:40];
    [_quitLogin autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:40];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]init];

    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    switch (indexPath.row) {
        case 0:{
            cell.imageView.image=[UIImage imageNamed:@"selfInfo"];
            cell.textLabel.text=@"个人信息";
        }
            
            break;
        case 1:{
            cell.imageView.image=[UIImage imageNamed:@"changePassword"];
            cell.textLabel.text=@"修改密码";
        }
            
            break;
        case 2:{
            cell.imageView.image=[UIImage imageNamed:@"erWeiMa"];
            cell.textLabel.text=@"二 维 码";
        }
            
            break;
        case 3:{
            cell.imageView.image=[UIImage imageNamed:@"versionInfo"];
            cell.textLabel.text=@"版本信息";
        }
            
            break;
        default:
            break;
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            [self selfInfoAction];
        }
            break;
        case 1:{
            [self changePasswordAction];
        }
            break;
        case 2:{
            [self erWeiMaAction];
        }
            break;
        case 3:{
            [self verionInfoAction];
        }
            break;
            
        default:
            break;
    }
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

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initForAutoLayout];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.scrollEnabled=NO;
        
    }
    return _tableView;
}


- (void)selfInfoAction{
    SelfInfoViewController *firVC=[[SelfInfoViewController alloc]init];
    firVC.title=@"个人信息";
    [self.navigationController pushViewController:firVC animated:YES];
}



- (void)changePasswordAction{
    [self presentViewController:[[ChangePasswordViewController alloc]init] animated:NO completion:nil];
    
    
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
