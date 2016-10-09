//
//  AddressListViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "AddressListViewController.h"
#import "TeamInfo.h"
#import "BossViewController.h"
#import "SearchViewController.h"
#import "DepartmentInfo.h"
#import "PeopleInfo.h"
#define TEAMBUTTONTAG 928
@interface AddressListViewController ()
@property (strong, nonatomic)NSMutableArray     *teamInfo;
@property (strong, nonatomic)UIButton           *bossButton;
@property (strong, nonatomic)UIImageView        *teamImage;
@end

@implementation AddressListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self judgeGetData];
    [self setUI];
    
}

- (void)setUI{
    
    [self setNavigationBarTitle:@"通讯录" textColor:[UIColor whiteColor] titleFontSize:@20];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(rightItemAction)];
    
    UIScrollView *backGroundView=[[UIScrollView alloc]initForAutoLayout];
    backGroundView.backgroundColor=[UIColor whiteColor];
    backGroundView.contentSize=CGSizeMake(SCREEN_WIDTH, 500*BalanceWidth+100*BalanceWidth+30+64);
    [self.view addSubview:backGroundView];
    [backGroundView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [backGroundView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [backGroundView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [backGroundView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    UIImageView *bossImage=[[UIImageView alloc]initForAutoLayout];
    bossImage.image=[UIImage imageNamed:@"bossHead"];
    bossImage.userInteractionEnabled=YES;
    [backGroundView addSubview:bossImage];
    [bossImage autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [bossImage autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [bossImage autoSetDimensionsToSize:CGSizeMake(300*BalanceWidth, 100*BalanceWidth)];
    
    UIImageView *bossFace=[[UIImageView alloc]initForAutoLayout];
    bossFace.image=[UIImage imageNamed:@"Boss"];
    [bossImage addSubview:bossFace];
    [bossFace autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:15];
    [bossFace autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:42.5*BalanceWidth ];
    [bossFace autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:7.5];
    [bossFace autoSetDimension:ALDimensionWidth toSize:50*BalanceWidth ];
    
    [bossImage addSubview:self.bossButton];
    [_bossButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:7.5+50*BalanceWidth];
    [_bossButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:42.5*BalanceWidth];
    [_bossButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:7.5];
    [_bossButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:0];
    
    [backGroundView addSubview:self.teamImage];
    [_teamImage autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:bossImage withOffset:15];
    [_teamImage autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [_teamImage autoSetDimensionsToSize:CGSizeMake(300*BalanceWidth, 500*BalanceWidth)];
    

    NSArray *nameArr=@[@"哈尔滨支队",@"佳木斯支队",@"牡丹江支队",@"大庆支队",@"双鸭山支队",@"齐齐哈尔支队",@"大兴安岭支队",@"鹤岗支队",@"绥化支队",@"鸡西支队",@"黑河支队",@"七台河支队",@"伊春支队"];
    int i=1;
    for (NSString *name in nameArr) {
        [self creatTeamInfo:name withIndex:i];
        i++;
    }
}

- (void)rightItemAction{
    NSMutableArray *array=[NSMutableArray array];
    for (TeamInfo *teamInfo in self.teamInfo) {
        for (DepartmentInfo *departmentInfo in teamInfo.appGroupDataList) {
            for (PeopleInfo *peopleInfo in departmentInfo.appPeopleDatas) {
                [array addObject:peopleInfo.peopleName];
            }
        }
    }
    SearchViewController *firvc=[[SearchViewController alloc]init];
    firvc.hehearray=array;
    [self.navigationController pushViewController:firvc animated:YES];
}

- (void)creatTeamInfo:(NSString *)name withIndex:(NSInteger)index{
    NSInteger hang=(index-1)/2;
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0+150*BalanceWidth*((index-1)%2), 34.5+66*BalanceWidth*hang, 150*BalanceWidth,66*BalanceWidth)];
    UIImageView *imagv=[[UIImageView alloc] initForAutoLayout];
    imagv.image= [UIImage imageNamed:[NSString stringWithFormat:@"team_%d",index]];
    [button addSubview:imagv];
    [imagv autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [imagv autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [imagv autoSetDimensionsToSize:CGSizeMake(40, 40)];
    UILabel *label=[[UILabel alloc]initForAutoLayout];
    label.text=name;
    label.font=[UIFont systemFontOfSize:14];
    label.textColor=[UIColor blackColor];
    [button addSubview:label];
    [label autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imagv withOffset:10];
    [label autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [label autoSetDimensionsToSize:CGSizeMake(SCREEN_WIDTH/2-60, 30)];
    [button addTarget:self action:@selector(teamButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.tag=TEAMBUTTONTAG+index;
    [self.teamImage addSubview:button];
    
    
}

- (void)teamButtonAction:(UIButton *)button{
    BossViewController *firVC=[[BossViewController alloc]init];
    firVC.dataList=self.teamInfo[button.tag-TEAMBUTTONTAG];
    [self.navigationController pushViewController:firVC animated:YES];
    
}

- (void)judgeGetData{
    [SwpRequest swpPOST:@"http://139.129.218.191:8080/web/contacts/getUpdated" parameters:nil isEncrypt:NO swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if ([[resultObject objectForKey:@"data"]isEqualToString:GetUserDefault(lastChangeData)]) {
            return ;
        }
        SetUserDefault([resultObject objectForKey:@"data"], lastChangeData);
        [self getDataFromNet];
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
}
- (void)getDataFromNet{
    [SVProgressHUD showWithStatus:@"信息有变\n正在加载..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dic=@{
                        @"peopleId":GetUserDefault(peopleId)
                        };
    
    [SwpRequest swpPOST:@"http://139.129.218.191:8080/web/contacts/getAllByPeopleId" parameters:dic isEncrypt:NO swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [_teamInfo removeAllObjects];
        for (NSDictionary *dic in [resultObject objectForKey:@"appTeamDatas"]) {
            TeamInfo *info=[TeamInfo mj_objectWithKeyValues:dic];
            [_teamInfo addObject:info];
        }
        SetUserDefault(resultObject, allData);
        [SVProgressHUD dismiss];

    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];

}

- (UIButton *)bossButton{
    if (!_bossButton) {
        _bossButton=[[UIButton alloc]initForAutoLayout];
        UIImageView *imagv=[[UIImageView alloc] initForAutoLayout];
        imagv.image= [UIImage imageNamed:@"go_next"];
        [_bossButton addSubview:imagv];
        [imagv autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:15];
        [imagv autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [imagv autoSetDimensionsToSize:CGSizeMake(20, 20)];
        UILabel *label=[[UILabel alloc]initForAutoLayout];
        label.text=@"总队机关";
        label.textColor=[UIColor blackColor];
        [_bossButton addSubview:label];
        [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
        [label autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [label autoSetDimensionsToSize:CGSizeMake(80, 30)];
        [_bossButton addTarget:self action:@selector(bossButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bossButton;
}

- (void)bossButtonAction{
    BossViewController *firVC=[[BossViewController alloc]init];
    firVC.dataList=self.teamInfo[0];
    [self.navigationController pushViewController:firVC animated:YES];
}

- (UIImageView *)teamImage{
    if (!_teamImage) {
        _teamImage=[[UIImageView alloc]initForAutoLayout];
        _teamImage.image=[UIImage imageNamed:@"teamHead"];
        _teamImage.userInteractionEnabled=YES;
    }
    return _teamImage;
}

- (NSMutableArray *)teamInfo{
    if (!_teamInfo) {
        _teamInfo=[NSMutableArray array];
        NSArray *dataArr=[GetUserDefault(allData) objectForKey:@"appTeamDatas"];
        for (NSDictionary *dic in dataArr) {
            TeamInfo *info=[TeamInfo mj_objectWithKeyValues:dic];
            [_teamInfo addObject:info];
        }
    }
    return _teamInfo;
}
@end
