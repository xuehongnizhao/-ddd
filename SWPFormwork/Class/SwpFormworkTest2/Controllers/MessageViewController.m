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


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getDataFromNet];
    [self setUI];
}
- (void)getDataFromNet{
    NSDictionary *dic=@{
                        @"peopleId":GetUserDefault(peopleId)
                        };
    [SwpRequest swpPOST:@"http://address.hongdingnet.com/web/contacts/getInform" parameters:dic isEncrypt:NO swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
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
    [_messageTableView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:5];
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
    return 110;
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
    label.font=[UIFont systemFontOfSize:16];
    label.textColor=[UIColor redColor];
    label.text=info.title;
    label.textAlignment=NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    [label autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [label autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [label autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [label autoSetDimension:ALDimensionHeight toSize:40];
    
    UILabel *labelContent=[[UILabel alloc]initForAutoLayout];
    labelContent.textColor=[UIColor grayColor];
    labelContent.numberOfLines=0;
    labelContent.font=[UIFont systemFontOfSize:16];
    labelContent.text=info.content;
    [cell.contentView addSubview:labelContent];
    [labelContent autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10];
    [labelContent autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [labelContent autoSetDimension:ALDimensionHeight toSize:50];
    [labelContent autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:label];
    
    UILabel *timeLabel=[[UILabel alloc]initForAutoLayout];
    timeLabel.textColor=[UIColor grayColor];
    timeLabel.numberOfLines=0;
    timeLabel.font=[UIFont systemFontOfSize:14];
    NSRange range=[info.releaseTime rangeOfString:@"00:00:00"];
    NSMutableString *sting=[NSMutableString stringWithFormat:@"%@",info.releaseTime];
    [sting deleteCharactersInRange:range];
    timeLabel.text=sting;
    timeLabel.textAlignment=NSTextAlignmentRight;
    [cell.contentView addSubview:timeLabel];
    [timeLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:2];
    [timeLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10];
    [timeLabel autoSetDimensionsToSize:CGSizeMake(SCREEN_WIDTH, 15)];
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
