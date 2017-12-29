//
//  YJRefreshHeader.h
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/27.
//

#import <UIKit/UIKit.h>

@class YJRefreshHeader;

typedef enum{
    YJRefreshHeaderViewStateNormal = 0,			//默认状态
    YJRefreshHeaderViewStatePulling,			//下拉状态
    YJRefreshHeaderViewStateBeforeLoading,		//超过临界的下拉状态，松开就会触发刷新
    YJRefreshHeaderViewStateLoading				//刷新状态
} YJRefreshHeaderViewState;

@protocol YJRefreshHeaderViewDelegate <NSObject>
/**
 *  触发下拉刷新
 *
 *  @param view YJRefreshHeader
 */
- (void)refreshHeaderViewDidTriggerRefresh:(YJRefreshHeader *)view;
@optional
/**
 *  显示当前版本号
 *
 *  @param view YJRefreshHeader
 *
 *  @return NSString
 */
- (NSString *)refreshHeaderViewDataSourceRayBuyVersion:(YJRefreshHeader *)view;
/**
 *  需要显示的最后刷新时间，不实现则会保存在UserDefault中的YJRefreshHeader_LastRefresh，会相互覆盖
 *
 *  @param view YJRefreshHeader
 *
 *  @return NSDate
 */
- (NSDate *)refreshHeaderViewDataSourceLastUpdated:(YJRefreshHeader *)view;
/**
 *  顶部的edge
 *
 *  @return CGFloat
 */
- (CGFloat)refreshHeaderViewTopEdge:(YJRefreshHeader *)view;
@end

@interface YJRefreshHeader : UIView

@property (nonatomic) CGFloat heightOfHeader;

@property (nonatomic,assign,getter=isPhoneHomePageActivityRefreshHeader) BOOL phoneHomePageActivityRefreshHeader;

/**
 *  创建YJRefreshHeader的方法,默认高度60
 *
 *  @param scrollView 需要下拉刷新的UIScrollView
 *
 *  @return YJRefreshHeader
 */
+ (instancetype)addRefreshHeaderViewOnScrollView:(UIScrollView *)scrollView;

/**
 *  创建YJRefreshHeader的方法
 *
 *  @param scrollView 需要下拉刷新的UIScrollView
 *  @param aHeight    自定义高度
 *
 *  @return YJRefreshHeader
 */
+ (instancetype)addRefreshHeaderViewOnScrollView:(UIScrollView *)scrollView andHeight:(CGFloat)aHeight;

/**
 *  刷新日期显示
 */
- (void)refreshLastUpdatedDate;

/**
 *  通知YJRefreshHeader，回到顶部,需要刷新
 *
 *  @param scrollView UIScrollView
 */
- (void)refreshHeaderViewTriggerLoading:(UIScrollView *)scrollView;

/**
 *  通知YJRefreshHeader，数据刷新完毕，恢复原始显示
 *
 *  @param scrollView UIScrollView
 */
- (void)refreshHeaderViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;

/**
 *  代理
 */
@property (nonatomic,     weak) id<YJRefreshHeaderViewDelegate> delegate;

/**
 *  状态
 */
@property (nonatomic, readonly) YJRefreshHeaderViewState state;

/**
 *  是否显示版本号
 */
@property (nonatomic ,assign,getter=isShowVersion) BOOL showVersion;

@end




