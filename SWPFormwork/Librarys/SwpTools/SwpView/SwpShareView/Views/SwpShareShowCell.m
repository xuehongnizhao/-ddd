//
//  SwpShareShowCell.m
//  swp_song
//
//  Created by songweiping on 16/3/28.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import "SwpShareShowCell.h"

/*! ---------------------- Model      ---------------------- !*/
#import "SwpShareModel.h"
/*! ---------------------- Model      ---------------------- !*/

@interface SwpShareShowCell ()

#pragma mark - UI   Propertys
/*! ---------------------- UI   Property  ---------------------- !*/
/*! 显示分享图片view       !*/
@property (nonatomic, weak) IBOutlet UIImageView *swpShareShowImageView;
/*! 显示分享图片titleView  !*/
@property (nonatomic, weak) IBOutlet UILabel     *swpShareShowTitleView;
/*! ---------------------- UI   Property  ---------------------- !*/

@end

@implementation SwpShareShowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

/*!
 *  @author swp_song
 *
 *  @brief  initWithFrame:  ( Override initWithFrame )
 *
 *  @param  frame
 *
 *  @return SwpShareShowCell
 */
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SwpShareShowCell class]) owner:nil options:nil].lastObject;
    }
    return self;
}

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShare ( Override Setter )
 *
 *  @param  swpShare
 */
- (void)setSwpShare:(SwpShareModel *)swpShare {
    _swpShare = swpShare;
    self.swpShareShowImageView.contentMode = UIViewContentModeCenter;
    [self settingData:_swpShare];
    
}

/*!
 *  @author swp_song
 *
 *  @brief  settingData ( 设置 数据 )
 *
 *  @param  swpShare
 */
- (void)settingData:(SwpShareModel *)swpShare {
    _swpShareShowImageView.image = [UIImage imageNamed:swpShare.swpShareImage];
    _swpShareShowTitleView.text  = swpShare.swpShareTitle;
}


@end
