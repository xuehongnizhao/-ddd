//
//  MessageViewController.m
//  SwpFormwork
//
//  Created by mac on 16/9/23.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageInfo.h"
#import "WebViewController.h"
@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *messageTableView;
@property (strong, nonatomic) NSMutableArray *dataList;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataFromNet];
    [self setUI];
    
}

- (void)getDataFromNet{
    NSDictionary *dic=@{
                        @"peopleId":GetUserDefault(peopleId)
                        };
    [SwpRequest swpPOST:@"http://139.129.218.191:8080/web/contacts/getInform" parameters:dic isEncrypt:NO swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        _dataList=[NSMutableArray array];
        NSArray *arr=[resultObject objectForKey:@"appInforDatas"];
        for (NSDictionary *dic in arr) {
            MessageInfo *info=[MessageInfo mj_objectWithKeyValues:dic];
            [_dataList addObject:info];
            [self.messageTableView reloadData];
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        
    }];
}
- (void)setUI{
    [self setNavigationBarTitle:@"通知" textColor:[UIColor whiteColor] titleFontSize:@20];
    [self.view addSubview:self.messageTableView];
    [_messageTableView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [_messageTableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [_messageTableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [_messageTableView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:64];
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [_messageTableView setTableFooterView:view];
    
}

#pragma mark --- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
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
    MessageInfo *info=_dataList[indexPath.row];
    UILabel *label=[[UILabel alloc]initForAutoLayout];
    label.numberOfLines=0;
    label.text=info.title;
    [cell.contentView addSubview:label];
    [label autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [label autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    WebViewController *firVC=[[WebViewController alloc]init];
    MessageInfo *info= self.dataList[indexPath.row];
    firVC.webID=info.ID;
    [self.navigationController pushViewController:firVC animated:YES];
}
- (UITableView *)messageTableView{
    if (!_messageTableView) {
        _messageTableView=[[UITableView alloc]initForAutoLayout];
        _messageTableView.dataSource=self;
        _messageTableView.delegate=self;
        
    }
    return _messageTableView;
}
@end
