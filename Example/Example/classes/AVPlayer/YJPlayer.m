//
//  YJPlayer.m
//  Example
//
//  Created by 杨俊 on 2018/5/18.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "YJPlayer.h"

@interface YJPlayer ()
    
@end

@implementation YJPlayer{
    id playbackTimerObserver;
}
    
// default is [CALayer class]. Used when creating the underlying layer for the view.
+(Class)layerClass{
    return [AVPlayerLayer class];
}
    
-(AVPlayerLayer *)playerLayer{
    return (AVPlayerLayer *)self.layer;
}
    
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}
    
-(void)setupUI{
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;//视频填充模式
}
    
-(void)play{
    [self.player play];
}
    
-(void)pause{
    [self.player pause];
}
    
-(void)mute{
    
}
    
-(void)setMuted:(BOOL)muted{
    _muted = muted;
    self.player.muted = muted;
}
    
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    AVPlayerItem *playerItem = object;
    if ([keyPath isEqualToString:@"status"]) {
        AVPlayerStatus status = [[change objectForKey:@"new"] intValue];
        if(status == AVPlayerStatusReadyToPlay){
            NSLog(@"正在播放...，视频总长度:%.2f",CMTimeGetSeconds(playerItem.duration));
        }
    }else if([keyPath isEqualToString:@"loadedTimeRanges"]){
        NSArray *array = playerItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];//本次缓冲时间范围
        float startSeconds = CMTimeGetSeconds(timeRange.start);
        float durationSeconds = CMTimeGetSeconds(timeRange.duration);
        NSTimeInterval totalBuffer = startSeconds + durationSeconds;//缓冲总长度
        NSLog(@"共缓冲：%.2f",totalBuffer);
    }
}
    
    ///**
    // *  根据视频索引取得AVPlayerItem对象
    // *
    // *  @param videoIndex 视频顺序索引
    // *
    // *  @return AVPlayerItem对象
    // */
    //-(AVPlayerItem *)getPlayItem:(int)videoIndex{
    //    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.1.161/%i.mp4",videoIndex];
    //    return [AVPlayerItem playerItemWithURL:[NSURL URLWithString:urlStr]];
    //}
    
    //-(AVPlayer *)player{
    //    if (!_player) {
    //        AVPlayerItem *playerItem = [self getPlayItem:0];
    //        _player = [AVPlayer playerWithPlayerItem:playerItem];
    //
    //        AVPlayerItem *playerItem = _player.currentItem;
    //        //这里设置每秒执行一次
    //        [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
    //            float current = CMTimeGetSeconds(time);
    //            float total = CMTimeGetSeconds([playerItem duration]);
    //            NSLog(@"当前已经播放%.2fs.",current);
    //            if (current) {
    //                [progress setProgress:(current/total) animated:YES];
    //            }
    //        }];
    //
    //        [self addObserverToPlayerItem:playerItem];
    //    }
    //    return _player;
    //}
    
-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
}
    
    //给AVPlayerItem添加播放完成通知
-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}
    
-(void)addObserverToPlayerItem:(AVPlayerItem *)playerItem{
    //监控状态属性，注意AVPlayer也有一个status属性，通过监控它的status也可以获得播放状态
    [playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //监控网络加载情况属性
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}
    
-(void)removeObserverFromPlayerItem:(AVPlayerItem *)playerItem{
    [playerItem removeObserver:self forKeyPath:@"status"];
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
}
    
-(void)dealloc{
    [self removeObserverFromPlayerItem:self.player.currentItem];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
    
@end
