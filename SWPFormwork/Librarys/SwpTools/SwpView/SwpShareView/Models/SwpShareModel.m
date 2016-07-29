//
//  SwpShareModel.m
//  swp_song
//
//  Created by songweiping on 16/3/28.
//  Copyright © 2016年 songweiping. All rights reserved.
//

#import "SwpShareModel.h"

@implementation SwpShareModel

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
+ (instancetype)swpShareWithSwpShareTitle:(NSString *)swpShareTitle swpShareImage:(NSString *)swpShareImage {

    SwpShareModel *swpShare = [[self alloc] init];
    swpShare.swpShareTitle  = swpShareTitle;
    swpShare.swpShareImage  = swpShareImage;
    return swpShare;
}

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
+ (NSArray<SwpShareModel *> *)swpShareWithWithSwpShareTitleArray:(NSArray *)swpShareTitleArray swpShareImageArray:(NSArray *)swpShareImageArray {

    NSMutableArray *modelArray = [NSMutableArray array];
    
    for (NSInteger i=0; i<swpShareImageArray.count; i++) {
        [modelArray addObject:[SwpShareModel swpShareWithSwpShareTitle:swpShareTitleArray[i] swpShareImage:swpShareImageArray[i]]];
    }
    
    return [NSArray arrayWithArray:modelArray];
}


@end
