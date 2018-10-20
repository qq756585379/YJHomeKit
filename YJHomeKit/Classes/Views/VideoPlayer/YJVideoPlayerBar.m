//
//  YJVideoPlayerBar.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/18.
//

#import "YJVideoPlayerBar.h"
#import <Masonry/Masonry.h>

#define VideoSrcName(file) 			[@"YJPlayer.bundle" stringByAppendingPathComponent:file]
#define VideoFrameworkSrcName(file) [@"Frameworks/YJHomeKit.framework/YJPlayer.bundle" stringByAppendingPathComponent:file]

@implementation YJVideoPlayerBar

-(void)awakeFromNib{
    [super awakeFromNib];
    [self p_setup];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup{
    [self addSubview:self.playPauseBtn];
    [self addSubview:self.currentTimeLabel];
    [self addSubview:self.fullScreenBtn];
    [self addSubview:self.totalTimeLabel];
    [self addSubview:self.progressSlider];
    [self addSubview:self.cacheProgressView];
    
    __weak typeof(self) weakSelf = self;
    [self.playPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.playPauseBtn.mas_right);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(44);
    }];
    [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
    }];
    [self.totalTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.equalTo(weakSelf.fullScreenBtn.mas_left);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(44);
    }];
    [self.progressSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.currentTimeLabel.mas_right);
        make.top.mas_equalTo(0);
        make.right.equalTo(weakSelf.totalTimeLabel.mas_left);
        make.bottom.mas_equalTo(0);
    }];
    [self.cacheProgressView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.currentTimeLabel.mas_right);
        make.right.equalTo(weakSelf.totalTimeLabel.mas_left);
        make.centerY.equalTo(weakSelf.progressSlider.mas_centerY).offset(1);
        make.height.mas_equalTo(1);
    }];
}

-(void)playPauseBtnAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(videoBottomBarDidClickPlayPauseBtn:)]) {
        [_delegate videoBottomBarDidClickPlayPauseBtn:sender];
    }
}
-(void)changeScreenBtnAction:(UIButton *)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(videoBottomBarDidClickChangeScreenBtn:)]) {
        [_delegate videoBottomBarDidClickChangeScreenBtn:sender];
    }
}
- (void)sliderChanging:(UISlider *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(videoBottomBarChangingSlider:)]) {
        [_delegate videoBottomBarChangingSlider:sender];
    }
}
- (void)sliderDidEndChange:(UISlider *)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(videoBottomBarDidEndChangeSlider:)]) {
        [_delegate videoBottomBarDidEndChangeSlider:sender];
    }
}
- (void)sliderTapAction:(UITapGestureRecognizer *)tap {
    if (_delegate && [_delegate respondsToSelector:@selector(videoBottomBarDidTapSlider:withTap:)]) {
        [_delegate videoBottomBarDidTapSlider:self.progressSlider withTap:tap];
    }
}

- (UIButton *)playPauseBtn {
    if (!_playPauseBtn) {
        _playPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _playPauseBtn.showsTouchWhenHighlighted = YES;
        [_playPauseBtn setImage:[UIImage imageNamed:VideoFrameworkSrcName(@"pause")] forState:UIControlStateNormal];
        [_playPauseBtn setImage:[UIImage imageNamed:VideoFrameworkSrcName(@"play")] forState:UIControlStateSelected];
        [_playPauseBtn addTarget:self action:@selector(playPauseBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playPauseBtn;
}
- (UIButton *)fullScreenBtn {
    if (!_fullScreenBtn) {
        _fullScreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _fullScreenBtn.showsTouchWhenHighlighted = YES;
        [_fullScreenBtn setImage:[UIImage imageNamed:VideoFrameworkSrcName(@"fullscreen")] forState:UIControlStateNormal];
        [_fullScreenBtn setImage:[UIImage imageNamed:VideoFrameworkSrcName(@"nonfullscreen")] forState:UIControlStateSelected];
        [_fullScreenBtn addTarget:self action:@selector(changeScreenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenBtn;
}
- (UILabel *)currentTimeLabel {
    if (!_currentTimeLabel) {
        _currentTimeLabel = [[UILabel alloc] init];
        _currentTimeLabel.textColor = [UIColor whiteColor];
        _currentTimeLabel.font = [UIFont systemFontOfSize:12.0];
        _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currentTimeLabel;
}
- (UILabel *)totalTimeLabel {
    if (!_totalTimeLabel) {
        _totalTimeLabel = [[UILabel alloc]init];
        _totalTimeLabel.textColor = [UIColor whiteColor];
        _totalTimeLabel.font = [UIFont systemFontOfSize:12.0];
        _totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _totalTimeLabel;
}
- (UISlider *)progressSlider {
    if (!_progressSlider) {
        _progressSlider = [[UISlider alloc] init];
        _progressSlider.minimumTrackTintColor = [UIColor whiteColor];
        _progressSlider.maximumTrackTintColor = [UIColor lightGrayColor];
        [_progressSlider setThumbImage:[UIImage imageNamed:@"dot"] forState:UIControlStateNormal];
        [_progressSlider addTarget:self action:@selector(sliderChanging:) forControlEvents:UIControlEventValueChanged];
        [_progressSlider addTarget:self
                            action:@selector(sliderDidEndChange:)
                  forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside | UIControlEventTouchCancel];
    }
    return _progressSlider;
}
- (UIProgressView *)cacheProgressView {
    if (!_cacheProgressView) {
        _cacheProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _cacheProgressView.progressTintColor = [UIColor colorWithWhite:1 alpha:0.75];
        _cacheProgressView.trackTintColor = [UIColor clearColor];
        _cacheProgressView.layer.cornerRadius = 0.5;
        _cacheProgressView.layer.masksToBounds = YES;
    }
    return _cacheProgressView;
}

@end
