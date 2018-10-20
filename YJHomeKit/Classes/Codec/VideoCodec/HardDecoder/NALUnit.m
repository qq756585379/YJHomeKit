//
//  NALUnit.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/3.
//

#import "NALUnit.h"

@interface NALUnit()
@property (nonatomic, assign) MHNALUnitType type;
@property (nonatomic, strong) NSData *buffer;
@property (nonatomic, assign) int length;
@end

@implementation NALUnit

- (instancetype)initWithH264RawBuffer:(void *)buffer length:(int)length
{
    if (self = [super init]){
        self.type = [self parseTypeWithByte:(*(uint8_t *)buffer)];
        self.buffer = [NSData dataWithBytes:buffer length:length];
        self.length = length;
    }
    return self;
}

- (NSData *)bufferWithStartCode
{
    uint8_t startCode[] = {0x00, 0x00, 0x00, 0x01};
    NSMutableData *data = [[NSMutableData alloc] initWithBytes:startCode length:4];
    [data appendData:self.buffer];
    return data;
}

- (NSData *)bufferWithLength
{
    uint32_t length = self.length;
    uint32_t length2 = htonl(length);
    NSMutableData *data = [[NSMutableData alloc] initWithBytes:&length2 length:sizeof(uint32_t)];
    [data appendData:self.buffer];
    return data;
}

- (MHNALUnitType)parseTypeWithByte:(uint8_t)byte
{
    uint8_t type = byte & 0x1f;
    if (type == 7){
        return NALUnitTypeSPS;
    }
    if (type == 8){
        return NALUnitTypePPS;
    }
    if (type == 5){
        return NALUnitTypeIDR;
    }
    if (type == 1){
        return NALUnitTypePFrame;
    }
    return NALUnitTypeOther;
}

@end
