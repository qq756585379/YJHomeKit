//
//  BaseViewController.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/4.
//

#import "YJViewController.h"
#import "YJColor.h"
#import "UIImage+tool.h"

@interface YJViewController ()
@property (nonatomic, strong) NSMutableDictionary *updateModelWhenViewLoadedBlocks;
@property (nonatomic, strong) NSMutableDictionary *updateModelWhenViewLoadedOnceBlocks;
@property (nonatomic, strong) NSMutableDictionary *updateViewWhenViewdidAppearBlocks;
@property (nonatomic, strong) NSMutableDictionary *updateViewWhenViewdidAppearOnceBlocks;
@property (nonatomic, getter=isViewAppeared) BOOL viewAppeared;
@end

@implementation YJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.updateModelWhenViewLoadedBlocks = @{}.mutableCopy;
    self.updateModelWhenViewLoadedOnceBlocks = @{}.mutableCopy;
    self.updateViewWhenViewdidAppearBlocks = @{}.mutableCopy;
    self.updateViewWhenViewdidAppearOnceBlocks = @{}.mutableCopy;
    
    self.canDragBack = YES;
    self.toolbarHidden = YES;
    self.tabBarHidden = YES;
    self.showGlobalMessageTip = YES;
    self.navigationBarTranslucent = NO;
    self.titleColor = [YJColor colorWithRGB:0x212121];
    
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setStatusBarStyle:self.statusBarStyle];
    self.tabBarController.tabBar.hidden = self.tabBarHidden;
    self.navigationController.toolbarHidden = self.toolbarHidden;
    self.navigationController.navigationBarHidden = self.navigationBarHidden;
    
    if (self.isNavigationBarTranslucent) {
        [self setNavigationBarTranslucent:YES];
    }else{
        [self setNavigationBarTranslucent:NO];
    }
    
    [self.updateModelWhenViewLoadedBlocks.copy enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        dispatch_block_t block = obj;
        !block ? : block();
    }];
    
    [self.updateModelWhenViewLoadedOnceBlocks.copy enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        dispatch_block_t block = obj;
        !block ? : block();
    }];
    
    [self.updateModelWhenViewLoadedOnceBlocks removeAllObjects];
    
    //    [self postNotification:IMI_GLOBAL_CAN_SHOW_MESSAGE withObject:@(self.showGlobalMessageTip)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.viewAppeared = YES;
    
    [self.updateViewWhenViewdidAppearBlocks.copy enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        dispatch_block_t block = obj;
        !block ? : block();
    }];
    
    [self.updateViewWhenViewdidAppearOnceBlocks.copy enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        dispatch_block_t block = obj;
        !block ? : block();
    }];
    
    [self.updateViewWhenViewdidAppearOnceBlocks removeAllObjects];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.viewAppeared = NO;
}

#pragma mark - title color
- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    NSDictionary *titleAttributes = @{NSForegroundColorAttributeName:titleColor, NSFontAttributeName:[UIFont systemFontOfSize:18.f weight:UIFontWeightHeavy]};
    self.navigationController.navigationBar.titleTextAttributes = titleAttributes;
}

#pragma mark - status bar
- (void)setStatusBarStyle:(YJSttusBarStyle)style{
    _statusBarStyle = style;
    [self setNeedsStatusBarAppearanceUpdate];
}

