//
//  SwpUtils.h
//  SwpFormwork
//
//  Created by swp_song on 16/5/16.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UITableView;

NS_ASSUME_NONNULL_BEGIN

/*! SwpResultSuccess 访问服务器返回成功 Block !*/
typedef void(^ResultSuccess)(id resultObject);
/*! SwpResultError   访问服务器返回失败 Block !*/
typedef void(^ResultError)(id resultObject, NSString *errorMessage);


@interface SwpUtils : NSObject

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
+ (void)swpUtilsGetDataToServer:(NSString *)URLString parameters:(NSDictionary *)parameter isEncrypt:(BOOL)encrypt swpResultSuccess:(ResultSuccess)resultSuccess swpResultError:(ResultError)resultError;

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
+ (void)swpUtilsSetTableViewRefreshing:(UITableView *)tableView target:(id)target headerAction:(SEL)headerAction footerAction:(SEL)footerAction;

@end


NS_ASSUME_NONNULL_END
