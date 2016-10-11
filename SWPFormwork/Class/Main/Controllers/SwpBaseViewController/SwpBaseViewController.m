//
//  SwpBaseViewController.m
//  SwpFormwork
//
//  Created by swp_song on 16/5/16.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "SwpBaseViewController.h"

/*! ---------------------- Tools      ---------------------- !*/
#import <UINavigationController+FDFullscreenPopGesture.h>   // 手势
#import "UINavigationBar+BackgroundColor.h"                 // UINavigationBar Color
#import <SwpTools/SwpTools.h>                               // 工具类
/*! ---------------------- Tools      ---------------------- !*/

@interface SwpBaseViewController ()

@end

@implementation SwpBaseViewController

#pragma mark - Lifecycle Methods
/*!
 *  @author swp_song
 *
 *  @brief  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingBaseViewControllerProperty];
    
}

/*!
 *  @author swp_song
 *
 *  @brief  将要加载出视图 调用
 *
 *  @param  animated
 */
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

/*!
 *  @author swp_song
 *
 *  @brief  视图 显示 窗口时 调用
 *
 *  @param  animated
 */
- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/*!
 *  @author swp_song
 *
 *  @brief 视图  即将消失、被覆盖或是隐藏时调用
 *
 *  @param animated
 */
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

/*!
 *  @author swp_song
 *
 *  @brief  视图已经消失、被覆盖或是隐藏时调用
 *
 *  @param  animated
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

/*!
 *  @author swp_song
 *
 *  @brief  内存不足时 调用
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*!
 *  @author swp_song
 *
 *  @brief  当前 控制器 被销毁时 调用
 */
- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - Setting BaseViewController Property

/*!
 *  @author swp_song
 *
 *  @brief  设置 BaseViewController 自身的属性
 */
- (void)settingBaseViewControllerProperty {
    
    self.edgesForExtendedLayout                                         = UIRectEdgeNone;
    self.view.backgroundColor                                           = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem                               = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationBarTitleSize                                         = 15;
    [self.navigationController.navigationBar swp_SetBackgroundColor:[UIColor swpColorFromHEX:0xe31f0e]];
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled = YES;
    self.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge           = [SwpTools swpToolScreenWidth] / 5.0;
}

/*!
 *  @author swp_song
 *
 *  @brief  setBaseViewBackgroundColor: ( 设置父类背景颜色 )
 *
 *  @param baseViewBackgroundColor
 */
- (void)setBaseViewBackgroundColor:(UIColor *)baseViewBackgroundColor {
    _baseViewBackgroundColor  = baseViewBackgroundColor;
    self.view.backgroundColor = _baseViewBackgroundColor;
}

/*!
 *  @author swp_song
 *
 *  @brief  setNavigationBarTitleSize: ( 设置 setNavigationBarTitleSize )
 *
 *  @param  navigationBarTitleSize
 */
- (void)setNavigationBarTitleSize:(CGFloat)navigationBarTitleSize {
    _navigationBarTitleSize = navigationBarTitleSize;
}


#pragma mark - Setting NavigationBar Title & TitleFontSize Method
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
- (void)setNavigationBarTitle:(NSString *)title textColor:(UIColor *)textColot titleFontSize:(NSNumber *)fontSize {
    //自定义标题
    UILabel* titleLabel           = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.font               = [UIFont systemFontOfSize:fontSize == nil ? self.navigationBarTitleSize : fontSize.floatValue];
    titleLabel.backgroundColor    = nil;
    //设置Label背景透明
    titleLabel.textColor          = textColot == nil ? [UIColor whiteColor] : textColot;
    //设置文本颜色
    titleLabel.textAlignment      = NSTextAlignmentCenter;
    titleLabel.opaque             = NO;
    titleLabel.text               = title == nil ? @"Title Test" : title;
    //设置标题
    self.navigationItem.titleView = titleLabel;
}


#pragma mark - Init Data Methods
- (SwpNetworkModel *)swpNetwork {
    if (!_swpNetwork) {
        _swpNetwork                   = [SwpNetworkModel shareInstance];
        _swpNetwork.swpNetworkEncrypt = YES;
    }
    return _swpNetwork;
}





@end
