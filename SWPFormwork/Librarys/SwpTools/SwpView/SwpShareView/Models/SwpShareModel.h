//
//  SwpShareModel.h
//  swp_song
//
//  Created by songweiping on 16/3/28.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
@interface SwpShareModel : NSObject

/*! 分享 文字 !*/
@property (nonatomic, copy) NSString *swpShareTitle;
/*! 分享 图片 !*/
@property (nonatomic, copy) NSString *swpShareImage;

/*!
 *  @author swp_song
 *
 *  @brief  swpShareWithSwpShareTitle:swpShareImage:    ( 快速初始化一个 SwpShareModel )
 *
 *  @param  swpShareTitle
 *
 *  @param  swpShareImage
 *
 *  @return SwpShareModel
 */
+ (instancetype)swpShareWithSwpShareTitle:(NSString *)swpShareTitle swpShareImage:(NSString *)swpShareImage;

/*!
 *  @author swp_song
 *
 *  @brief  swpShareWithWithSwpShareTitleArray:swpShareImageArray   ( 快速初始化一组 SwpShareModel )
 *
 *  @param  swpShareTitleArray
 *
 *  @param  swpShareImageArray
 *
 *  @return NSArray<SwpShareModel *>
 */
+ (NSArray<SwpShareModel *> *)swpShareWithWithSwpShareTitleArray:(NSArray *)swpShareTitleArray swpShareImageArray:(NSArray *)swpShareImageArray;

@end
NS_ASSUME_NONNULL_END
