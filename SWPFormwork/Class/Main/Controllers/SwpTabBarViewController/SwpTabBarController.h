//
//  SwpTabBarController.h
//  SwpFormwork
//
//  Created by swp_song on 16/5/16.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import <RDVTabBarController/RDVTabBarController.h>

NS_ASSUME_NONNULL_BEGIN
@interface SwpTabBarController : RDVTabBarController

/*!
 *  @author swp_song
 *
 *  @brief  shareInstance   ( 快速 初始化 用户数据模型 单利方法 )
 *
 *  @return SwpTabBarController
 */
+ (instancetype)shareInstance;

/*!
 *  @author swp_song
 *
 *  @brief  swpTabBarDidSelectItemAtIndex:   ( 点击 TabBar 回到 )
 *
 *  @param  swpTabBarDidSelectItemAtIndex
 */
- (void)swpTabBarDidSelectItemAtIndex:(void (^)(NSInteger itemAtIndex))swpTabBarDidSelectItemAtIndex;

@end
NS_ASSUME_NONNULL_END
