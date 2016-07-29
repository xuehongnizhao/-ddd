//
//  SwpShareView.m
//  swp_song
//
//  Created by songweiping on 16/3/7.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import "SwpShareView.h"

/*! ---------------------- Tool       ---------------------- !*/ 
#import "SwpShareTools.h"                // 工具
/*! ---------------------- Tool       ---------------------- !*/

/*! ---------------------- View       ---------------------- !*/
#import "SwpShareShowView.h"            // 显示分享view
/*! ---------------------- View       ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/
#import "SwpShareModel.h"               // 分享数据模型
/*! ---------------------- Model      ---------------------- !*/

#define SwpShareViewWidth  [[UIScreen mainScreen] bounds].size.width
#define SwpShareViewHeight [[UIScreen mainScreen] bounds].size.height


static NSString * const kSwpShareViewCellID   = @"kSwpShareViewCellID";

@interface SwpShareView () <SwpShareShowViewDelegate>

#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
/*! 显示分享 view !*/
@property (nonatomic, strong) SwpShareShowView *swpShareShowView;
/*! ---------------------- UI   Property  ---------------------- !*/

#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
/*! 显示分享view 数据源 !*/
@property (nonatomic, copy  ) NSArray *swpShareDataSource;
/*! Delegate !*/
@property (nonatomic, weak  ) id<SwpShareViewDelegate > delegate;
/*! 点击cell 回调 !*/
@property (nonatomic, copy, setter = swpShareViewDidSelectItemAtIndexBlock:) SwpShareViewDidSelectItemAtIndexBlock swpShareViewDidSelectItemAtIndexBlock;
/*! ---------------------- Data Property  ---------------------- !*/

@end



@implementation SwpShareView


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
+ (instancetype)swpShareViewWithShareTitleDataSource:(NSArray *)shareTitleDataSource shareImageDataSource:(NSArray *)shareImageDataSource swpShareViewDelegate:(id<SwpShareViewDelegate>)delegate {
    return [[SwpShareView alloc] initSwpShareViewWithFrame:CGRectZero shareTitleDataSource:shareTitleDataSource shareImageDataSource:shareImageDataSource swpShareViewDelegate:delegate];
}


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
- (instancetype)initSwpShareViewWithFrame:(CGRect)frame shareTitleDataSource:(NSArray *)shareTitleDataSource shareImageDataSource:(NSArray *)shareImageDataSource swpShareViewDelegate:(id<SwpShareViewDelegate>)delegate {
    if (shareImageDataSource.count != shareTitleDataSource.count) return nil;
    if (self = [super initWithFrame:frame]) {
        _delegate           = delegate;
        _swpShareDataSource = [SwpShareModel swpShareWithWithSwpShareTitleArray:shareTitleDataSource swpShareImageArray:shareImageDataSource];
        [self settingSwpShareViewProperty];
        [self setUpUI];
    }
    return self;
}


/*!
 *  @author swp_song, 16-03-30 16:03:20
 *
 *  @brief  settingSwpShareViewProperty ( 设置 公用 属性 )
 */
- (void)settingSwpShareViewProperty {
    self.frame           = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [UIColor blackColor];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [SwpShareTools settingTapGestureRecognizer:self viewTag:0 clickCount:1 addTarget:self action:@selector(clickView:) cancelsTouchesInView:NO];
    
    [SwpShareTools settingTapGestureRecognizer:self.swpShareShowView viewTag:1 clickCount:1 addTarget:self action:@selector(clickView:) cancelsTouchesInView:NO];
    [[[UIApplication sharedApplication].delegate window] addSubview:self];
}


/*!
 *  @author swp_song
 *
 *  @brief  setupUI ( 添加控件 | 设置控件自动布局 )
 */
- (void) setUpUI {
    [self addSubview:self.swpShareShowView];
}

#pragma mark - SwpShareShowView Delegate
/*!
 *  @author swp_song
 *
 *  @brief  swpShareShowViewDidSwpShareDismissButton:   ( 按钮 绑定方 )
 *
 *  @param  swpShareShowView
 */
- (void)swpShareShowViewDidSwpShareDismissButton:(SwpShareShowView *)swpShareShowView {
    [self swpShareViewDismiss];
}


