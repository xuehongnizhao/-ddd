# SwpTools


#####尝试静态库打 封装一些 常用的工具方法 
---

#####导入：
```ruby
手动导入：

SwpTools 文件夹 导入 项目 中

// 获取 手机IP
#import "SwpGetIp"				

// 常用 工具类
#import "SwpTools"	
			
// 消除Block 循环引用
#import "SwpWeakifyHeader"	

// 新增打印宏
#import "SwpLog.h"

// 新增 坐标 高德 百度 坐标 互转
#import "SwpCoordinateTransform.h"

```
---

```ruby

CocoaPods 导入:

pod search SwpTools

pod 'SwpTools'

// 获取 手机IP
#import <SwpTools/SwpGetIp.h>		     

// 常用 工具类
#import <SwpTools/SwpTools.h>		     

//消除Block 循环引用
#import <SwpTools/SwpWeakifyHeader.h>

// 新增打印宏头文件
#import <SwpTools/SwpLog.h>

// 新增 坐标 高德 百度 坐标 互转
#import <SwpTools/SwpCoordinateTransform.h>


```

