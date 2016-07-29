//
//  SwpShareView.h
//  swp_song
//
//  Created by songweiping on 16/3/7.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import <UIKit/UIKit.h>



@class SwpShareView;



NS_ASSUME_NONNULL_BEGIN

/*! 点击cell回调 !*/
typedef void(^SwpShareViewDidSelectItemAtIndexBlock)(SwpShareView *swpShareView, NSInteger index);

@protocol SwpShareViewDelegate <NSObject>

@optional
/*!
 *  @author swp_song
 *
 *  @brief  swpShareView:didSelectItemAtIndex:  ( swpShareView 代理方法 点击 cell 调用 )
 *
 *  @param  swpShareView
 *
 *  @param  index
 */
- (void)swpShareView:(SwpShareView *)swpShareView didSelectItemAtIndex:(NSInteger)index;

@optional


@end


@interface SwpShareView : UIView

/*!
 *  @author swp_song, 16-03-30 16:03:24
 *
 *  @brief  swpShareViewWithShareTitleDataSource:shareTitleDataSource:shareImageDataSource:swpShareViewDelegate:    ( 快速初始化 一个 SwpShareView )
 *
 *  @param  shareTitleDataSource
 *
 *  @param  shareImageDataSource
 *
 *  @param  delegate
 *
 *  @return SwpShareView
 
 */
+ (instancetype)swpShareViewWithShareTitleDataSource:(NSArray *)shareTitleDataSource shareImageDataSource:(NSArray *)shareImageDataSource swpShareViewDelegate:(id<SwpShareViewDelegate>)delegate;

/*!
 *  @author swp_song
 *
 *  @brief  initSwpShareViewWithFrame:shareTitleDataSource:shareImageDataSource:swpShareViewDelegate:    ( 初始化 一个 SwpShareView )
 *
 *  @param  frame
 *
 *  @param  shareTitleDataSource
 *
 *  @param  shareImageDataSource
 *
 *  @param  delegate
 *
 *  @return
 */
- (instancetype)initSwpShareViewWithFrame:(CGRect)frame shareTitleDataSource:(NSArray *)shareTitleDataSource shareImageDataSource:(NSArray *)shareImageDataSource swpShareViewDelegate:(id<SwpShareViewDelegate>)delegate;

/*! 设置 分享title文字     !*/
@property (nonatomic, copy  ) NSString *swpShareViewTitleText;
/*! 设置 分享title文字颜色 !*/
@property (nonatomic, strong) UIColor  *swpShareViewTitleTextColor;
/*! 设置 取消按钮 文字     !*/
@property (nonatomic, copy  ) NSString *swpShareViewDismissButtonTitleText;
/*! 设置 取消按钮 文字颜色 !*/
@property (nonatomic, strong) UIColor  *swpShareViewDismissButtonTitleTextColor;

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareViewTitleText:   ( 设置 分享title文字 )
 *
 *  @param  swpShareViewTitleText
 */
- (void)setSwpShareViewTitleText:(NSString *)swpShareViewTitleText;

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareViewTitleTextColor   ( 设置 分享title文字颜色 )
 *
 *  @param  swpShareViewTitleTextColor
 */
- (void)setSwpShareViewTitleTextColor:(UIColor *)swpShareViewTitleTextColor;

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareViewDismissButtonTitleText:  ( 设置 取消按钮 文字 )
 *
 *  @param swpShareViewDismissButtonTitleText
 */
- (void)setSwpShareViewDismissButtonTitleText:(NSString *)swpShareViewDismissButtonTitleText;

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareViewDismissButtonTitleTextColor: ( 设置 取消按钮 文字颜色 )
 *
 *  @param  swpShareViewDismissButtonTitleTextColor
 */
- (void)setSwpShareViewDismissButtonTitleTextColor:(UIColor *)swpShareViewDismissButtonTitleTextColor;

/*!
 *  @author swp_song
 *
 *  @brief  swpShareViewDidSelectItemAtIndexBlock:  ( 点击 分享 cell 回调 )
 *
 *  @param  swpShareViewDidSelectItemAtIndexBlock
 */
- (void)swpShareViewDidSelectItemAtIndexBlock:(SwpShareViewDidSelectItemAtIndexBlock)swpShareViewDidSelectItemAtIndexBlock;


@end
NS_ASSUME_NONNULL_END