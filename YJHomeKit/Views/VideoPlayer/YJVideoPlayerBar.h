//
//  YJVideoPlayerBar.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/18.
//

#import <UIKit/UIKit.h>

@protocol YJVideoBottomBarDelegate <NSObject>
- (void)videoBottomBarDidClickPlayPauseBtn:(UIButton *)sender;
- (void)videoBottomBarDidClickChangeScreenBtn:(UIButton *)sender;
- (void)videoBottomBarDidTapSlider:(UISlider *)slider withTap:(UITapGestureRecognizer *)tap;
- (void)videoBottomBarChangingSlider:(UISlider *)slider;
- (void)videoBottomBarDidEndChangeSlider:(UISlider *)slider;
@end

@interface YJVideoPlayerBar : UIView

@property (nonatomic, strong) UILabel *currentTimeLabel;

@property (nonatomic, strong) UILabel *totalTimeLabel;

@property (nonatomic, strong) UIButton *fullScreenBtn;

@property (nonatomic, strong) UIButton *playPauseBtn;

@property (nonatomic, strong) UISlider *progressSlider;

@property (nonatomic, strong) UIProgressView *cacheProgressView;

@property (nonatomic, weak) id<YJVideoBottomBarDelegate> delegate;

@end
