//
//  YJPlayer.h
//  Example
//
//  Created by 杨俊 on 2018/5/18.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol YJPlayerDataSource <NSObject>
@required
-(AVPlayerItem *)avPlayerItemForYJPlayer;
@end

@interface YJPlayer : UIView

@property (nonatomic, assign) BOOL muted;
@property (nonatomic, strong) AVPlayer *player;//播放器对象
@property (nonatomic,   weak) id <YJPlayerDataSource> dataSource;

-(void)play;
-(void)pause;
-(void)mute;

@end
