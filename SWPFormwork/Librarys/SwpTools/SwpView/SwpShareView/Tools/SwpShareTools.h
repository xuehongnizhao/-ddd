//
//  SwpShareTools.h
//  swp_song
//
//  Created by songweiping on 16/3/9.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import <Foundation/Foundation.h>


@class UIView, UIColor, UITapGestureRecognizer;

NS_ASSUME_NONNULL_BEGIN


@interface SwpShareTools : NSObject

/*!
 *  @author swp_song, 2016-03-09 11:12:37
 *
 *  @brief  swpColorFromHEX ( 根据16进制获取颜色 )
 *
 *  @param  hexValue        ( 16进制色值 )
 *
 *  @return UIColor
 *
 *  @since  1.0.1
 */
+ (UIColor *)swpColorFromHEX:(NSInteger)hexValue;
/*!
 *  @author swp_song, 2015-12-28 15:18:35
 *
 *  @brief  swpToolSettingTapGestureRecognizer  ( Setting View UITapGestureRecognizer <绑定 一个 点击事件 给一个 view> )
 *
 *  @param view
 *
 *  @param tag
 *
 *  @param count
 *
 *  @param target
 *
 *  @param action
 *
 *  @param cancels
 *
 *  @return
 *
 *  @since  1.0.4
 */
+ (UITapGestureRecognizer *)settingTapGestureRecognizer:(UIView *)view viewTag:(NSInteger)tag clickCount:(NSInteger)count addTarget:(id)target action:(SEL)action cancelsTouchesInView:(BOOL)cancels;

@end

NS_ASSUME_NONNULL_END
