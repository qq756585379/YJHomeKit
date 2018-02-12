//
//  YJVideoPlayer.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/18.
//

#import "YJVideoPlayer.h"
#import "YJMacro.h"

static NSString * const RateKeyPath                      = @"rate";
static NSString * const StatusKeyPath                    = @"status";
static NSString * const LoadedTimeRangesKeyPath          = @"loadedTimeRanges";
static NSString * const PlaybackBufferEmptyKeyPath       = @"playbackBufferEmpty";
static NSString * const PlaybackLikelyToKeepUpKeyPath    = @"playbackLikelyToKeepUp";

@implementation YJVideoPlayer
{
    id playbackTimerObserver;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

-(AVPlayerLayer *)playerLayer{
    return (AVPlayerLayer *)self.layer;
}

- (AVPlayer *)player {
    return self.playerLayer.player;
}

- (void)setPlayer:(AVPlayer *)player {
    [self.playerLayer setPlayer:player];
}

-(void)setVideoGravity:(AVLayerVideoGravity)gravity {
    self.playerLayer.videoGravity = gravity;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self __init];
    }
    return self;
}

-(void)__init{
    self.backgroundColor = [UIColor blackColor];
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.player = [[AVPlayer alloc] init];
    self.playerLayer.player = self.player;
    [self.player addObserver:self forKeyPath:RateKeyPath options:NSKeyValueObservingOptionNew context:nil];
    
    WEAK_SELF
    /* If you pass NULL, the main queue is used. */
    playbackTimerObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.f, 1.f) queue:NULL usingBlock:^(CMTime time){
        STRONG_SELF
        CMTime playerDuration = [self playerItemDuration];
        if (CMTIME_IS_INVALID(playerDuration)){
//            self.progressSlider.minimumValue = 0.0;
            return;
        }
        
        double duration = CMTimeGetSeconds(playerDuration);
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(YJVideoPlayerDelegateCallBackSildeValue:)]) {
            float value = self.player.currentTime.value / self.player.currentTime.timescale;
            [self.delegate YJVideoPlayerDelegateCallBackSildeValue:value];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ApplicationWillEnterForegroundNotification:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ApplicationDidEnterBackgroundNotification:)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

//+ (NSUInteger)durationWithVideo:(NSURL *)videoUrl{
//    NSDictionary *opts = [NSDictionary dictionaryWithObject:@(NO) forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
//    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoUrl options:opts]; // 初始化视频媒体文件
//    NSUInteger second = 0;
//    second = urlAsset.duration.value / urlAsset.duration.timescale;
//    // 获取视频总时长,单位秒
//    return second;
//}

#pragma mark - getter
- (CMTime)playerItemDuration{
    if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay){
        return self.player.currentItem.duration;
    }
    return kCMTimeInvalid;
}

- (double)duration{
    if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay){
        return CMTimeGetSeconds(self.player.currentItem.asset.duration);
    }
    return 0.f;
}

- (double)currentTime{
    return CMTimeGetSeconds(self.player.currentTime);
}

#pragma mark - setter
- (void)setCurrentTime:(double)time{
    [self.player seekToTime:CMTimeMakeWithSeconds(time, 1.f)];
}

-(void)setMute:(BOOL)mute{
    _mute = mute;
    self.player.muted = mute;
}

-(void)setCurrentItem:(AVPlayerItem *)currentItem{
    if (_currentItem) {
        [self removeCurrentItemKVOAndNotifi];
    }
    _currentItem = currentItem;
    
    [_currentItem addObserver:self forKeyPath:StatusKeyPath options:NSKeyValueObservingOptionNew context:nil];
    //监听网络加载情况属性
    [_currentItem addObserver:self forKeyPath:LoadedTimeRangesKeyPath options:NSKeyValueObservingOptionNew context:nil];
    //监听播放的区域缓存是否为空
    [_currentItem addObserver:self forKeyPath:PlaybackBufferEmptyKeyPath options:NSKeyValueObservingOptionNew context:nil];
    //缓存可以播放的时候调用
    [_currentItem addObserver:self forKeyPath:PlaybackLikelyToKeepUpKeyPath options:NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(PlayerItemDidPlayToEndTimeNotification:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:_currentItem];
    
    [self.player replaceCurrentItemWithPlayerItem:currentItem];
}

#pragma mark - 通知
- (void)ApplicationWillEnterForegroundNotification:(NSNotification *)notification{
//    if (!_isManualPaused) {
//        if (CMTimeGetSeconds(self.time) > 0.f) {
//            @try {
//                [self.player seekToTime:self.time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL finished) {
//                    if (finished) {
//                        [self.player play];
//                    }
//                }];
//            } @catch (NSException *exception) {
//                [self.player play];
//            }
//            self.playerState = IMIVideoPlayerStatePlaying;
//        }
//    }
}

#pragma mark - 通知
- (void)ApplicationDidEnterBackgroundNotification:(NSNotification *)notification{
    [self.player pause];
}

#pragma mark - 通知
- (void)PlayerItemDidPlayToEndTimeNotification:(NSNotification *)notification{

}

#pragma mark - 观察者对应的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:StatusKeyPath]) {
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        switch (playerItem.status) {
            case AVPlayerStatusReadyToPlay:{
                NSLog(@"AVPlayerStatusReadyToPlay");
                break;
            }
            case AVPlayerStatusFailed:{
                NSLog(@"AVPlayerStatusFailed");
                break;
            }
            case AVPlayerStatusUnknown:{
                NSLog(@"AVPlayerStatusUnknown");
                break;
            }
        }
    }
    
    if ([keyPath isEqualToString:LoadedTimeRangesKeyPath]) { //监听播放器的下载进度
        AVPlayerItem *playerItem = (AVPlayerItem *)object;
        NSArray *loadedTimeRanges = [playerItem loadedTimeRanges];
        CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];//获取缓冲区域
        float bufferStart = CMTimeGetSeconds(timeRange.start);
        float bufferDuration = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval bufferProgress = bufferStart + bufferDuration;// 计算缓冲总进度
        CMTime duration = playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        //[self.videoCacheProgress setProgress:bufferProgress / totalDuration animated:YES];
        NSLog(@"SRVideoPlayerItemLoadedTimeRangesKeyPath-------缓冲%f",bufferProgress / totalDuration);
    }
    
    if ([keyPath isEqualToString:PlaybackBufferEmptyKeyPath]) {
        NSLog(@"SRVideoPlayerItemPlaybackBufferEmptyKeyPath");

    }
    
    if ([keyPath isEqualToString:PlaybackLikelyToKeepUpKeyPath]) { //缓冲达到可播放
 
    }
    
    if ([keyPath isEqualToString:RateKeyPath]){//当rate==0时为暂停,rate==1时为播放,当rate等于负数时为回放
        if ([[change objectForKey:NSKeyValueChangeNewKey] integerValue]==0) {
 
        }else{
            
        }
    }
}

-(void)removeCurrentItemKVOAndNotifi{
    [_currentItem removeObserver:self forKeyPath:StatusKeyPath];
    [_currentItem removeObserver:self forKeyPath:LoadedTimeRangesKeyPath];
    [_currentItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [_currentItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:_currentItem];
}

-(void)releasePlayer{
    [self.player pause];
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    [self.player removeObserver:self forKeyPath:RateKeyPath];
    [self.player removeTimeObserver:playbackTimerObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.player = nil;
    [self removeFromSuperview];
    NSLog(@"player deallc");
}

@end
