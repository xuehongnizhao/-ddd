//
//  BossViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/28.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "BossViewController.h"
#import "DepartmentInfo.h"
#import "DepartMentViewController.h"
@interface BossViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView       *tableView;
@property (strong, nonatomic) NSArray           *departmentInfo;
@end

@implementation BossViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO];
}


- (void)setDataList:(TeamInfo *)dataList{
    _dataList=dataList;
    self.departmentInfo=_dataList.appGroupDataList;
    [self setUI];
  
}

- (void)setUI{
    
    
    [self.view addSubview:self.tableView];
    
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [_tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [_tableView setTableFooterView:view];
}
#pragma mark ---UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.departmentInfo.count/2+self.departmentInfo.count%2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    while ([cell.contentView.subviews lastObject]!= nil) {
        [[cell.contentView.subviews lastObject]removeFromSuperview];
    }
    

    DepartmentInfo *infoleft=[self.departmentInfo objectAtIndex:indexPath.row*2];
    UIButton *buttonLeft=[[UIButton alloc]initForAutoLayout];
    [buttonLeft addTarget:self action:@selector(goNext:) forControlEvents:UIControlEventTouchUpInside];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://address.hongdingnet.com/%@",infoleft.groupIcon]];

    buttonLeft.tag=indexPath.row*2;
    [cell.contentView addSubview:buttonLeft];
    [buttonLeft autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [buttonLeft autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [buttonLeft autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [buttonLeft autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/2];
    
    UIImageView *leftImage=[[UIImageView alloc]initForAutoLayout];
    [leftImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"team_6"]];
    leftImage.userInteractionEnabled=YES;
    [buttonLeft addSubview:leftImage];
    [leftImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [leftImage autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [leftImage autoSetDimensionsToSize:CGSizeMake(40, 40)];
    
    UILabel *leftLabel=[[UILabel alloc]initForAutoLayout];
    leftLabel.text=infoleft.groupName;
    leftLabel.font=[UIFont systemFontOfSize:14];
    leftLabel.textAlignment=NSTextAlignmentCenter;
    [buttonLeft addSubview:leftLabel];
    [leftLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [leftLabel autoPinEdgeToSuperviewEdge: ALEdgeTop];
    [leftLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:leftImage];
    [leftLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    if (self.departmentInfo.count>indexPath.row*2+1) {
        DepartmentInfo *infoRight=[self.departmentInfo objectAtIndex:(indexPath.row*2+1)];
        UIButton *buttonRitht=[[UIButton alloc]initForAutoLayout];
        [buttonRitht addTarget:self action:@selector(goNext:) forControlEvents:UIControlEventTouchUpInside];
        NSURL *urlRight=[NSURL URLWithString:[NSString stringWithFormat:@"http://address.hongdingnet.com/%@",infoRight.groupIcon]];
        
        buttonRitht.tag=indexPath.row*2+1;
        [cell.contentView addSubview:buttonRitht];
        [buttonRitht autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [buttonRitht autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [buttonRitht autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [buttonRitht autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH/2];
        UIImageView *rightImage=[[UIImageView alloc]initForAutoLayout];
        [rightImage sd_setImageWithURL:urlRight placeholderImage:[UIImage imageNamed:@"team_6"]];
        rightImage.userInteractionEnabled=YES;
        [buttonRitht addSubview:rightImage];
        [rightImage autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
        [rightImage autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
        [rightImage autoSetDimensionsToSize:CGSizeMake(40, 40)];
        
        UILabel *rightLabel=[[UILabel alloc]initForAutoLayout];
        rightLabel.text=infoleft.groupName;
        rightLabel.textAlignment=NSTextAlignmentCenter;
        rightLabel.font=[UIFont systemFontOfSize:14];
        [buttonRitht addSubview:rightLabel];
        [rightLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [rightLabel autoPinEdgeToSuperviewEdge: ALEdgeTop];
        [rightLabel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:rightImage withOffset:5];
        [rightLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];

    }
        return cell;
}

- (void)goNext:(UIButton *)sender{
    DepartMentViewController *firVC=[[DepartMentViewController alloc]init];
    firVC.dataList=self.dataList.appGroupDataList[sender.tag];
    [self.navigationController pushViewController:firVC animated:YES];

}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    view.backgroundColor=[UIColor redColor];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, SCREEN_WIDTH, 20)];
    label.textColor=[UIColor whiteColor];
    label.text=self.dataList.teamName;
    label.textAlignment=NSTextAlignmentCenter;
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.layer.cornerRadius=5;
        
    }
    return _tableView;
}

@end
