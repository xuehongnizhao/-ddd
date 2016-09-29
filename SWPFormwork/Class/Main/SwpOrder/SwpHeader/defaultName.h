//
//  defaultName.h
//  WMYRiceNoodles
//
//  Created by mac on 13-12-19.
//  Copyright (c) 2013年 mac. All rights reserved.
//

/**
 * @file         defaultName.h
 * @brief        NSUserDefault的key集合
 *
 * @author       xiaocao
 * @version      0.1
 * @date         2012-12-19
 * @since        2012-12 ~
 */

#ifndef WMYRiceNoodles_defaultName_h
#define WMYRiceNoodles_defaultName_h


#define everLaunch  @"firstEnter"           /*!< 判断是否第一次进入应用: yes-不是第一次，no-是第一次 */
#define isLogin     @"islogined"              /*!< 判断用户登录状态: yes-已登录，no-未登录 */

#define peopleId        @"peopleId"           //唯一标识
#define myInfoDic       @"myInfo"               //个人信息
#define lastName        @"lastName"
#define sessionid       @"sessionid"
#define lastChangeData  @"lastChangeData"
#define allData         @"allData"
//上次登录的账号
#define BalanceWidth SCREEN_WIDTH/320.0
#define BalanceHeight SCREEN_HEIGHT/621.0

// 写入NSUserDefault中的数据
#define SetUserDefault(value, key) [[NSUserDefaults standardUserDefaults] setObject:value forKey:key]
// 获取NSUserDefault中的数据
#define GetUserDefault(key) [[NSUserDefaults standardUserDefaults] objectForKey:key]


#endif
