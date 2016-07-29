//
//  SwpShareShowView.h
//  swp_song
//
//  Created by songweiping on 16/3/9.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SwpShareShowView;



NS_ASSUME_NONNULL_BEGIN

@protocol SwpShareShowViewDelegate <NSObject>

@optional

/*!
 *  @author swp_song
 *
 *  @brief  swpShareShowViewDidSwpShareDismissButton:   ( swpShareShowView 代理方法 点击取消按钮调用 )
 *
 *  @param swpShareShowView
 */
- (void)swpShareShowViewDidSwpShareDismissButton:(SwpShareShowView *)swpShareShowView;

/*!
 *  @author swp_song
 *
 *  @brief  swpShareShowView:didSelectItemAtIndex:  ( swpShareShowView 代理方法 点击分享每个cell调用 )
 *
 *  @param  swpShareShowView
 *
 *  @param  index
 */
- (void)swpShareShowView:(SwpShareShowView *)swpShareShowView didSelectItemAtIndex:(NSInteger)index;

@end

@interface SwpShareShowView : UIView

/*! 设置 分享 title 文字     !*/
@property (nonatomic, copy  ) NSString *swpShareTitleText;
/*! 设置 分享 title 文字颜色 !*/
@property (nonatomic, strong) UIColor  *swpShareTitleTextColor;
/*! 设置取消按钮文字         !*/
@property (nonatomic, copy  ) NSString *swpShareDismissButtonTitleText;
/*! 设置取消按钮文字颜色     !*/
@property (nonatomic, strong) UIColor  *swpShareDismissButtonTitleTextColor;

/*!
 *  @author swp_song
 *
 *  @brief  swpShareShowViewWithFrame:dataSource:delegate   ( 快速初始化 一个 SwpShareShowView )
 *
 *  @param  frame
 *
 *  @param  dataSource
 *
 *  @param  delegate
 *
 *  @return SwpShareShowView
 */
+ (instancetype)swpShareShowViewWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource delegate:(id<SwpShareShowViewDelegate>)delegate;

/*!
 *  @author swp_song
 *
 *  @brief  initSwpShareShowViewWithFrame:dataSource:delegate:  ( 初始化 一个 SwpShareShowView )
 *
 *  @param  frame
 *
 *  @param  dataSource
 *
 *  @param  delegate
 *
 *  @return SwpShareShowView
 */
- (instancetype)initSwpShareShowViewWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource delegate:(id<SwpShareShowViewDelegate>)delegate;

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareTitleText:   ( 设置 分享 title 文字 )
 *
 *  @param  swpShareTitleText
 */
- (void)setSwpShareTitleText:(NSString *)swpShareTitleText;

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareTitleTextColor:  ( 设置 分享 title 文字颜色 )
 *
 *  @param  swpShareTitleTextColor
 */
- (void)setSwpShareTitleTextColor:(UIColor *)swpShareTitleTextColor;

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareDismissButtonTitleText:  ( 设置取消按钮文字 )
 *
 *  @param  swpShareDismissButtonTitleText
 */
- (void)setSwpShareDismissButtonTitleText:(NSString *)swpShareDismissButtonTitleText;

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareDismissButtonTitleTextColor: ( 设置取消按钮文字颜色 )
 *
 *  @param  swpShareDismissButtonTitleTextColor
 */
- (void)setSwpShareDismissButtonTitleTextColor:(UIColor *)swpShareDismissButtonTitleTextColor;


@end

NS_ASSUME_NONNULL_END
