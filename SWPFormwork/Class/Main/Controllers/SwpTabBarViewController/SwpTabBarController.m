//
//  SwpTabBarController.m
//  SwpFormwork
//
//  Created by swp_song on 16/5/16.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "SwpTabBarController.h"

/*! ---------------------- Tool       ---------------------- !*/
#import <RDVTabBarController/RDVTabBarItem.h>   // TarBarItem
#import "UIColor+SwpColor.h"                    // Color 分组
/*! ---------------------- Tool       ---------------------- !*/

/*! ---------------------- Controller ---------------------- !*/
#import "SwpNavigationController.h"            // 导航控制器
#import "SwpFormworkTest1ViewController.h"     // 测试 控制器 1
#import "SwpFormworkTest2ViewController.h"     // 测试 控制器 2
#import "SwpFormworkTest3ViewController.h"     // 测试 控制器 3
#import "SwpFormworkTest4ViewController.h"     // 测试 控制器 4
/*! ---------------------- Controller ---------------------- !*/


static NSString * const tabBarImageStateNormal   = @"no";
static NSString * const tabBarImageStateSelected = @"sel";


@interface SwpTabBarController ()

/*! ---------------------- Data Property  ---------------------- !*/
/*! 存放 所有 控制器 名称 !*/
@property (nonatomic, copy) NSArray *controllerNames;
/*! 存放 所有 控制器      !*/
@property (nonatomic, copy) NSArray *controllers;
/*! 存放 控制title名称    !*/
@property (nonatomic, copy) NSArray *tabBarItemNames;
/*! 存放 控制image图片    !*/
@property (nonatomic, copy) NSArray *tabBarItemImages;
/*! ---------------------- Data Property  ---------------------- !*/
@property (nonatomic, copy, setter = swpTabBarDidSelectItemAtIndex:) void(^swpTabBarDidSelectItemAtIndex)(NSInteger itemAtIndex);

@end

@implementation SwpTabBarController

#pragma mark - Lifecycle Methods

/*!
 *  @author swp_song
 *
 *  @brief  shareInstance   ( 快速 初始化 用户数据模型 单利方法 )
 *
 *  @return SwpTabBarController
 */
+ (instancetype)shareInstance {
    static SwpTabBarController *swpTabBarController = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        swpTabBarController = [[self alloc] init];
    });
    return swpTabBarController;
}

/*!
 *  @author swp_song
 *
 *  @brief  视图载入完成 调用
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViewControllers];
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

#pragma mark - Setup ViewControllers Methods
/*!
 *  @author swp_song
 *
 *  @brief  setupViewControllers ( 设置tabBar控制器 )
 */
-(void)setupViewControllers {
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self setViewControllers:self.controllers];
    [self customizeTabBarForController:self];
}

/*!
 *  @author swp_song
 *
 *  @brief  packNavigationControllers ( 包装导航控制器 )
 *
 *  @param  controllerNames
 *
 *  @return NSArray
 */
- (NSArray *)packNavigationControllers:(NSArray *)controllerNames {
    
    NSMutableArray *array = [NSMutableArray array];
    //遍历
    [controllerNames enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SwpBaseViewController   *swpBaseViewController   = [[[NSClassFromString(obj) class] alloc] init];
        SwpNavigationController *swpNavigationController = [[SwpNavigationController alloc] initWithRootViewController:swpBaseViewController];
        [array addObject:swpNavigationController];
    }];
    
    return [NSArray arrayWithArray:array];
}


#pragma mark - Customize TabBar For Controller  Methods
/*!
 *  @author swp_song
 *
 *  @brief  customizeTabBarForController ( 设置 RDVTabBar )
 *
 *  @param  tabBarController
 */
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    

    //设置tab透明背景
    tabBarController.tabBar.translucent                    = YES;
    tabBarController.tabBar.backgroundView.backgroundColor = [UIColor swpColorFromHEX:0xf1f1f1];
    tabBarController.tabBar.delegate                       = self;
    // Setting RDVTabBarItem    遍历items
    [tabBarController.tabBar.items enumerateObjectsUsingBlock:^(RDVTabBarItem * _Nonnull item, NSUInteger index, BOOL * _Nonnull stop) {
        // 设置 预约 样式
        [self settingTabBarItem:item tabBarTitle:self.tabBarItemNames[index] tabBarImageName:self.tabBarItemImages[index] itemIndex:index settingOrderBlock:^(RDVTabBarItem *item, NSInteger itemIndex) {
        }];
        
    }];
    tabBarController.selectedIndex = 0;
}

/*!
 *  @author swp_song
 *
 *  @brief  settingTabBarItem ( 设置 RDVTabBarItem )
 *
 *  @param  item
 *
 *  @param  title
 *
 *  @param  imageName
 *
 *  @param  itemIndex
 *
 *  @param  block
 */