/*!
 *  @author swp_song
 *
 *  @brief
 *
 *  @param  swpShareShowView
 *
 *  @param  index
 */
- (void)swpShareShowView:(SwpShareShowView *)swpShareShowView didSelectItemAtIndex:(NSInteger)index {
    
    if (self.swpShareViewDidSelectItemAtIndexBlock) self.swpShareViewDidSelectItemAtIndexBlock(self, index);
    if ([self.delegate respondsToSelector:@selector(swpShareView:didSelectItemAtIndex:)]) {
        [self.delegate swpShareView:self didSelectItemAtIndex:index];
    }
    [self swpShareViewDismiss];
}

/*!
 *  @author swp_song
 *
 *  @brief  clickView: ( view 绑定 方法 )
 *
 *  @param  tap
 *
 *  @since
 */
- (void)clickView:(UITapGestureRecognizer *)tap {
    if (tap.view.tag == 0) [self swpShareViewDismiss];
}

/*!
 *  @author swp_song
 *
 *  @brief  swpShareViewDismiss:    ( 移除 SwpShareView   )
 */
- (void)swpShareViewDismiss {
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.swpShareShowView.frame;
        self.swpShareShowView.frame = CGRectMake(frame.origin.x, self.frame.size.height, frame.size.width, 0);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Public

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareViewTitleText:   ( 设置 分享title文字 )
 *
 *  @param  swpShareViewTitleText
 */
- (void)setSwpShareViewTitleText:(NSString *)swpShareViewTitleText {
    _swpShareViewTitleText                  = swpShareViewTitleText;
    self.swpShareShowView.swpShareTitleText = _swpShareViewTitleText;
}


/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareViewTitleTextColor   ( 设置 分享title文字颜色 )
 *
 *  @param  swpShareViewTitleTextColor
 */
- (void)setSwpShareViewTitleTextColor:(UIColor *)swpShareViewTitleTextColor {
    _swpShareViewTitleTextColor                  = swpShareViewTitleTextColor;
    self.swpShareShowView.swpShareTitleTextColor = _swpShareViewTitleTextColor;
}

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareViewDismissButtonTitleText:  ( 设置 取消按钮 文字 )
 *
 *  @param  swpShareViewDismissButtonTitleText
 */
- (void)setSwpShareViewDismissButtonTitleText:(NSString *)swpShareViewDismissButtonTitleText {
    _swpShareViewDismissButtonTitleText                  = swpShareViewDismissButtonTitleText;
    self.swpShareShowView.swpShareDismissButtonTitleText = _swpShareViewDismissButtonTitleText;
}


/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareViewDismissButtonTitleTextColor: ( 设置 取消按钮 文字颜色 )
 *
 *  @param  swpShareViewDismissButtonTitleTextColor
 */
- (void)setSwpShareViewDismissButtonTitleTextColor:(UIColor *)swpShareViewDismissButtonTitleTextColor {
    _swpShareViewDismissButtonTitleTextColor = swpShareViewDismissButtonTitleTextColor;
    self.swpShareViewDismissButtonTitleTextColor = _swpShareViewDismissButtonTitleTextColor;
}

/*!
 *  @author swp_song
 *
 *  @brief  swpShareViewDidSelectItemAtIndexBlock:  ( 点击 分享 cell 回调 )
 *
 *  @param  swpShareViewDidSelectItemAtIndexBlock
 */
- (void)swpShareViewDidSelectItemAtIndexBlock:(SwpShareViewDidSelectItemAtIndexBlock)swpShareViewDidSelectItemAtIndexBlock {
    _swpShareViewDidSelectItemAtIndexBlock = swpShareViewDidSelectItemAtIndexBlock;
}

#pragma mark - Init UI Methods
- (SwpShareShowView *)swpShareShowView {
    
    return !_swpShareShowView ? _swpShareShowView = ({
        SwpShareShowView *swpShareShowView = [SwpShareShowView swpShareShowViewWithFrame:CGRectMake(0, SwpShareViewHeight - 160, SwpShareViewWidth, 160) dataSource:self.swpShareDataSource delegate:self];
    
        swpShareShowView;
    }) : _swpShareShowView;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
