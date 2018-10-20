//
//  YJVideoContainer.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/1/18.
//

#import "YJVideoContainer.h"
#import "YJVideoPlayerBar.h"
#import "YJVideoPlayer.h"
#import "Masonry.h"

@interface YJVideoContainer()
@property (nonatomic, strong) YJVideoPlayer *vedioPlayer;
@property (nonatomic, strong) YJVideoPlayerBar *vedioBottomBar;
@end

@implementation YJVideoContainer

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self __init];
    }
    return self;
}

-(void)__init{
    self.backgroundColor = [UIColor blackColor];
    
    self.vedioPlayer = [YJVideoPlayer new];
    self.vedioBottomBar = [YJVideoPlayerBar new];

    [self addSubview:self.vedioPlayer];
    [self addSubview:self.vedioBottomBar];
    
    [self.vedioPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
}

@end