- (void)settingTabBarItem:(RDVTabBarItem *)item tabBarTitle:(NSString *)title tabBarImageName:(NSString *)imageName itemIndex:(NSInteger)itemIndex settingOrderBlock:(void(^)(RDVTabBarItem *item, NSInteger itemIndex))block {
    
    [item setBackgroundSelectedImage:nil withUnselectedImage:nil];
    // 设置 title
    item.title                      = title;
    // 设置item距离图片距离
    item.titlePositionAdjustment    = UIOffsetMake(0, 3);
    // 未选中
    item.unselectedTitleAttributes  = [self settingTabBarTitleAttributes:10 titleColor:[UIColor swpColorFromHEX:0x747474]];
    // 选中
    item.selectedTitleAttributes    = [self settingTabBarTitleAttributes:10 titleColor:[UIColor swpColorFromHEX:0xff6501]];
    
    // 设置 图片
    UIImage *selectedimage          = [self settingTabBarImage:imageName imageStatus:tabBarImageStateSelected];
    //tabBarImageStateNormal
    UIImage *unselectedimage        = [self settingTabBarImage:imageName imageStatus:tabBarImageStateNormal];
    [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
    block(item, itemIndex);
}


/*!
 *  @author swp_song
 *
 *  @brief  settingTabBarImage ( 设置 tabBar 图片 )
 *
 *  @param  imageName
 *
 *  @param  imageStatus
 *
 *  @return UIImage
 */
- (UIImage *) settingTabBarImage:(NSString *)imageName imageStatus:(NSString *)imageStatus {
    return [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@", imageName, imageStatus]];
}

/*!
 *  @author swp_song
 *
 *  @brief  settingTabBarTitleAttributes ( 设置 tabBar 文字样式 )
 *
 *  @param  titleFontSize
 *
 *  @param  titleColor
 *
 *  @return NSDictionary
 */
- (NSDictionary *) settingTabBarTitleAttributes:(CGFloat)titleFontSize titleColor:(UIColor *)titleColor {
    return @{NSFontAttributeName:[UIFont systemFontOfSize:titleFontSize], NSForegroundColorAttributeName:titleColor};;
}


#pragma mark - RDVTabBarDelegate Methods
/*!
 *  @author swp_song
 *
 *  @brief  RDVTabBarController Deleage  ( 选中了某个控制器调用) )
 *
 *  @param  tabBar
 *
 *  @param  index
 */
- (void)tabBar:(RDVTabBar *)tabBar didSelectItemAtIndex:(NSInteger)index {
    [super tabBar:tabBar didSelectItemAtIndex:index];
    if (self.swpTabBarDidSelectItemAtIndex) self.swpTabBarDidSelectItemAtIndex(index);
}

/*!
 *  @author swp_song
 *
 *  @brief  RDVTabBarController Delegate ( 点击是否做出反应, 选中当前控制器 设置 tabbar 点击两下不回退 )
 *
 *  @param  tabBarController
 *
 *  @param  viewController
 *
 *  @return BOOL
 */
- (BOOL)tabBarController:(RDVTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController*)viewController;
        // 这里是关键，只在栈中存大于一个 ViewController 并且是当前选中的，就不做反应
        if (navigationController.viewControllers.count > 1 && tabBarController.selectedViewController == viewController) {
            return NO;
        }
    }
    return YES;
}


#pragma mark - Public Tools

/*!
 *  @author swp_song
 *
 *  @brief  swpTabBarDidSelectItemAtIndex:   ( 点击 TabBar 回到 )
 *
 *  @param  swpTabBarDidSelectItemAtIndex
 */
- (void)swpTabBarDidSelectItemAtIndex:(void (^)(NSInteger itemAtIndex))swpTabBarDidSelectItemAtIndex {
    _swpTabBarDidSelectItemAtIndex = swpTabBarDidSelectItemAtIndex;
}

#pragma mark - Init Data Methods
- (NSArray *)controllerNames {
    
    if (!_controllerNames) {
        
        _controllerNames = [NSArray array];
        _controllerNames = @[
                             NSStringFromClass([SwpFormworkTest1ViewController class]),
                             NSStringFromClass([SwpFormworkTest2ViewController class]),
                             NSStringFromClass([SwpFormworkTest3ViewController class]),
                             NSStringFromClass([SwpFormworkTest4ViewController class]),
                             ];
    }
    return _controllerNames;
}

- (NSArray *)controllers {
    
    if (!_controllers) {
        _controllers = [NSArray array];
        _controllers = [self packNavigationControllers:self.controllerNames];
    }
    return _controllers;
}

- (NSArray *)tabBarItemNames {
    
    if (!_tabBarItemNames) {
        
        _tabBarItemNames = [NSArray copy];
        _tabBarItemNames = @[@"SwpTest1", @"SwpTest2", @"SwpTest3", @"SwpTest4"];
    }
    return _tabBarItemNames;
}

- (NSArray *)tabBarItemImages {
    
    if (!_tabBarItemImages) {
        
        _tabBarItemImages = [NSArray copy];
        _tabBarItemImages = @[@"home", @"shop", @"order", @"mine",];
    }
    return _tabBarItemImages;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
