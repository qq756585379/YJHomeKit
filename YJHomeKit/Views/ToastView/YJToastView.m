//
//  YJToastView.m
//  Pods
//
//  Created by 杨俊 on 2018/2/1.
//

#import "YJToastView.h"

//key for tips
#define KeyForTipsContextInfo                                       @"info"
#define KeyForTipsContextDuration                                   @"duration"
#define KeyForTipsContextModelFlag                                  @"isModel"

#define BoardViewSize   (160.f) //面板的宽度和高度，高度会变
#define BoardViewImageCapInset   (20.f) //面板背景图显示时的cap inset
#define TBGap (20.f)    //顶端和低端的间隙
#define LRGap   (10.f)  //左右间隙
#define ResultIconSize (70.f)   //成功或失败icon的尺寸
#define ResultIconTextVGap   (11.f) //成功或失败icon和其下面的文本的间隙
#define TextHeight   (50.f) //默认文本高度
#define TextFont    (14.f)  //文本字体大小

@implementation YJToastView

//static id _instance = nil;
//+ (instancetype)sharedInstance
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        _instance = [[self alloc] initWithFrame:<#(CGRect)#>];
//    });
//    return _instance;
//}
//
//-(instancetype)init{
//
//}

//- (MHTipsView*)initMHtips{
//    self = [super initWithFrame:[UIScreen mainScreen].bounds];
//    if (self)
//    {
//        [self setUserInteractionEnabled:NO];
//
//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        self.backgroundColor = [UIColor clearColor];
//        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
//        _backgroundView.backgroundColor = [UIColor clearColor];
//        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//        [self addSubview:_backgroundView];
//
//
//        UIViewAutoresizing viewAutoresizing = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
//        UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
//
//        _boardView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BoardViewSize, BoardViewSize)];
//        UIImage* bgImage = [UIImage imageNamed:@"info_bkg"];
//        bgImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(BoardViewImageCapInset, BoardViewImageCapInset, BoardViewImageCapInset, BoardViewImageCapInset)];
//        _boardView.image = bgImage;
//        _boardView.center = CGPointMake(self.bounds.size.width /2, self.bounds.size.height /2) ;
//        _boardView.autoresizingMask = viewAutoresizing;
//        [self addSubview:_boardView];
//
//        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//        _activityView.center = CGPointMake(BoardViewSize/2, TBGap+ResultIconSize/2.f);
//        _activityView.hidesWhenStopped = YES;
//
//        CGRect labelRect = CGRectMake(LRGap, TBGap+ResultIconSize+ResultIconTextVGap, BoardViewSize-LRGap*2, TextHeight);
//        _labelInfo = [[UILabel alloc] initWithFrame:labelRect];
//        _labelInfo.numberOfLines = 0;
//        _labelInfo.backgroundColor = [UIColor clearColor];
//        _labelInfo.textAlignment = NSTextAlignmentCenter;
//        _labelInfo.textColor = [UIColor whiteColor];
//        _labelInfo.font = [UIFont systemFontOfSize:TextFont];
//        _labelInfo.shadowColor = [UIColor blackColor];
//        _labelInfo.shadowOffset = CGSizeMake(0, 1.0);
//        [_boardView addSubview:_labelInfo];
//
//        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ResultIconSize, ResultIconSize)];
//        _imageView.contentMode = UIViewContentModeCenter;
//        _imageView.center = CGPointMake(BoardViewSize/2.f, TBGap+ResultIconSize/2.f) ;
//        [_boardView addSubview:_imageView];
//        _imageView.hidden = YES;
//
//        id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
//        UIWindow* window = [appDelegate window];
//        _window = [[UIWindow alloc] initWithFrame:window.frame];
//        _window.windowLevel = UIWindowLevelStatusBar;
//        _window.rootViewController = [[MHTipsViewController alloc] init];
//
//        switch ([[UIApplication sharedApplication] statusBarOrientation]) {
//            case UIInterfaceOrientationPortrait:
//                self.transform = CGAffineTransformMakeRotation(0);
//                break;
//
//            case UIInterfaceOrientationPortraitUpsideDown:
//                self.transform = CGAffineTransformMakeRotation(M_PI);
//                break;
//
//            case UIInterfaceOrientationLandscapeLeft:
//                self.transform = CGAffineTransformMakeRotation(-M_PI/2);
//                break;
//
//            case UIInterfaceOrientationLandscapeRight:
//                self.transform = CGAffineTransformMakeRotation(M_PI/2);
//                break;
//
//            default:
//                break;
//        }
//
//        _window.hidden = YES;
//    }
//    return self;
//}
//
//- (void)setModal:(BOOL)isModal
//{
//    if (isModal)
//    {
//        [self setUserInteractionEnabled:YES];
//        _backgroundView.backgroundColor = [UIColor blackColor];
//        _backgroundView.alpha = 0.1f;
//    }
//    else
//    {
//        [self setUserInteractionEnabled:NO];
//        _backgroundView.backgroundColor = [UIColor clearColor];
//    }
//}
//
//- (void)setStatusBarStyle:(UIStatusBarStyle)style
//{
//    [(MHTipsViewController *)_window.rootViewController setNeedStatusBarStyle:style];
//}
//
//- (void)setStatusBarHide:(BOOL)isHidden
//{
//    [(MHTipsViewController *)_window.rootViewController setIsStatusBarHidden:isHidden];
//}
//
//- (void)setTipsOrientation:(UIInterfaceOrientation)ori
//{
//    switch (ori) {
//        case UIInterfaceOrientationPortrait:
//            self.transform = CGAffineTransformIdentity;
//            break;
//
//        case UIInterfaceOrientationPortraitUpsideDown:
//            self.transform = CGAffineTransformMakeRotation(M_PI);
//            break;
//
//        case UIInterfaceOrientationLandscapeLeft:
//            self.transform = CGAffineTransformMakeRotation(-M_PI/2);
//            break;
//
//        case UIInterfaceOrientationLandscapeRight:
//            self.transform = CGAffineTransformMakeRotation(M_PI/2);
//            break;
//
//        default:
//            break;
//    }
//}
//
//- (void)updateUIWithInfo:(NSString*)info {
//    /*设置默认position*/
//    float infoTextY;
//    if (_imageView.hidden && ![_activityView superview]) {
//        infoTextY = TBGap;
//    } else {
//        infoTextY = TBGap+ResultIconSize+ResultIconTextVGap;
//    }
//
//    _boardView.center = CGPointMake(self.bounds.size.width /2, self.bounds.size.height /2) ;
//
//    CGRect labelRect = CGRectMake(LRGap, infoTextY, BoardViewSize-LRGap*2, TextHeight);
//    [_labelInfo setFrame:labelRect];
//
//    _imageView.center = CGPointMake(BoardViewSize/2.f, TBGap+ResultIconSize/2.f) ;
//
//    /*根据info调整position*/
//    _labelInfo.text = info;
//    CGFloat textHeight = [info boundingRectWithSize:CGSizeMake(_labelInfo.frame.size.width, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:TextFont]} context:nil].size.height;
//    [_labelInfo setFrame:CGRectMake(_labelInfo.frame.origin.x, _labelInfo.frame.origin.y, _labelInfo.frame.size.width, textHeight)];
//
//    [_boardView setFrame:CGRectMake(_boardView.frame.origin.x, _boardView.frame.origin.y, _boardView.frame.size.width, CGRectGetMaxY(_labelInfo.frame) + TBGap)];
//
//    //如果文字为空，菊花居中.
//    if ([info length] <= 0) {
//        _activityView.center = CGPointMake(CGRectGetWidth(_boardView.bounds) / 2, CGRectGetHeight(_boardView.bounds) / 2);
//    } else {
//        _activityView.center = CGPointMake(BoardViewSize/2, TBGap+ResultIconSize/2.f);
//    }
//}
//
//- (void)showTipsOnMainTread:(NSDictionary*)diction
//{
//    NSString* info = [diction objectForKey:KeyForTipsContextInfo];
//    NSNumber* modelFlag = [diction objectForKey:KeyForTipsContextModelFlag];
//    BOOL isModal = [modelFlag boolValue];
//    [self setModal:isModal];
//
//    self.hidden = NO;
//    _imageView.hidden = YES;
//
//    [_boardView addSubview:_activityView];
//    [_activityView startAnimating];
//
//    [self updateUIWithInfo:info];
//
//    //这个特殊处理，不使用顶层窗口
//    _window.hidden = YES;
//    id<UIApplicationDelegate> appDelegate = [UIApplication sharedApplication].delegate;
//    UIWindow* window = [appDelegate window];
//    [window addSubview:self];
//}
//
//- (void)showTips:(NSString *)info modal:(BOOL)isModal
//{
//    NSMutableDictionary* context = [[NSMutableDictionary alloc] initWithCapacity:3];
//    if (info) {
//        [context setObject:info forKey:KeyForTipsContextInfo];
//    }
//
//    NSNumber* modelFlag = [[NSNumber alloc] initWithBool:isModal];
//    [context setObject:modelFlag forKey:KeyForTipsContextModelFlag];
//    _window.hidden = NO;
//
//    [self performSelectorOnMainThread:@selector(showTipsOnMainTread:)
//                           withObject:context
//                        waitUntilDone:NO];
//
//    context = nil;
//    modelFlag = nil;
//}
//
//- (void)showFailedTipsOnMainTread:(NSDictionary*)diction
//{
//    NSString* info = [diction objectForKey:KeyForTipsContextInfo];
//    NSNumber* durationNumber = [diction objectForKey:KeyForTipsContextDuration];
//    NSNumber* modelFlag = [diction objectForKey:KeyForTipsContextModelFlag];
//    NSTimeInterval duration = [durationNumber doubleValue];
//    BOOL isModal = [modelFlag boolValue];
//
//    [self setModal:isModal];
//    self.hidden = NO;
//    [_activityView removeFromSuperview];
//    _imageView.image = [UIImage imageNamed:@"TipsFailedIcon"];
//    _imageView.hidden = NO;
//
//    [self updateUIWithInfo:info];
//
//    if (duration > 0) {
//        [self performSelector:@selector(hide) withObject:nil afterDelay:duration];
//    } else{
//        [self performSelector:@selector(hide) withObject:nil afterDelay:DefaultTipsDuration];
//    }
//    _window.hidden = NO;
//    [_window addSubview:self];
//}
//
//- (void)showFailedTips:(NSString *)info duration:(NSTimeInterval)duration modal:(BOOL)isModal
//{
//    NSMutableDictionary* context = [[NSMutableDictionary alloc] initWithCapacity:3];
//    if (info) {
//        [context setObject:info forKey:KeyForTipsContextInfo];
//    }
//    double d = (double)duration;
//    NSNumber* durationNumber = [[NSNumber alloc] initWithDouble:d];
//    [context setObject:durationNumber forKey:KeyForTipsContextDuration];
//
//    NSNumber* modelFlag = [[NSNumber alloc] initWithBool:isModal];
//    [context setObject:modelFlag forKey:KeyForTipsContextModelFlag];
//    _window.hidden = NO;
//
//    [self performSelectorOnMainThread:@selector(showFailedTipsOnMainTread:)
//                           withObject:context
//                        waitUntilDone:NO];
//
//    context = nil;
//    durationNumber = nil;
//    modelFlag = nil;
//}
//
//- (void)showFinishTipsOnMainThread:(NSDictionary*)diction
//{
//    NSString* info = [diction objectForKey:KeyForTipsContextInfo];
//    NSNumber* durationNumber = [diction objectForKey:KeyForTipsContextDuration];
//    NSNumber* modelFlag = [diction objectForKey:KeyForTipsContextModelFlag];
//    NSTimeInterval duration = [durationNumber doubleValue];
//    BOOL isModal = [modelFlag boolValue];
//    [self setModal:isModal];
//
//    self.hidden = NO;
//    [_activityView removeFromSuperview];
//
//    _imageView.image = [UIImage imageNamed:@"TipsSucIcon"];
//    _imageView.hidden = NO;
//    [self updateUIWithInfo:info];
//
//    if (duration > 0) {
//        [self performSelector:@selector(hide) withObject:nil afterDelay:duration];
//    } else {
//        [self performSelector:@selector(hide) withObject:nil afterDelay:DefaultTipsDuration];
//    }
//    _window.hidden = NO;
//    [_window makeKeyAndVisible];
//    [_window addSubview:self];
//}
//
//- (void)showFinishTipsWithoutImageOnMainThread:(NSDictionary*)diction
//{
//    NSString* info = [diction objectForKey:KeyForTipsContextInfo];
//    NSNumber* durationNumber = [diction objectForKey:KeyForTipsContextDuration];
//    NSNumber* modelFlag = [diction objectForKey:KeyForTipsContextModelFlag];
//    NSTimeInterval duration = [durationNumber doubleValue];
//    BOOL isModal = [modelFlag boolValue];
//    [self setModal:isModal];
//
//    self.hidden = NO;
//    [_activityView removeFromSuperview];
//
//    _imageView.image = nil;
//    _imageView.hidden = YES;
//    [self updateUIWithInfo:info];
//
//    if (duration > 0) {
//        [self performSelector:@selector(hide) withObject:nil afterDelay:duration];
//    } else {
//        [self performSelector:@selector(hide) withObject:nil afterDelay:DefaultTipsDuration];
//    }
//    _window.hidden = NO;
//    [_window makeKeyAndVisible];
//    [_window addSubview:self];
//}
//
//- (void)showFinishTips:(NSString *)info duration:(NSTimeInterval)duration modal:(BOOL)isModal
//{
//    NSMutableDictionary* context = [[NSMutableDictionary alloc] initWithCapacity:3];
//    if (info) {
//        [context setObject:info forKey:KeyForTipsContextInfo];
//    }
//    double d = (double)duration;
//    NSNumber *durationNumber = [[NSNumber alloc] initWithDouble:d];
//    [context setObject:durationNumber forKey:KeyForTipsContextDuration];
//
//    NSNumber* modelFlag = [[NSNumber alloc] initWithBool:isModal];
//    [context setObject:modelFlag forKey:KeyForTipsContextModelFlag];
//    _window.hidden = NO;
//
//    [self performSelectorOnMainThread:@selector(showFinishTipsOnMainThread:) withObject:context waitUntilDone:NO];
//}
//
//- (void)hideInternal
//{
//    _window.hidden = YES;
//    [self removeFromSuperview];
//    self.hidden = YES;
//}
//
//- (void)hide
//{
//    [self performSelectorOnMainThread:@selector(hideInternal) withObject:nil waitUntilDone:NO];
//}
//
//- (void)showTipsInfo:(NSString *)info duration:(NSTimeInterval)duration modal:(BOOL)isModal
//{
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//        NSMutableDictionary* context = [[NSMutableDictionary alloc] initWithCapacity:3];
//        if (info) {
//            [context setObject:info forKey:KeyForTipsContextInfo];
//        }
//        double d  = (double)duration;
//        NSNumber* durationNumber = [[NSNumber alloc] initWithDouble:d];
//        [context setObject:durationNumber forKey:KeyForTipsContextDuration];
//
//        NSNumber* modelFlag = [[NSNumber alloc] initWithBool:isModal];
//        [context setObject:modelFlag forKey:KeyForTipsContextModelFlag];
//        _window.hidden = NO;
//
//        [self showFinishTipsWithoutImageOnMainThread:context];
//        //        _imageView.image = nil;
//        //        _labelInfo.center = CGPointMake(_labelInfo.center.x, TBGap+TextHeight/2.f);
//        //        [_boardView setFrame:CGRectMake(_boardView.frame.origin.x, _boardView.frame.origin.y, _boardView.frame.size.width, TBGap+TextHeight+TBGap)];
//
//    }];
//}
//
//- (void)showTipsWithImage:(UIImage*)image info:(NSString *)info duration:(NSTimeInterval)duration modal:(BOOL)isModal;
//{
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//
//        NSMutableDictionary* context = [[NSMutableDictionary alloc] initWithCapacity:3];
//
//        if (info) {
//            [context setObject:info forKey:KeyForTipsContextInfo];
//        }
//        double d = (double)duration;
//        NSNumber* durationNumber = [[NSNumber alloc] initWithDouble:d];
//        [context setObject:durationNumber forKey:KeyForTipsContextDuration];
//
//        NSNumber* modelFlag = [[NSNumber alloc] initWithBool:isModal];
//        [context setObject:modelFlag forKey:KeyForTipsContextModelFlag];
//        _window.hidden = NO;
//
//        [self showFinishTipsOnMainThread:context];
//
//        _imageView.image = image;
//    }];
//}
//
//- (void)showTipsNoneImage:(CGPoint)centerPoint info:(NSString *)info duration:(NSTimeInterval)duration modal:(BOOL)isModal
//{
//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//
//        NSMutableDictionary* context = [[NSMutableDictionary alloc] initWithCapacity:3];
//
//        if (info) {
//            [context setObject:info forKey:KeyForTipsContextInfo];
//        }
//        double d = (double)duration;
//        NSNumber* durationNumber = [[NSNumber alloc] initWithDouble:d];
//        [context setObject:durationNumber forKey:KeyForTipsContextDuration];
//
//        NSNumber* modelFlag = [[NSNumber alloc] initWithBool:isModal];
//        [context setObject:modelFlag forKey:KeyForTipsContextModelFlag];
//        _window.hidden = NO;
//
//        [self showFinishTipsOnMainThread:context];
//
//        _imageView.image = nil;
//        _boardView.frame = CGRectMake(0, 0, BoardViewSize, TextHeight);
//        _boardView.center = centerPoint;
//        _labelInfo.center = CGPointMake(CGRectGetWidth(_boardView.frame) / 2, CGRectGetHeight(_boardView.frame) / 2);
//    }];
//}
//
//- (void)showTipsKeyboardShowing:(NSString *)info modal:(BOOL)isModal
//{
//    _boardView.center = CGPointMake(self.bounds.size.width /2, self.bounds.size.height /2 - 40) ;
//    [self showTips:info modal:isModal];
//}
//- (void)showFailedTipsKeyboardShowing:(NSString *)info duration:(NSTimeInterval)duration modal:(BOOL)isModal
//{
//    _boardView.center = CGPointMake(self.bounds.size.width /2, self.bounds.size.height /2 - 40) ;
//    [self showFailedTips:info duration:duration modal:isModal];
//}
//- (void)showFinishTipsKeyboardShowing:(NSString *)info duration:(NSTimeInterval)duration modal:(BOOL)isModal
//{
//    _boardView.center = CGPointMake(self.bounds.size.width /2, self.bounds.size.height /2 - 40) ;
//    [self showFinishTips:info duration:duration modal:isModal];
//}


@end
