//
//  YJMacro.h
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/27.
//


/**快速创建弱指针*/
#define WEAK_SELF    __weak         typeof(self) weakSelf = self;
#define STRONG_SELF  __strong       typeof(weakSelf) self = weakSelf;

//----------------------ABOUT SCREEN & SIZE 屏幕&尺寸 ----------------------------
#define SCREEN_WIDTH                  	([[UIScreen mainScreen] bounds].size.width) //屏幕宽度
#define SCREEN_HEIGHT                 	([[UIScreen mainScreen] bounds].size.height) //屏幕高度

#define IS_IPHONE_5 					(SCREEN_HEIGHT == 568)
#define IS_IPHONE_6 					(SCREEN_HEIGHT == 667)
#define IS_IPHONE_6P 					(SCREEN_HEIGHT == 763)
#define IS_IPHONE_X                 	((SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f) ? YES : NO)

//判断设备
#define IS_IPAD_DEVICE         			(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE_DEVICE       			(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define TAB_BAR_HEIGHT                 	(IS_IPHONE_X ? 83 : 49)
// 状态栏高度
#define STATUS_BAR_HEIGHT               (IS_IPHONE_X ? 44.f:20.f)
// 导航栏高度
#define NAV_BAR_HEIGHT            		(IS_IPHONE_X ? 88.f:64.f)
#define SAFE_AREA_BOTTOM				(IS_IPHONE_X ? 34 : 0)
#define SAFE_AREA_TOP					(IS_IPHONE_X ? 44 : 0)

//----------------------ABOUT COLOR 颜色相关 ----------------------------
#define RGBA(r,g,b,a)     [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b)        RGBA(r,g,b,1.0f)
#define HEXCOLOR(hex) 	  [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#define APP_DELEGATE 	((AppDelegate *)[UIApplication sharedApplication].delegate)

#define KEY_WINDOW  	[UIApplication sharedApplication].keyWindow

/** 获取当前语言 */
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/** 获取系统版本 */
#define iOS_VERSION 			([[[UIDevice currentDevice] systemVersion] floatValue])
#define CurrentSystemVersion 	([[UIDevice currentDevice] systemVersion])

/** print 打印rect,size,point */
#ifdef DEBUG
#define kLogPoint(point)    NSLog(@"%s = { x:%.4f, y:%.4f }", #point, point.x, point.y)
#define kLogSize(size)      NSLog(@"%s = { w:%.4f, h:%.4f }", #size, size.width, size.height)
#define kLogRect(rect)      NSLog(@"%s = { x:%.4f, y:%.4f, w:%.4f, h:%.4f }", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#endif

//打印
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif


typedef void(^YJCompletionBlock)(id aResponseObject, NSError *anError);





