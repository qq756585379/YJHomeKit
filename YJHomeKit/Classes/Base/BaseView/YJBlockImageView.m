//
//  YJBlockImageView.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import "YJBlockImageView.h"

@interface YJBlockImageView ()
@property (nonatomic, copy) YJBlockImageViewClickBlock clickBlock;
@end

@implementation YJBlockImageView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.userInteractionEnabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPressedImageView:)];
    [self addGestureRecognizer:tap];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPressedImageView:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)onPressedImageView:(YJBlockImageView *)sender
{
    if (self.clickBlock) {
        self.clickBlock(self);
    }
}

- (void)setBlock:(YJBlockImageViewClickBlock)block{
    self.clickBlock = block;
    if (self.clickBlock) {
        self.userInteractionEnabled = YES;
    }else {
        self.userInteractionEnabled = NO;
    }
}

@end
