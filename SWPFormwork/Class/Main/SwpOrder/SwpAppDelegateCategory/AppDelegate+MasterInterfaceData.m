//
//  AppDelegate+MasterInterfaceData.m
//  SwpFormwork
//
//  Created by swp_song on 16/5/16.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "AppDelegate+MasterInterfaceData.h"

/*! ---------------------- Tool       ---------------------- !*/
#import <SwpTools/SwpTools.h>           // 用具
#import <SwpRequest/SwpRequest.h>       // 网络请求
#import <SwpTools/SwpGetIp.h>           // 获取Ip
/*! ---------------------- Tool       ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/
#import "SwpNetworkModel.h"             // 网络请求数据模型
/*! ---------------------- Model      ---------------------- !*/

@implementation AppDelegate (MasterInterfaceData)

/*!
 *  @author swp_song
 *
 *  @brief  swpSetMasterInterfaceBaseURL:baseSet:   ( 设置 网络环境 )
 *
 *  @param  baseURL
 *
 *  @param  baseSet
 */
+ (void)swpSetMasterInterfaceBaseURL:(NSString *)baseURL baseSet:(NSString *)baseSet {
    [SwpNetworkModel swpNetworkSetBaseURL:baseURL baseSet:baseSet];
}

/*!
 *  @author swp_song
 *
 *  @brief  swpGetMasterInterfaceData:resultError:  ( 获取 主接口 数据 )
 *
 *  @param  resultSuccess
 *
 *  @param  resultError
 */
+ (void)swpGetMasterInterfaceData:(void(^)())resultSuccess resultError:(void(^)())resultError {
    
    SwpNetworkModel *swpNetwork = [SwpNetworkModel shareInstance];
    NSString        *url        = [NSString stringWithFormat:@"%@%@", swpNetwork.swpNetworkBaseURL, swpNetwork.swpNetworkBaseSet];
    NSDictionary    *dictionary = @{
                                    @"app_key"       : url,
                                    @"sys_type"      : [[UIDevice currentDevice] systemName],
                                    @"sys_version"   : [[UIDevice currentDevice] systemVersion],
                                    @"model"         : [[UIDevice currentDevice] model],
                                    @"user_ip"       : [SwpGetIp swpGetIphoneIpAddress],
                                    @"device_type"   : @"iPhone",
                                    @"brand"         : @"苹果",
                                    };
    
    [SwpRequest swpPOST:url parameters:dictionary isEncrypt:swpNetwork.swpNetworkEncrypt swpResultSuccess:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull resultObject) {
        if (swpNetwork.swpNetworkCodeSuccess == [resultObject[swpNetwork.swpNetworkCode] intValue]) {
            if ([SwpTools swpToolDataWriteToPlist:resultObject plistName:nil]) {
                NSLog(@"%@", resultObject);
                if (resultSuccess) resultSuccess();
            }
        } else {
            NSLog(@"%@", resultObject[swpNetwork.swpNetworkMessage]);
            resultError();
        }
    } swpResultError:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error, NSString * _Nonnull errorMessage) {
        NSLog(@"%@", errorMessage);
        if (resultError) resultError();
    }];


}

@end
