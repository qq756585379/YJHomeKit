//
//  YJBaseCollectionReusableView.m
//  Pods
//
//  Created by 杨俊 on 2017/12/23.
//

#import "YJBaseCollectionReusableView.h"

@implementation YJBaseCollectionReusableView

+ (NSString *)cellReuseIdentifier{
    return NSStringFromClass([self class]);
}

+ (UINib *)nib{
    NSString *className = NSStringFromClass([self class]);
    return [UINib nibWithNibName:className bundle:nil];
}

- (void)updateWithCellData:(id)aData{
    
}

+ (CGSize)sizeForCellData:(id)aData{
    return CGSizeZero;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
