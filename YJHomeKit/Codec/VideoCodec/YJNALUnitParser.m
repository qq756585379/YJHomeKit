//
//  YJNALUnitParser.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/3.
//

#import "YJNALUnitParser.h"

@implementation YJNALUnitParser

+ (NSArray *)NALUnitsFromH264Buffer:(uint8_t *)buffer length:(int)length
{
    NSMutableArray *nalUnits = [NSMutableArray array];
    uint8_t *unitBegin = buffer;
    uint8_t *unitEnd   = buffer + 4;
    uint8_t KStartCode[4] = {0x0, 0x0, 0x0, 0x1};
    
    while (unitEnd != buffer + length) {
        if (*unitEnd == 0x01) {
            if (memcmp(unitEnd - 3, KStartCode, 4) == 0) {
                YJNALUnit *unit = [[YJNALUnit alloc] initWithH264RawBuffer:unitBegin length:(int)(unitEnd - 3 - unitBegin)];
                unitBegin = unitEnd - 3;
                [nalUnits addObject:unit];
            }
        }
        unitEnd++;
    }
    
    YJNALUnit *unit = [[YJNALUnit alloc] initWithH264RawBuffer:unitBegin length:(int)(unitEnd - unitBegin)];
    [nalUnits addObject:unit];
    return nalUnits;
}

@end
