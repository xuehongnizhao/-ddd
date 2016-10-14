//
//  DepartMentViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/29.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "DepartMentViewController.h"
#import "TeamInfo.h"
#import "PeopleInfo.h"
@interface DepartMentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *tableViewLeft;
@property (strong, nonatomic) UITableView *tableViewRight;
@property (strong, nonatomic) NSMutableArray *leftDataList;
@property (strong, nonatomic) NSMutableArray *rightDataList;

@end

@implementation DepartMentViewController

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
- (void)setDataList:(DepartmentInfo *)dataList{
    _dataList=dataList;
    _leftDataList=[NSMutableArray array];
    NSMutableArray *noOrder=[NSMutableArray array];
    for (PeopleInfo *info in _dataList.appPeopleDatas) {
        [noOrder addObject:info.departments];
    }
    
    for (NSString *str in noOrder) {
        if (![self.leftDataList containsObject:str]) {
            [self.leftDataList addObject:str];
        }
    }
    _rightDataList=[NSMutableArray array];
    PeopleInfo *firstInf=_dataList.appPeopleDatas[0];
    
    NSString *string = firstInf.departments;
    for (PeopleInfo *info in _dataList.appPeopleDatas) {
        if ([info.departments isEqualToString:string]) {
            [_rightDataList addObject:info];
        }
    }
    
}
- (void)setUI{
    
    [self.view addSubview:self.tableViewLeft];
    [_tableViewLeft autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:2];
    [_tableViewLeft autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_tableViewLeft autoPinEdgeToSuperviewEdge:ALEdgeBottom ];
    [_tableViewLeft autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH*5/12];
    
    [self.view addSubview:self.tableViewRight];
    [_tableViewRight autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH*6/12];
    [_tableViewRight autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:5];
    [_tableViewRight autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [_tableViewRight autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [_tableViewLeft setTableFooterView:view];
    [_tableViewRight setTableFooterView:view];
}

#pragma mark --- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==_tableViewLeft) {
        return _leftDataList.count;
    }
    return _rightDataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==_tableViewRight) {
        return 60;
    }
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableViewLeft) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
            cell.selectedBackgroundView.backgroundColor=[UIColor orangeColor];
        }
        if (indexPath.row==0) {
            cell.selected=YES;
        }
        
        cell.textLabel.text=self.leftDataList[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:14];
        return cell;

    }
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

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
    
    UIView *view=[[UIView alloc]initWithFrame:cell.contentView.bounds];
    [cell.contentView addSubview:view];
    PeopleInfo *peopleInfo=_rightDataList[indexPath.row];
    
    UILabel *name=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 60, 30)];
    name.font=[UIFont systemFontOfSize:18];
    name.textColor=[UIColor orangeColor];
    name.text=peopleInfo.peopleName;
    [view addSubview:name];

 
    
    UILabel *tel=[[UILabel alloc]initWithFrame:CGRectMake(5, 30, cell.contentView.frame.size.width, 15)];
    tel.font=[UIFont systemFontOfSize:15];
    NSArray *array=[peopleInfo.phone componentsSeparatedByString:@","];
    tel.text=array[0];
    [view addSubview:tel];


    
    UILabel *position=[[UILabel alloc]initWithFrame:CGRectMake(70, 10, cell.contentView.frame.size.width, 14)];
    position.font=[UIFont systemFontOfSize:14];
    position.text=peopleInfo.position;
    [view addSubview:position];


    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView==_tableViewLeft) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 40)];
        view.backgroundColor=[UIColor redColor];
        UILabel *laber=[[UILabel alloc]initWithFrame:view.bounds];
        laber.text=_dataList.groupName;
        [view addSubview:laber];
        
        return view;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _tableViewRight) {
        [SwpTools swpToolCallPhone:@"" superView:self.view];
        
        return;
    }
    
    [_rightDataList removeAllObjects];
    
    NSString *string =_leftDataList[indexPath.row];
    
    
    for (PeopleInfo *info in _dataList.appPeopleDatas) {
        if ([info.departments isEqualToString:string]) {
            [_rightDataList addObject:info];
        }
    }
    
    [self.tableViewRight reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==_tableViewLeft) {
        return 40;
    }
    return 0;
}
- (UITableView *)tableViewLeft{
    if (!_tableViewLeft) {
        _tableViewLeft=[[UITableView alloc]initForAutoLayout];
        _tableViewLeft.delegate=self;
        _tableViewLeft.dataSource=self;
        _tableViewLeft.layer.cornerRadius=5;
    }
    return _tableViewLeft;
}

- (UITableView *)tableViewRight{
    if (!_tableViewRight) {
        _tableViewRight=[[UITableView alloc]initForAutoLayout];
        _tableViewRight.dataSource=self;
        _tableViewRight.delegate=self;
    }
    return _tableViewRight;
}
@end
