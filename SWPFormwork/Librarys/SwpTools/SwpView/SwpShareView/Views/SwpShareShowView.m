//
//  SwpShareShowView.m
//  swp_song
//
//  Created by songweiping on 16/3/9.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import "SwpShareShowView.h"

/*! ---------------------- Tool       ---------------------- !*/
#import "SwpShareTools.h"               // 工具
/*! ---------------------- Tool       ---------------------- !*/

/*! ---------------------- View       ---------------------- !*/
#import "SwpShareShowCell.h"            // 显示分享cell
/*! ---------------------- View       ---------------------- !*/

/*! ---------------------- Model      ---------------------- !*/
#import "SwpShareModel.h"               // 分享 数据模型
/*! ---------------------- Model      ---------------------- !*/


static NSString * const kSwpShareShowViewCellID = @"kSwpShareShowViewCellID";
static CGFloat    const  swpShareTitleViewWidth = 35;

@interface SwpShareShowView ()<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
/*! 显示分享标题view      !*/
@property (nonatomic, strong) UILabel                    *swpShareTitleView;
/*! 显示分享view          !*/
@property (nonatomic, strong) UICollectionView           *swpShareCollectionView;
/*! 显示分享view布局      !*/
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
/*! 显示分取消分享按钮    !*/
@property (nonatomic, strong) UIButton                   *swpShareDismissButton;
/*! ---------------------- UI   Property  ---------------------- !*/

#pragma mark - Data Propertys
/*! ---------------------- Data Property  ---------------------- !*/
/*! 分享数据源 !*/
@property (nonatomic, copy) NSArray *dataSource;
/*! Delegate   !*/
@property (nonatomic, weak) id<SwpShareShowViewDelegate> delegate;
/*! ---------------------- Data Property  ---------------------- !*/
@end

@implementation SwpShareShowView



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
+ (instancetype)swpShareShowViewWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource delegate:(id<SwpShareShowViewDelegate>)delegate {
    return [[self alloc] initSwpShareShowViewWithFrame:frame dataSource:dataSource delegate:delegate];
}


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
- (instancetype)initSwpShareShowViewWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource delegate:(id<SwpShareShowViewDelegate>)delegate {
    
    if (self = [super initWithFrame:frame]) {
        self.dataSource = dataSource;
        self.delegate   = delegate;
        [self setUpUI];
        [self settingUIFrame:frame];
        self.backgroundColor = [SwpShareTools swpColorFromHEX:0xf3f3f3];
    }
    
    return self;
}

/*!
 *  @author swp_song
 *
 *  @brief  setupUI ( 添加控件 | 设置控件自动布局 )
 */
- (void) setUpUI {
    
    [self addSubview:self.swpShareTitleView];
    [self addSubview:self.swpShareDismissButton];
    [self addSubview:self.swpShareCollectionView];
    
}

/*!
 *  @author swp_song
 *
 *  @brief  settingUIFrame: ( 设置 控件的 frame )
 *
 *  @param  frame
 */
- (void)settingUIFrame:(CGRect)frame {
    
    NSLog(@"%f", frame.size.height * 0.24);
    self.frame = frame;
    
    self.swpShareTitleView.frame         = CGRectMake(0, 0, frame.size.width, swpShareTitleViewWidth);

    self.swpShareDismissButton.frame     = CGRectMake(0, frame.size.height - swpShareTitleViewWidth, frame.size.width, self.swpShareTitleView.frame.size.height);

    CGFloat swpShareCollectionViewHeight = frame.size.height - (self.swpShareTitleView.frame.size.height + self.swpShareTitleView.frame.size.height) - 20;
    
    self.swpShareCollectionView.frame    = CGRectMake(0, CGRectGetMaxY(self.swpShareTitleView.frame) + 10, frame.size.width, swpShareCollectionViewHeight);
    NSLog(@"%@", NSStringFromCGRect(self.swpShareCollectionView.frame));
}

