//
//  DepartmentInfo.m
//  SwpFormwork
//
//  Created by mac on 16/9/27.
//  Copyright © 2016年 swp_song. All rights reserved.
//

#import "DepartmentInfo.h"

@implementation DepartmentInfo
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"number":@"NO",
             };
}
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{
             @"appPeopleDatas" : @"PeopleInfo"
             };
}
@end
