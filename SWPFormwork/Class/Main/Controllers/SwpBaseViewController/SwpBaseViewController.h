//
//  SwpBaseViewController.h
//  SwpFormwork
//
//  Created by swp_song on 16/5/16.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SwpFormworkHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface SwpBaseViewController : UIViewController

/*! 网路数据信息参数                   !*/
@property (nonatomic, strong) SwpNetworkModel *swpNetwork;
/*! 设置 背景颜色                     !*/
@property (nonatomic, strong) UIColor         *baseViewBackgroundColor;
/*! navigationBarTitleSize 文字大小  !*/
@property (nonatomic, assign) CGFloat         navigationBarTitleSize;

/*!
 *  @author swp_song
 *
 *  @brief  setNavigationBarTitle:textColor:titleFontSize:  （ 设置 导航控制器 显示 文字 颜色 字体 小大 )
 *
 *  @param  title     标题名称
 *
 *  @param  textColot 文字 颜色 (nil 默认 显示黑色)
 *
 *  @param  fontSize  文字大小  NSNumber type
 */
- (void)setNavigationBarTitle:(nullable NSString *)title textColor:(nullable UIColor *)textColot titleFontSize:(nullable NSNumber *)fontSize;
/*!
 *  @author swp_song
 *
 *  @brief  setBaseViewBackgroundColor ( 设置父类背景颜色 )
 *
 *  @param baseViewBackgroundColor
 */
- (void)setBaseViewBackgroundColor:(UIColor *)baseViewBackgroundColor;

/*!
 *  @author swp_song
 *
 *  @brief  setNavigationBarTitleSize ( 设置 setNavigationBarTitleSize )
 *
 *  @param  navigationBarTitleSize
 */
- (void)setNavigationBarTitleSize:(CGFloat)navigationBarTitleSize;


@end

NS_ASSUME_NONNULL_END
