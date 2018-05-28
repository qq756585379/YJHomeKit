//
//  YJNALUnitParser.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/3.
//

#import <Foundation/Foundation.h>
#import "YJNALUnit.h"

@interface YJNALUnitParser : NSObject

+ (NSArray *)NALUnitsFromH264Buffer:(uint8_t *)buffer length:(int)length;

@end
