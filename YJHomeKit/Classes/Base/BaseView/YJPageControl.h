//
//  YJPageControl.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YJPageControl : UIPageControl

@property (nonatomic, strong) UIColor   *borderColor;
@property (nonatomic, strong) UIColor   *fillColor;
@property (nonatomic, strong) UIColor   *pageFillColor; //没有选中点的颜色
@property (nonatomic, assign) NSInteger borderWidth;
@property (nonatomic, strong) UIColor   *changeColor;
@property (nonatomic, assign) BOOL      isChangeColor;

/**
 *  选中时的图片
 */
@property (nonatomic, strong) UIImage *activeImage;

/**
 *  非选中时的图片
 */
@property (nonatomic, strong) UIImage *inactiveImage;

@end

NS_ASSUME_NONNULL_END
