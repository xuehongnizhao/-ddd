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
    return self.departmentInfo.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
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
    DepartmentInfo *info=[self.departmentInfo objectAtIndex:indexPath.row];
    cell.textLabel.text=info.groupName;
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://address.hongdingnet.com%@",info.groupIcon]];
    UIImageView *imagView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 17.5, 40, 40)];
    [imagView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"Boss"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
    
    }];

    [cell.contentView addSubview:imagView];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 30)];
    view.backgroundColor=[UIColor redColor];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 400, 20)];
    label.textColor=[UIColor whiteColor];
    label.text=@"哈尔滨支队";
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DepartMentViewController *firVC=[[DepartMentViewController alloc]init];
    firVC.dataList=self.dataList.appGroupDataList[indexPath.row];
    [self.navigationController pushViewController:firVC animated:YES];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initForAutoLayout];
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.layer.cornerRadius=5;

    }
    return _tableView;
}

@end
