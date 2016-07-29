//
//  AppDelegate+MasterInterfaceData.h
//  SwpFormwork
//
//  Created by swp_song on 16/5/16.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN
@interface AppDelegate (MasterInterfaceData)

/*!
 *  @author swp_song
 *
 *  @brief  swpSetMasterInterfaceBaseURL:baseSet:   ( 设置 网络环境 )
 *
 *  @param  baseURL
 *
 *  @param  baseSet
 */
+ (void)swpSetMasterInterfaceBaseURL:(NSString *)baseURL baseSet:(NSString *)baseSet;

/*!
 *  @author swp_song
 *
 *  @brief  swpGetMasterInterfaceData:resultError:  ( 获取 主接口 数据 )
 *
 *  @param  resultSuccess
 *
 *  @param  resultError
 */
+ (void)swpGetMasterInterfaceData:(nullable void(^)())resultSuccess resultError:(nullable void(^)())resultError;

@end
NS_ASSUME_NONNULL_END