-(void)setStatusBarHidden:(BOOL)statusBarHidden{
    _statusBarHidden = statusBarHidden;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - Tabbar
- (void)setTabbarImage:(UIImage *)tabbarImage{
    _tabbarImage = tabbarImage;
    [self.tabBarController.tabBar setBackgroundImage:tabbarImage];
}

- (void)setTabBarHidden:(BOOL)tabBarHidden{
    _tabBarHidden = tabBarHidden;
    if (self.isViewLoaded) {
        self.tabBarController.tabBar.hidden = tabBarHidden;
    }
}

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden{
    _navigationBarHidden = navigationBarHidden;
    if (self.isViewLoaded) {
        [self.navigationController setNavigationBarHidden:_navigationBarHidden];
    }
}

- (void)setToolbarHidden:(BOOL)toolbarHidden{
    _toolbarHidden = toolbarHidden;
    if (self.isViewLoaded) {
        [self.navigationController setToolbarHidden:_toolbarHidden];
    }
}

- (void)setNavigationBarTranslucent:(BOOL)navigationBarTranslucent
{
    _navigationBarTranslucent = navigationBarTranslucent;
    self.navigationController.navigationBar.translucent = navigationBarTranslucent;
    
    if (navigationBarTranslucent) {
//        self.titleColor = [UIColor whiteColor];
//        self.statusBarStyle = YJStatusBarStyleWhiteFont;
//        self.navigationBarImage = [UIImage imageWithColor:[UIColor clearColor]];
//        self.navigationBarShadowImage = [UIImage imageWithColor:[UIColor clearColor]];
    }
    
    
//    [self.navigationController.navigationBar setBackgroundImage:self.navigationBarImage forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:self.navigationBarShadowImage];
//
//    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName:self.titleColor,
//                                          NSFontAttributeName:[UIFont systemFontOfSize:18.f weight:UIFontWeightHeavy]};
//    self.navigationController.navigationBar.titleTextAttributes = self.titleTextAttributes ? self.titleTextAttributes : titleTextAttributes;
}

#pragma mark - for vc perfomace
- (void)updateModelWhenViewLoaded:(dispatch_block_t)aBlock{
    [self updateModelWhenViewLoaded:aBlock andIdentifier:@"updateModelWhenViewLoaded"];
}

- (void)updateModelWhenViewLoadedOnce:(dispatch_block_t)aBlock{
    [self updateModelWhenViewLoadedOnce:aBlock andIdentifier:@"updateModelWhenViewLoadedOnce"];
}

-(void)updateViewWhenViewdidAppear:(dispatch_block_t)aBlock{
    [self updateViewWhenViewdidAppear:aBlock andIdentifier:@"updateViewWhenViewdidAppear"];
}

-(void)updateViewWhenViewdidAppearOnce:(dispatch_block_t)aBlock{
    [self updateViewWhenViewdidAppearOnce:aBlock andIdentifier:@"updateViewWhenViewdidAppearOnce"];
}

//当vc的view加载完成之后，将要显示的时候，调用传入的block刷新数据
- (void)updateModelWhenViewLoaded:(dispatch_block_t)aBlock andIdentifier:(NSString *)identifier{
    self.updateModelWhenViewLoadedBlocks[identifier] = aBlock;
    if (self.isViewLoaded && aBlock) {
        aBlock();
    }
}

//当vc的view加载完成之后，将要显示的时候，调用传入的block刷新数据，只调用一次
- (void)updateModelWhenViewLoadedOnce:(dispatch_block_t)aBlock andIdentifier:(NSString *)identifier{
    self.updateModelWhenViewLoadedOnceBlocks[identifier] = aBlock;
    if (self.isViewLoaded && aBlock) {
        aBlock();
        self.updateModelWhenViewLoadedOnceBlocks[identifier] = nil;
    }
}

//当vc完全呈现之后调用传入的block
- (void)updateViewWhenViewdidAppear:(dispatch_block_t)aBlock andIdentifier:(NSString *)identifier{
    self.updateViewWhenViewdidAppearBlocks[identifier] = aBlock;
    if (self.isViewAppeared && aBlock) {
        aBlock();
    }
}

//当vc完全呈现之后调用传入的block，只调用一次
- (void)updateViewWhenViewdidAppearOnce:(dispatch_block_t)aBlock andIdentifier:(NSString *)identifier{
    self.updateViewWhenViewdidAppearOnceBlocks[identifier] = aBlock;
    if (self.isViewAppeared && aBlock) {
        aBlock();
        self.updateViewWhenViewdidAppearOnceBlocks[identifier] = nil;
    }
}

-(void)cancelFirstResponse
{
    [self.view endEditing:YES];
    [self resignFirstResponder];
    [self.view resignFirstResponder];
}

#pragma mark - Orientations
- (BOOL)shouldAutorotate
{
    return NO;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle == YJStatusBarStyleBlackFont ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return self.isStatusBarHidden;
}

@end
