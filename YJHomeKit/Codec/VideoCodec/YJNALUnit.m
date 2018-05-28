//
//  YJNALUnit.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/3.
//

#import "YJNALUnit.h"

@implementation YJNALUnit

- (instancetype)initWithH264RawBuffer:(void *)buffer length:(int)length
{
    if (self = [super init]) {
        _buffer = [NSData dataWithBytes:buffer length:length];
        _length = length;
        _type = NALUnitOther;
        if (length > 4) {
            _type = [self parseTypeWithByte:((uint8_t *)buffer)[4]];
        }
    }
    return self;
}

- (NALUnitType)parseTypeWithByte:(uint8_t)byte
{
    NALUnitType type = NALUnitOther;
    uint8_t typeByte = byte & 0x1f;
    switch (typeByte) {
        case 0x05:
            NSLog(@"Nal type is IDR Frame");
            type = NALUnitIDR;
            break;
        case 0x07:
            NSLog(@"Nal type is SPS");
            type = NALUnitSPS;
            break;
        case 0x08:
            NSLog(@"Nal type is PPS");
            type = NALUnitPPS;
            break;
        case 0x01:
        case 0x02:
        case 0x03:
        case 0x04:
            NSLog(@"Nal type is B/P Frame");
            type = NALUnitPFrame;
            break;
        default:
            NSLog(@"Nal type is 0x%02x", typeByte);
            break;
    }
    return type;
}

- (uint8_t *)bufferWithLengthHeader
{
    uint32_t lengthHeader = htonl(self.length - 4);
    uint8_t *buffer = (uint8_t *)[_buffer bytes];
    memcpy(buffer, &lengthHeader, 4);
    return buffer;
}

- (uint8_t *)bufferWithoutHeader
{
    uint8_t *buffer = (uint8_t *)[_buffer bytes];
    return buffer + 4;
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

@end
