//
//  YJRefreshHeader.m
//  YJHomeKit
//
//  Created by 杨俊 on 2017/12/27.
//

#import "YJRefreshHeader.h"
#import "NSMutableArray+safe.h"
#import "YJUserDefault.h"
#import "UIColor+Tool.h"
#import "UIImage+tool.h"
#import "NSBundle+tool.h"
#import "UIView+YJ.h"
#import "YJMacro.h"

static const CGFloat 	YJRefreshHeaderViewDefaultHeight = 65.f;
static const int        YJRefreshHeaderViewTimeLabelWidth = 180;
static const int        YJRefreshHeaderViewDefaultImageCount = 14;

@interface YJRefreshHeader ()
@property (nonatomic) YJRefreshHeaderViewState state;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, getter=isTriggerLoading) BOOL triggerLoading;//触发loading
@property (nonatomic, weak) UIPanGestureRecognizer *panGestureRecognizer;//panGestureRecognizer of scrollView
@end

@implementation YJRefreshHeader

+ (instancetype)addRefreshHeaderViewOnScrollView:(UIScrollView *)scrollView {
    return [self addRefreshHeaderViewOnScrollView:scrollView andHeight:YJRefreshHeaderViewDefaultHeight];
}

+ (instancetype)addRefreshHeaderViewOnScrollView:(UIScrollView *)scrollView andHeight:(CGFloat)aHeight {
    YJRefreshHeader *refreshView = [[YJRefreshHeader alloc] initWithFrame:CGRectMake(0, -aHeight, scrollView.frame.size.width, aHeight)];
    refreshView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    refreshView.heightOfHeader = aHeight;
    [scrollView addSubview:refreshView];
    return refreshView;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
        self.infoLabel = [UILabel autolayoutView];
        self.infoLabel.font = [UIFont systemFontOfSize:12.0f];
        self.infoLabel.textColor = [UIColor lightGrayColor];
        self.infoLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.infoLabel];
        
        self.timeLabel = [UILabel autolayoutView];
        self.timeLabel.font = [UIFont systemFontOfSize:12.0f];
        self.timeLabel.textColor = [UIColor lightGrayColor];
        self.timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.timeLabel];
        
        self.arrowImageView = [UIImageView autolayoutView];
        [self addSubview:self.arrowImageView];
        
        NSBundle *bundle = [NSBundle bundleWithClass:[YJRefreshHeader class] pathForResource:@"RefreshHeaderImg"];
        NSMutableArray *images = [NSMutableArray array];
        for (int i = 0; i <= YJRefreshHeaderViewDefaultImageCount; i++)
        {
            NSString *imgName = [NSString stringWithFormat:@"1-logo-通道_000%02d",i];
            NSString *path = [bundle pathForResource:imgName ofType:@"png"];
            UIImage *image = [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            [images safeAddObject:image];
        }
        
        if (images.count > 1) {
            self.arrowImageView.animationDuration = 1.f;
            self.arrowImageView.animationImages = images;
        } else if(images.count == 1){
            self.arrowImageView.image = images[0];
        }
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.infoLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.arrowImageView attribute:NSLayoutAttributeRight multiplier:1.f constant:5.f]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.infoLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.f constant:18.f]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.f constant:0.f]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.infoLabel attribute:NSLayoutAttributeBottom multiplier:1.f constant:10.f]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.infoLabel attribute:NSLayoutAttributeCenterY multiplier:1.f constant:0.f]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.arrowImageView attribute:NSLayoutAttributeLeft
                                                         relatedBy:NSLayoutRelationEqual toItem:self.timeLabel attribute:NSLayoutAttributeLeft multiplier:1.f constant:10.f]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self.timeLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.f constant:YJRefreshHeaderViewTimeLabelWidth]];
        
        self.state = YJRefreshHeaderViewStateNormal;
        self.showVersion = NO;
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    [self removeKVO];
    if (newSuperview && [newSuperview isKindOfClass:[UIScrollView class]]) {
        [self registKVOWithScrollView:(UIScrollView *)newSuperview];
    }
}

