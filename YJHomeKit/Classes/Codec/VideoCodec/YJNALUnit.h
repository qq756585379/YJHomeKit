//
//  YJNALUnit.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/3.
//

#import <Foundation/Foundation.h>

#define kNALUnitHeaderSize 4

typedef enum : NSUInteger {
    NALUnitSPS,
    NALUnitPPS,
    NALUnitIDR,
    NALUnitPFrame,
    NALUnitOther
}NALUnitType;

@interface YJNALUnit : NSObject

@property (nonatomic, readonly, assign) NALUnitType type;
@property (nonatomic, readonly, strong) NSData *buffer;
@property (nonatomic, readonly, assign) int length;

- (instancetype)initWithH264RawBuffer:(void *)buffer length:(int)length;
- (uint8_t *)bufferWithLengthHeader; // buffer前4byte为buffer长度
- (uint8_t *)bufferWithoutHeader; // 纯数据buffer

@end
