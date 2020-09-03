//
//  YJNilPlaceHoldView.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJNilPlaceHoldView : UIView

@property (nonatomic, strong) UIImageView *iconIV;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *lookAllButton;

-(void)setImage:(UIImage *)image title:(NSString *)title btnShow:(BOOL)show;

-(void)setImageName:(NSString *)imageName title:(NSString *)title btnShow:(BOOL)show;

@end

NS_ASSUME_NONNULL_END