#pragma mark - Public API
- (void)refreshLastUpdatedDate {
    if ([self.delegate respondsToSelector:@selector(refreshHeaderViewDataSourceRayBuyVersion:)] && self.isShowVersion) {
        NSString *currentVersion = [self.delegate refreshHeaderViewDataSourceRayBuyVersion:self];
        if (currentVersion) {
            self.timeLabel.text = currentVersion;
        } else{
            self.timeLabel.text = nil;
        }
    } else{
        if ([self.delegate respondsToSelector:@selector(refreshHeaderViewDataSourceLastUpdated:)]) {
            NSDate *date = [self.delegate refreshHeaderViewDataSourceLastUpdated:self];
            if (date) {
                NSDateFormatter *formatter = [NSDateFormatter new];
                formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
                formatter.dateFormat = @"yyyy.MM.dd a h:mm";
                self.timeLabel.text = [NSString stringWithFormat:@"上次刷新: %@", [formatter stringFromDate:date]];
            } else {
                self.timeLabel.text = nil;
            }
        } else if ([YJUserDefault getValueForKey:@"OTSRefreshHeaderView_LastRefresh"]) {
            self.timeLabel.text = [YJUserDefault getValueForKey:@"OTSRefreshHeaderView_LastRefresh"];
        } else {
            self.timeLabel.text = nil;
        }
    }
    if (!self.timeLabel.text) {
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        formatter.dateFormat = @"yyyy.MM.dd a h:mm";
        self.timeLabel.text = [NSString stringWithFormat:@"上次刷新: %@", [formatter stringFromDate:[NSDate date]]];
        self.timeLabel.hidden = YES;
    } else {
        self.timeLabel.hidden = self.phoneHomePageActivityRefreshHeader;
    }
}

- (void)refreshHeaderViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    [UIView animateWithDuration:.5f animations:^{
        UIEdgeInsets insets =  scrollView.contentInset;
        CGFloat topEdge = 0.f;
        if ([self.delegate respondsToSelector:@selector(refreshHeaderViewTopEdge:)]) {
            topEdge = [self.delegate refreshHeaderViewTopEdge:self];
        }
        insets.top = topEdge;
        scrollView.contentInset = insets;
    }];
    
    if (self.isTriggerLoading) {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        self.triggerLoading = NO;
    }
    
    self.state = YJRefreshHeaderViewStateNormal;
}

- (void)refreshHeaderViewTriggerLoading:(UIScrollView *)scrollView {
    self.triggerLoading = YES;
    [scrollView setContentOffset:CGPointMake(0, -(self.heightOfHeader + (self.phoneHomePageActivityRefreshHeader ? 0.f : 5.f))) animated:YES];
    self.state = YJRefreshHeaderViewStateLoading;
    [self refreshLastUpdatedDate];
    
    if ([self.delegate respondsToSelector:@selector(refreshHeaderViewDidTriggerRefresh:)]) {
        [self.delegate refreshHeaderViewDidTriggerRefresh:self];
    }
}

