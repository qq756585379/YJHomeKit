//
//  YJNilPlaceHoldView.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/4/22.
//

#import "YJNilPlaceHoldView.h"
#import "UIView+YJ.h"
#import "YJMacro.h"
#import "PureLayout.h"

@implementation YJNilPlaceHoldView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUP];
    }
    return self;
}

-(void)buildUP{
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:self.iconIV];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lookAllButton];
    
    [self.iconIV autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.iconIV autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self withOffset:-50];
    [self.iconIV autoSetDimensionsToSize:CGSizeMake(150, 150)];
    
    [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
    [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.iconIV withOffset:5];
    
    [self.lookAllButton autoSetDimension:ALDimensionHeight toSize:45];
    [self.lookAllButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:30];
    [self.lookAllButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:30];
    [self.lookAllButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:60];
}

-(void)setImage:(UIImage *)image title:(NSString *)title btnShow:(BOOL)show{
    self.iconIV.image = image;
    self.titleLabel.text = title;
    self.lookAllButton.hidden = !show;
}

-(void)setImageName:(NSString *)imageName title:(NSString *)title btnShow:(BOOL)show{
    [self setImage:[UIImage imageNamed:imageName] title:title btnShow:show];
}

-(UIImageView *)iconIV{
    if (!_iconIV) {
        _iconIV = [UIImageView newAutoLayoutView];
        _iconIV.contentMode = UIViewContentModeCenter;
        _iconIV.layer.masksToBounds = YES;
        _iconIV.clipsToBounds = YES;
    }
    return _iconIV;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel newAutoLayoutView];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

-(UIButton *)lookAllButton{
    if (!_lookAllButton) {
        _lookAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_lookAllButton setTitle:@"查看全部" forState:UIControlStateNormal];
        [_lookAllButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_lookAllButton doBorderWidth:1 color:HEXCOLOR(0xe9e9e9) cornerRadius:5];
        [_lookAllButton setBackgroundColor:HEXCOLOR(0xf5f5f5)];
        _lookAllButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _lookAllButton;
}

@end