#pragma mark - UICollectionView DataSoure Methods
/*!
 *  @author swp_song
 *
 *  @brief  collectionView DataSource ( collectionView 数据源方法 设置 collectionView 分组个数 )
 *
 *  @param  collectionView
 *
 *  @return NSInteger
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

/*!
 *  @author swp_song
 *
 *  @brief  collectionView DataSource ( collectionView 数据源方法 设置 collectionView 分组中 cell显示的个数 )
 *
 *  @param  collectionView
 *
 *  @param  section
 *
 *  @return NSInteger
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}


/*!
 *  @author swp_song
 *
 *  @brief  collectionView DataSource ( collectionView 数据源方法 设置 collectionView 分组中cell显示的数据 | 样式 )
 *
 *  @param  collectionView
 *
 *  @param  indexPath
 *
 *  @return UICollectionViewCell
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    SwpShareShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSwpShareShowViewCellID forIndexPath:indexPath];
    cell.swpShare          = self.dataSource[indexPath.item];
    return cell;
}

#pragma mark - UICollectionView Delegate Methods
/*!
 *  @author swp_song
 *
 *  @brief  collectionView Delegate ( collectionView 代理方法 设置 collectionView  每个cell的宽高 )
 *
 *  @param  collectionView
 *
 *  @param  collectionViewLayout
 *
 *  @param  indexPath
 *
 *  @return CGSize
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(50, 50);
}

/*!
 *  @author swp_song, 16-03-30 16:03:57
 *
 *  @brief  collectionView Delegate ( collectionView 代理方法 设置 collectionView  cell 边距的偏移量 )
 *
 *  @param  collectionView
 *
 *  @param  collectionViewLayout
 *
 *  @param  section
 *
 *  @return UIEdgeInsetsMake
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 10, 0, 10);
}

/*!
 *  @author swp_song
 *
 *  @brief  collectionView Delegate ( collectionView 代理方法 点击每个cell调用 )
 *
 *  @param  collectionView
 *
 *  @param  indexPath
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
 
    if ([self.delegate respondsToSelector:@selector(swpShareShowView:didSelectItemAtIndex:)]) {
        [self.delegate swpShareShowView:self didSelectItemAtIndex:indexPath.item];
    }
}


/*!
 *  @author swp_song
 *
 *  @brief  didButton:  ( 按钮 绑定方法 )
 *
 *  @param  button
 */
- (void)didButton:(UIButton *)button {
 
    if ([self.delegate respondsToSelector:@selector(swpShareShowViewDidSwpShareDismissButton:)]) {
        [self.delegate swpShareShowViewDidSwpShareDismissButton:self];
    }
}


#pragma mark - Public Methods

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareTitleText:   ( 设置 分享 title 文字 )
 *
 *  @param  swpShareTitleText
 */
- (void)setSwpShareTitleText:(NSString *)swpShareTitleText {
    _swpShareTitleText          = swpShareTitleText;
    self.swpShareTitleView.text = _swpShareTitleText;
}

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareTitleTextColor:  ( 设置 分享 title 文字颜色 )
 *
 *  @param  swpShareTitleTextColor
 */
- (void)setSwpShareTitleTextColor:(UIColor *)swpShareTitleTextColor {
    _swpShareTitleTextColor          = swpShareTitleTextColor;
    self.swpShareTitleView.textColor = _swpShareTitleTextColor;
}

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareDismissButtonTitleText:  ( 设置取消按钮文字 )
 *
 *  @param  swpShareDismissButtonTitleText
 */
- (void)setSwpShareDismissButtonTitleText:(NSString *)swpShareDismissButtonTitleText {
    _swpShareDismissButtonTitleText = swpShareDismissButtonTitleText;
    [self.swpShareDismissButton setTitle:_swpShareDismissButtonTitleText forState:UIControlStateNormal];
    [self.swpShareDismissButton setTitle:_swpShareDismissButtonTitleText forState:UIControlStateHighlighted];
}

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShareDismissButtonTitleTextColor: ( 设置取消按钮文字颜色 )
 *
 *  @param  swpShareDismissButtonTitleTextColor
 */
- (void)setSwpShareDismissButtonTitleTextColor:(UIColor *)swpShareDismissButtonTitleTextColor {
    _swpShareDismissButtonTitleTextColor = swpShareDismissButtonTitleTextColor;
    [self.swpShareDismissButton setTitleColor:_swpShareDismissButtonTitleTextColor forState:UIControlStateNormal];
    [self.swpShareDismissButton setTitleColor:_swpShareDismissButtonTitleTextColor forState:UIControlStateHighlighted];
}


#pragma mark - Init UI Methods
- (UILabel *)swpShareTitleView {

    return !_swpShareTitleView ? _swpShareTitleView = ({
        UILabel *label        = [UILabel new];
        label.backgroundColor = [UIColor whiteColor];
        label.text            = @"分享到";
        label.textAlignment   = NSTextAlignmentCenter;
        label.font            = [UIFont systemFontOfSize:12];
        label;
    }) : _swpShareTitleView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    
    return !_flowLayout ? _flowLayout = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection             = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 10;
        
        flowLayout;
    }) : _flowLayout;
}

- (UICollectionView *)swpShareCollectionView {
    return !_swpShareCollectionView ? _swpShareCollectionView = ({
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        collectionView.backgroundColor   = [UIColor whiteColor];
        collectionView.dataSource        = self;
        collectionView.delegate          = self;
        [collectionView registerClass:[SwpShareShowCell class] forCellWithReuseIdentifier:kSwpShareShowViewCellID];
        collectionView;
    }) : _swpShareCollectionView;
}

- (UIButton *)swpShareDismissButton {
    return !_swpShareDismissButton ? _swpShareDismissButton = ({
        UIButton *button       = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didButton:) forControlEvents:UIControlEventTouchUpInside];
        button;
    }) : _swpShareDismissButton;
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
