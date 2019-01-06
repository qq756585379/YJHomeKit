//
//  YJTableHeaderFooterView.m
//  YJHomeKit
//
//  Created by 杨俊 on 2019/1/5.
//

#import "YJTableHeaderFooterView.h"

@implementation YJTableHeaderFooterView

+(instancetype)tableHeaderWithTableView:(UITableView *)tv
{
    YJTableHeaderFooterView *header = [tv dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([self class])];
    if (!header) {
        header = [[self alloc] initWithReuseIdentifier:NSStringFromClass([self class])];
    }
    return header;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

+ (NSString *)cellReuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (void)updateWithCellData:(id)aData{
    
}

+ (CGFloat)heightForCellData:(id)aData{
    return 0;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
