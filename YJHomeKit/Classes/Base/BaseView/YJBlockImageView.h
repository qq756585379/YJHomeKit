//
//  YJBlockImageView.h
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import <UIKit/UIKit.h>

@class YJBlockImageView;

typedef void(^YJBlockImageViewClickBlock)(YJBlockImageView *sender);

NS_ASSUME_NONNULL_BEGIN

@interface YJBlockImageView : UIImageView

@property (nonatomic, strong) id data;

- (void)setBlock:(YJBlockImageViewClickBlock)block;

@end

NS_ASSUME_NONNULL_END
