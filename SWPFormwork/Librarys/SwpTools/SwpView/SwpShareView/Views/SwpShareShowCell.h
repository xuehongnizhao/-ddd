//
//  SwpShareShowCell.h
//  swp_song
//
//  Created by songweiping on 16/3/28.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SwpShareModel;

NS_ASSUME_NONNULL_BEGIN

@interface SwpShareShowCell : UICollectionViewCell

/*! 分享 数据模型 !*/
@property (nonatomic, strong) SwpShareModel *swpShare;

/*!
 *  @author swp_song
 *
 *  @brief  setSwpShare ( Override Setter )
 *
 *  @param  swpShare
 */
- (void)setSwpShare:(SwpShareModel *)swpShare;

@end

NS_ASSUME_NONNULL_END
