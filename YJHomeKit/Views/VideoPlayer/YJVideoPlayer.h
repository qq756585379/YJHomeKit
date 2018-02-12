//
//  YJVideoPlayer.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/18.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol YJVideoPlayerDelegate <NSObject>
-(void)YJVideoPlayerDelegateCallBackSildeValue:(float)value;
@end

@interface YJVideoPlayer : UIView

@property (nonatomic, assign) BOOL mute;

@property (nonatomic ,strong) AVPlayer *player;

/* playItem */
@property (nonatomic, retain) AVPlayerItem *currentItem;

@property (nonatomic,   weak) id <YJVideoPlayerDelegate> delegate;

-(void)setVideoGravity:(AVLayerVideoGravity)gravity;

-(void)releasePlayer;

@end
