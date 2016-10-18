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
#import "CallInfoViewController.h"
@interface DepartMentViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSString *rightTitle;
}
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
    rightTitle=_leftDataList[0];
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
    [_tableViewRight autoSetDimension:ALDimensionWidth toSize:SCREEN_WIDTH*6.7/12];
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
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        
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
    PeopleInfo *peopleInfo=_rightDataList[indexPath.row];
    
    UIImageView *imagv=[[UIImageView alloc]initForAutoLayout];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"http://address.hongdingnet.com/web/%@",peopleInfo.photo]];
    [imagv sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"team_6"]];
    [cell.contentView addSubview:imagv];
    [imagv autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:5];
    [imagv autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    [imagv autoSetDimensionsToSize:CGSizeMake(35, 35)];
    
    
    UILabel *name=[[UILabel alloc]initForAutoLayout];
    name.font=[UIFont systemFontOfSize:18];
    name.textColor=[UIColor orangeColor];
    name.text=peopleInfo.peopleName;
    [cell.contentView addSubview:name];
    [name autoPinEdgeToSuperviewEdge: ALEdgeTop withInset:5];
    [name autoSetDimensionsToSize:CGSizeMake(70, 20)];
    [name autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imagv withOffset:5];
    
    UILabel *tel=[[UILabel alloc]initForAutoLayout];
    tel.font=[UIFont systemFontOfSize:15];
    NSArray *array=[peopleInfo.phone componentsSeparatedByString:@","];
    tel.text=array[0];
    [cell.contentView addSubview:tel];
    [tel autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:imagv withOffset:5];
    [tel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:name];
    [tel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:5];
    [tel autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    UILabel *position=[[UILabel alloc]initForAutoLayout];
    position.font=[UIFont systemFontOfSize:14];
    position.text=peopleInfo.position;
    [cell.contentView addSubview:position];
    [position autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
    [position autoPinEdge:ALEdgeLeft toEdge:ALEdgeRight ofView:name withOffset:5];
    [position autoPinEdge:ALEdgeBottom toEdge:ALEdgeTop ofView:tel];
    [position autoPinEdgeToSuperviewEdge:ALEdgeRight];
    
    UIButton *callImage=[[UIButton alloc]initForAutoLayout];
    [callImage addTarget:self action:@selector(callPhone:) forControlEvents:UIControlEventTouchUpInside];
    [callImage setImage:[UIImage imageNamed:@"callPhone"] forState:UIControlStateNormal];
    callImage.tag=indexPath.row;
    [cell.contentView addSubview:callImage];
    [callImage autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [callImage autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [callImage autoSetDimensionsToSize:CGSizeMake(30, 30)];
    return cell;
}

- (void)callPhone:(UIButton *)sender{
    PeopleInfo *info=[_rightDataList objectAtIndex:sender.tag];
    NSArray *telePhone=[info.telephone componentsSeparatedByString:@","];
    NSArray *phone=[info.phone componentsSeparatedByString:@","];
    NSArray *array=[telePhone arrayByAddingObjectsFromArray:phone];
    UIAlertController *firVC=[[UIAlertController alloc]init];
    __weak typeof (self)weakSelf=self;
    for (NSString *string in array) {
        if (string.length>0) {
            UIAlertAction *action=[UIAlertAction actionWithTitle:string style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [SwpTools swpToolCallPhone:string superView:weakSelf.view];
            }];
            [firVC addAction:action];
            
        }
    }
    UIAlertAction *actionCancell=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [firVC dismissViewControllerAnimated:YES completion:nil];
    }];
    [firVC addAction:actionCancell];
    [self.navigationController presentViewController:firVC animated:YES completion:nil];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView==_tableViewLeft) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 40)];
        view.backgroundColor=[UIColor redColor];
        UILabel *laber=[[UILabel alloc]initWithFrame:view.bounds];
        laber.text=_dataList.groupName;
        laber.textAlignment=NSTextAlignmentCenter;
        laber.textColor=[UIColor whiteColor];
        [view addSubview:laber];
        
        return view;
    }
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 40)];
    view.backgroundColor=[UIColor redColor];
    UILabel *laber=[[UILabel alloc]initWithFrame:view.bounds];
    laber.text=rightTitle;
    laber.textColor=[UIColor whiteColor];
    [view addSubview:laber];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == _tableViewRight) {
        CallInfoViewController *firvc=[[CallInfoViewController alloc]init];
        firvc.peopleInfo=[_rightDataList objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:firvc animated:YES];
        return;
    }
    
    [_rightDataList removeAllObjects];
    
    NSString *string =_leftDataList[indexPath.row];
    rightTitle=string;
    
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
    return 40;
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
        _tableViewRight.layer.cornerRadius=5;
    }
    return _tableViewRight;
}
@end
