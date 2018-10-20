//
//  NALUnit.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/3.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NALUnitTypeSPS,
    NALUnitTypePPS,
    NALUnitTypeIDR,
    NALUnitTypePFrame,
    NALUnitTypeOther
} MHNALUnitType;

@interface NALUnit : NSObject

@property (nonatomic, readonly, assign) MHNALUnitType type;
@property (nonatomic, readonly, strong) NSData *buffer;
@property (nonatomic, readonly, assign) int length;

- (instancetype)initWithH264RawBuffer:(void *)buffer length:(int)length; // without start code or length
- (NSData *)bufferWithStartCode;
- (NSData *)bufferWithLength;

@end
