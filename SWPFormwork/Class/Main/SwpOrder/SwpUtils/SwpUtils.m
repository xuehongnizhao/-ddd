//
//  SwpUtils.m
//  SwpFormwork
//
//  Created by swp_song on 16/5/16.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "SwpUtils.h"

/*! ---------------------- Tools      ---------------------- !*/
#import "UIColor+SwpColor.h"                // Color 分类
#import <SwpRequest/SwpRequest.h>           // 网络请求
#import <MJRefresh/MJRefresh.h>             // MJ 刷新框架
#import <SVProgressHUD/SVProgressHUD.h>     // SVProgressHUD
/*! ---------------------- Tools      ---------------------- !*/

/*! ---------------------- Controller ---------------------- !*/
/*! ---------------------- Controller ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/
#import "SwpNetworkModel.h"                 // 网络 请求 数据模型
/*! ---------------------- Model      ---------------------- !*/

@implementation SwpUtils

/*!
 *  @author swp_song
 *
 *  @brief  swpUtilsGetDataToServer:parameters:isEncrypt:resultSuccess:resultError:  ( 从服务器 获取 网络 数据 )
 *
 *  @param  URLString               url
 *
 *  @param  parameter               参数
 *
 *  @param  encrypt                 是否加密
 *
 *  @param  resultSuccess           返回成功    200
 *
 *  @param  resultError             返回失败    400
 */
+ (void)swpUtilsGetDataToServer:(NSString *)URLString parameters:(NSDictionary *)parameter isEncrypt:(BOOL)encrypt swpResultSuccess:(ResultSuccess)resultSuccess swpResultError:(ResultError)resultError {
    
    SwpNetworkModel *swpNetwork = [SwpNetworkModel shareInstance];
    
    [SwpRequest swpPOST:URLString parameters:parameter isEncrypt:encrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        [SVProgressHUD dismiss];
        if (resultObject == nil) {
            [SVProgressHUD showErrorWithStatus:swpNetwork.swpNetworkDataNULL];
            return;
        }
        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            resultSuccess(resultObject);
        } else {
            resultError(resultObject, resultObject[swpNetwork.swpNetworkMessage]);
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        [SVProgressHUD showErrorWithStatus:[SwpNetworkModel swpChekNetworkError:errorMessage]];
    }];
}


#pragma mark - Sm Refreshing
/*!
 *  @author swp_song
 *
 *  @brief  swpUtilsSetTableViewRefreshing:target:headerAction:footerAction: ( 设置tableView 刷新组件 )
 *
 *  @param  tableView                   需要设置的tableView
 *
 *  @param  target                      监听
 *
 *  @param  headerAction                头部刷新方法
 *
 *  @param  footerAction                尾部刷新方法
 */
+ (void)swpUtilsSetTableViewRefreshing:(UITableView *)tableView target:(id)target headerAction:(SEL)headerAction footerAction:(SEL)footerAction {
    
    // 设置 头部刷新组件
    if (headerAction != nil) tableView.mj_header = [SwpUtils swpUtilsSetRefreshLabelHeader:target headerAction:headerAction];
    
    // 设置 尾部加载组件
    if (footerAction != nil) tableView.mj_footer = [SwpUtils swpUtilsSetRefreshLabelFooter:target footerAction:footerAction footerTitle:nil];
}


/*!
 *  @author swp_song
 *
 *  @brief  swpUtilsSetRefreshLabelHeader:headerAction:  ( 设置 头部刷新组件 < 文字 > )
 *
 *  @param  target
 *
 *  @param  headerAction
 *
 *  @return MJRefreshNormalHeader
 */
+ (MJRefreshNormalHeader *)swpUtilsSetRefreshLabelHeader:(id)target headerAction:(SEL)headerAction {
    MJRefreshNormalHeader *header    = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:headerAction];
    header.stateLabel.font           = [UIFont systemFontOfSize:12];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
    [header setTitle:[SwpNetworkModel shareInstance].swpNetworkRefreshDataTitle forState:MJRefreshStateRefreshing];
    return header;
}

/*!
 *  @author swp_song
 *
 *  @brief  swpUtilsSetRefreshLabelFooter:footerAction:footerTitle:   ( 设置 尾部加载组件 < 文字 > )
 *
 *  @param  target
 *
 *  @param  footerAction
 *
 *  @param  footerTitle
 *
 *  @return MJRefreshAutoNormalFooter
 */
+ (MJRefreshAutoNormalFooter *)swpUtilsSetRefreshLabelFooter:(id)target footerAction:(SEL)footerAction footerTitle:(NSString *)footerTitle {
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:footerAction];
    footer.automaticallyRefresh       = NO;
    footer.automaticallyHidden        = NO;
    // 设置字体
    footer.stateLabel.font            = [UIFont systemFontOfSize:12];
    
    [footer setTitle:footerTitle == nil ? [SwpNetworkModel shareInstance].swpNetworkToLoadDataTitle : footerTitle  forState:MJRefreshStateRefreshing];
    [footer setTitle:footerTitle == nil ? [SwpNetworkModel shareInstance].swpNetworkNotData : @"" forState:MJRefreshStateNoMoreData];
    
    return footer;
}

@end
