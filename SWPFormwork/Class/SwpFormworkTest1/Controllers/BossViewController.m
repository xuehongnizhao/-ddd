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
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}
- (void)setDataList:(TeamInfo *)dataList{
    _dataList=dataList;
    self.departmentInfo=_dataList.appGroupDataList;
    [self setUI];
    
}

- (void)setUI{

    self.title=@"总队机关";
    
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
    DepartmentInfo *info=[self.departmentInfo objectAtIndex:indexPath.row];
    cell.textLabel.text=info.groupName;
    cell.textLabel.textAlignment=NSTextAlignmentCenter;
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://139.129.218.191:8080%@",info.groupIcon]];
    [cell.imageView sd_setImageWithURL:url];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