#pragma mark - KVO
- (void)registKVOWithScrollView:(UIScrollView *)scrollView {
    self.panGestureRecognizer = scrollView.panGestureRecognizer;
    [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    [self.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    UIScrollView *scrollView = (UIScrollView *)self.superview;
    if([keyPath isEqualToString:@"contentOffset"]) {
        [self _otsRefreshHeaderViewDidScroll:scrollView];
    } else if([keyPath isEqualToString:@"state"]) {
        if (scrollView.panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
            [self _otsRefreshHeaderViewDidEndDragging:scrollView];
        }
    }
}

- (void)removeKVO {
    UIView *superView = self.superview;
    if (![superView isKindOfClass:[UIScrollView class]]) {
        return;
    }
    UIScrollView *scrollView = (UIScrollView *)superView;
    [scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [self.panGestureRecognizer removeObserver:self forKeyPath:@"state"];
}

#pragma mark - Setter
-(void)setPhoneHomePageActivityRefreshHeader:(BOOL)phoneHomePageActivityRefreshHeader {
    _phoneHomePageActivityRefreshHeader = phoneHomePageActivityRefreshHeader;
    if (phoneHomePageActivityRefreshHeader) {
        self.backgroundColor = [UIColor clearColor];
        [self setBackgroundImageVHiddenWithBool:NO];
    } else {
        [self setBackgroundImageVHiddenWithBool:YES];
    }
}

-(void)setBackgroundImageVHiddenWithBool:(BOOL)isHidden {
    _infoLabel.hidden           =
    _arrowImageView.hidden      =
    _timeLabel.hidden           = !isHidden;
}

- (void)setState:(YJRefreshHeaderViewState)state {
    switch (state) {
        case YJRefreshHeaderViewStateNormal: {
            self.infoLabel.text = @"下拉可以刷新...";
            [self.arrowImageView stopAnimating];
            
            [self refreshLastUpdatedDate];
        }
            break ;
        case YJRefreshHeaderViewStatePulling: {
            self.infoLabel.text = @"下拉可以刷新...";
        }
            break;
        case YJRefreshHeaderViewStateBeforeLoading: {
            self.infoLabel.text = @"松开即可刷新...";
        }
            break;
        case YJRefreshHeaderViewStateLoading: {
            self.infoLabel.text = @"载入中...";
            [self.arrowImageView startAnimating];
        }
            break;
        default:
            break;
    }
    _state = state;
}

#pragma mark - Private
- (void)_otsRefreshHeaderViewDidScroll:(UIScrollView *)scrollView
{
    if (self.state != YJRefreshHeaderViewStateLoading && scrollView.isDragging)
    {
        if (self.state == YJRefreshHeaderViewStateNormal && scrollView.contentOffset.y < 0) {
            
            [self refreshLastUpdatedDate];
            self.state = YJRefreshHeaderViewStatePulling;
            
        } else if (self.state == YJRefreshHeaderViewStatePulling &&
                   scrollView.contentOffset.y <= -(self.heightOfHeader + (self.phoneHomePageActivityRefreshHeader ? 0.f : 5.f))) {
            
            self.state = YJRefreshHeaderViewStateBeforeLoading;
            
        } else if (self.state == YJRefreshHeaderViewStateBeforeLoading &&
                   scrollView.contentOffset.y > -(self.heightOfHeader + (self.phoneHomePageActivityRefreshHeader ? 0.f : 5.f))) {
            
            self.state = YJRefreshHeaderViewStatePulling;
            
        }
    } else if (self.state != YJRefreshHeaderViewStateLoading && scrollView.contentOffset.y == 0) {
        
        self.state = YJRefreshHeaderViewStateNormal;
        
    }
    
    if (scrollView.contentOffset.y < 0 && self.arrowImageView.animationImages)
    {
        NSBundle *bundle = [NSBundle bundleWithClass:[YJRefreshHeader class] pathForResource:@"RefreshHeaderImg"];
        NSString *imgName = [NSString stringWithFormat:@"1-logo-通道_000%02d",((int)-scrollView.contentOffset.y / 2 % YJRefreshHeaderViewDefaultImageCount)];
        NSString *path = [bundle pathForResource:imgName ofType:@"png"];
        UIImage *image = [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.arrowImageView.image = image;
    }
}

- (void)_otsRefreshHeaderViewDidEndDragging:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y <= -(self.heightOfHeader + (self.phoneHomePageActivityRefreshHeader ? 0.f : 5.f)) &&
        self.state == YJRefreshHeaderViewStateBeforeLoading) {
        
        if ([self.delegate respondsToSelector:@selector(refreshHeaderViewDidTriggerRefresh:)]) {
            [self.delegate refreshHeaderViewDidTriggerRefresh:self];
        }
        
        self.state = YJRefreshHeaderViewStateLoading;
        WEAK_SELF;
        [UIView animateWithDuration:.2f animations:^{
            STRONG_SELF;
            UIEdgeInsets insets =  scrollView.contentInset;
            CGFloat topEdge = 0.f;
            if ([self.delegate respondsToSelector:@selector(refreshHeaderViewTopEdge:)]) {
                topEdge = [self.delegate refreshHeaderViewTopEdge:self];
            }
            insets.top = self.heightOfHeader + topEdge;
            scrollView.contentInset = insets;
        }];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
