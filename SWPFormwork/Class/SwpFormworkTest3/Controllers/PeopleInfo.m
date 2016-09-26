//
//  PeopleInfo.m
//  SwpFormwork
//
//  Created by mac on 16/9/26.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "PeopleInfo.h"

@implementation PeopleInfo
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"number":@"NO",
             @"id":@"selfID"
             };
}
@end
