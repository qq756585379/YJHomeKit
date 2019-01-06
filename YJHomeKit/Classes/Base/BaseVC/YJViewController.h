//
//  BaseViewController.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/4.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YJSttusBarStyle) {
    YJStatusBarStyleBlackFont,
    YJStatusBarStyleWhiteFont
};

@interface YJViewController : UIViewController

/**
 *  是否能右滑返回
 */
@property (nonatomic) BOOL canDragBack;
/**
 *  是否显示tabbar
 */
@property (nonatomic, getter=isTabBarHidden) BOOL tabBarHidden;
/**
 *  是否显示导航栏的toolbar
 */
@property (nonatomic, getter=isToolbarHidden) BOOL toolbarHidden;
/**
 *  是否显示电池状态栏
 */
@property (nonatomic, getter=isStatusBarHidden) BOOL statusBarHidden;
/**
 *  是否显示Navigation bar
 */
@property (nonatomic, getter=isNavigationBarHidden) BOOL navigationBarHidden;
/**
 *  Navigation bar 是否透明
 */
@property (nonatomic, getter=isNavigationBarTranslucent) BOOL navigationBarTranslucent;
/**
 *  导航栏背景图
 */
@property (nonatomic, copy) UIImage *navigationBarImage;

@property (nonatomic, copy) UIImage *navigationBarShadowImage;
/**
 *  底部tabbar背景图
 */
@property (nonatomic, copy) UIImage *tabbarImage;
/**
 *  状态栏样式
 */
@property (nonatomic) YJSttusBarStyle statusBarStyle;
/**
 *  title颜色
 */
@property (nonatomic, copy) UIColor *titleColor;
/**
 *  富文本title，如果设置了则title，titlecolor失效
 */
@property (nonatomic,copy) NSDictionary *titleTextAttributes;
/**
 *  显示全局消息提醒
 */
@property (nonatomic, assign) BOOL showGlobalMessageTip;

//当vc的view加载完成之后，将要显示的时候，调用传入的block刷新数据
- (void)updateModelWhenViewLoaded:(dispatch_block_t)aBlock;
- (void)updateModelWhenViewLoaded:(dispatch_block_t)aBlock andIdentifier:(NSString *)identifier;
//当vc的view加载完成之后，将要显示的时候，调用传入的block刷新数据，只调用一次
- (void)updateModelWhenViewLoadedOnce:(dispatch_block_t)aBlock;
- (void)updateModelWhenViewLoadedOnce:(dispatch_block_t)aBlock andIdentifier:(NSString *)identifier;
//当vc完全呈现之后调用传入的block
- (void)updateViewWhenViewdidAppear:(dispatch_block_t)aBlock;
- (void)updateViewWhenViewdidAppear:(dispatch_block_t)aBlock andIdentifier:(NSString *)identifier;
//当vc完全呈现之后调用传入的block，只调用一次
- (void)updateViewWhenViewdidAppearOnce:(dispatch_block_t)aBlock;
- (void)updateViewWhenViewdidAppearOnce:(dispatch_block_t)aBlock andIdentifier:(NSString *)identifier;
- (void)cancelFirstResponse;

@end
