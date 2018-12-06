//
//  YJBaseCollectionReusableView.m
//  Pods
//
//  Created by 杨俊 on 2017/12/23.
//

#import "YJCollectionReusableView.h"

@implementation YJCollectionReusableView

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (UINib *)nib
{
    NSString *className = NSStringFromClass([self class]);
    return [UINib nibWithNibName:className bundle:nil];
}

+ (UINib *)nibInBundle:(NSBundle *)bundle
{
    NSString *className = NSStringFromClass([self class]);
    return [UINib nibWithNibName:className bundle:bundle];
}

- (void)updateWithCellData:(id)aData
{
    
}

+ (CGSize)sizeForCellData:(id)aData
{
    return CGSizeZero;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
