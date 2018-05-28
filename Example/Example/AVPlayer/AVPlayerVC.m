//
//  AVPlayerVC.m
//  Example
//
//  Created by 杨俊 on 2018/5/18.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "AVPlayerVC.h"
#import "YJPlayer.h"

@interface AVPlayerVC ()
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIView *container;
@property (nonatomic, strong) YJPlayer *yjPlayer;
@end

@implementation AVPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.yjPlayer = [YJPlayer newAutoLayoutView];
    [self.container addSubview:self.yjPlayer];
    [self.yjPlayer autoPinEdgesToSuperviewEdges];
}

/**
 *  点击播放/暂停按钮
 *
 *  @param sender 播放/暂停按钮
 */
- (IBAction)play:(UIButton *)sender {
    if(self.yjPlayer.player.rate==0){ //说明时暂停
        [sender setImage:[UIImage imageNamed:@"player_pause"] forState:UIControlStateNormal];
        [self.yjPlayer play];
    }else if(self.yjPlayer.player.rate==1){//正在播放
        [self.yjPlayer pause];
        [sender setImage:[UIImage imageNamed:@"player_play"] forState:UIControlStateNormal];
    }
}

/**
 *  切换选集，这里使用按钮的tag代表视频名称
 *
 *  @param sender 点击按钮对象
 */
- (IBAction)navigationButtonClick:(UIButton *)sender {
//    [self removeNotification];
//    [self removeObserverFromPlayerItem:self.player.currentItem];
//    AVPlayerItem *playerItem=[self getPlayItem:(int)sender.tag];
//    [self addObserverToPlayerItem:playerItem];
//    //切换视频
//    [self.player replaceCurrentItemWithPlayerItem:playerItem];
//    [self addNotification];
}

@end
