//
//  YJVideoUtils.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/3.
//

#import <Foundation/Foundation.h>
#import "NALUnit.h"

@interface YJVideoUtils : NSObject

+ (NSArray *)NALUnitsFromH264BufferWithStartCode:(void *)buffer length:(int)length;

+ (UIImage *)imageWithImageBuffer:(CVImageBufferRef)buffer;

@end
