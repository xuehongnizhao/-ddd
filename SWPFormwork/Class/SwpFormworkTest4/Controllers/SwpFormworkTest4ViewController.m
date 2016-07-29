//
//  SwpFormworkTest4ViewController.m
//  SwpFormwork
//
//  Created by swp_song on 16/5/16.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "SwpFormworkTest4ViewController.h"

/*! ---------------------- Tool       ---------------------- !*/
/*! ---------------------- Tool       ---------------------- !*/

/*! ---------------------- Controller ---------------------- !*/
/*! ---------------------- Controller ---------------------- !*/

/*! ---------------------- View       ---------------------- !*/
/*! ---------------------- View       ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/
/*! ---------------------- Model      ---------------------- !*/


@interface SwpFormworkTest4ViewController ()

#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/

/*! ---------------------- UI   Property  ---------------------- !*/

#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/

/*! ---------------------- Data Property  ---------------------- !*/

@end

@implementation SwpFormworkTest4ViewController

#pragma mark - Lifecycle Methods
/*!
 *  @author swp_song
 *
 *  @brief  viewDidLoad ( 视图载入完成 调用 )
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    
    [self setData];
}

/*!
 *  @author swp_song
 *
 *  @brief  viewWillAppear: ( 将要加载出视图 调用 )
 *
 *  @param  animated
 */
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

/*!
 *  @author swp_song
 *
 *  @brief  viewDidAppear:  ( 视图 显示 窗口时 调用 )
 *
 *  @param  animated
 */
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

/*!
 *  @author swp_song
 *
 *  @brief viewWillDisappear:   ( 视图  即将消失、被覆盖或是隐藏时调用 )
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
 *  @brief  viewDidDisappear:   ( 视图已经消失、被覆盖或是隐藏时调用 )
 *
 *  @param  animated
 */
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

/*!
 *  @author swp_song
 *
 *  @brief  didReceiveMemoryWarning ( 内存不足时 调用 )
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*!
 *  @author swp_song
 *
 *  @brief  dealloc ( 当前 控制器 被销毁时 调用 )
 */
- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - SetData Data Method
/*!
 *  @author swp_song
 *
 *  @brief  setData （ 设置 初始化 数据 ）
 */
- (void)setData {
    
}

#pragma mark - Setting UI Methods
/*!
 *  @author swp_song
 *
 *  @brief  设置 UI 控件
 */
- (void)setUI {
    
    [self setNavigationBar];
    [self setUpUI];
    [self setUIAutoLayout];
}


/*!
 *  @author swp_song
 *
 *  @brief  setNavigationBar    ( 设置导航栏 )
 */
- (void)setNavigationBar {
    [self setNavigationBarTitle:@"SwpTest4" textColor:nil titleFontSize:nil];
}

/*!
 *  @author swp_song
 *
 *  @brief  setupUI ( 添加控件 | 设置控件自动布局 )
 */
- (void)setUpUI {
    
}

/*!
 *  @author swp_song
 *
 *  @brief  setUIAutoLayout (设置控件的自动布局)
 */
- (void)setUIAutoLayout {
    
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
