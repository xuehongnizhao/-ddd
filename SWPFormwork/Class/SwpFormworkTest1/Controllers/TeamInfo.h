//
//  TeamInfo.h
//  SwpFormwork
//
//  Created by mac on 16/9/27.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeamInfo : NSObject
@property (strong, nonatomic) NSString      *number;
@property (strong, nonatomic) NSString      *abbreviation;
@property (strong, nonatomic) NSMutableArray       *appGroupDataList;
@property (strong, nonatomic) NSString      *teamId;
@property (strong, nonatomic) NSString      *teamLcon;
@property (strong, nonatomic) NSString      *teamName;
@end
