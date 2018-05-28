//
//  YJVideoUtils.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/3.
//

#import "YJVideoUtils.h"

@implementation YJVideoUtils

+ (UIImage *)imageWithImageBuffer:(CVImageBufferRef)imageBuffer
{
    CVPixelBufferLockBaseAddress(imageBuffer,0);
    // Get information about the image
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    CVPlanarPixelBufferInfo_YCbCrBiPlanar *bufferInfo = (CVPlanarPixelBufferInfo_YCbCrBiPlanar *)baseAddress;
    // convert the image
    UIImage *image = [self image:baseAddress bufferInfo:bufferInfo width:width height:height bytesPerRow:bytesPerRow];
    return image;
}

+ (UIImage *)image:(uint8_t *)inBaseAddress bufferInfo:(CVPlanarPixelBufferInfo_YCbCrBiPlanar *)inBufferInfo width:(size_t)inWidth height:(size_t)inHeight bytesPerRow:(size_t)inBytesPerRow
{
    NSUInteger yPitch = htonl(inBufferInfo->componentInfoY.rowBytes);
    uint8_t *rgbBuffer = (uint8_t *)malloc(inWidth * inHeight * 4);
    uint8_t *yBuffer = (uint8_t *)inBaseAddress;
    uint8_t val;
    int bytesPerPixel = 4;
    
    // for each byte in the input buffer, fill in the output buffer with four bytes
    // the first byte is the Alpha channel, then the next three contain the same
    // value of the input buffer
    for(int y = 0; y < inHeight*inWidth; y++)
    {
        val = yBuffer[y];
        // Alpha channel
        rgbBuffer[(y*bytesPerPixel)] = 0xff;
        // next three bytes same as input
        rgbBuffer[(y*bytesPerPixel)+1] = rgbBuffer[(y*bytesPerPixel)+2] =  rgbBuffer[y*bytesPerPixel+3] = val;
    }
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbBuffer, yPitch, inHeight, 8, yPitch*bytesPerPixel, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    CGImageRelease(quartzImage);
    free(rgbBuffer);
    return  image;
}

+ (NSArray *)NALUnitsFromH264BufferWithStartCode:(void *)buffer length:(int)length
{
    NSMutableArray *units = [[NSMutableArray alloc] init];
    NSArray *startCodes = [self rangesOfStartCode:buffer length:length];
    [startCodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSRange range = [(NSValue *)obj rangeValue];
        NSRange nextRange;
        if (idx < [startCodes count] - 1){
            nextRange = [startCodes[idx + 1] rangeValue];
        }else{
            nextRange = NSMakeRange(length, 0);
        }
        NALUnit *unit = [[NALUnit alloc] initWithH264RawBuffer:((uint8_t *)buffer + range.location + range.length) length:(int)(nextRange.location - range.location - range.length)];
        if (unit){
            [units addObject:unit];
        }
    }];
    return units;
}

+ (NSArray *)rangesOfStartCode:(void *)buffer length:(int)length
{
    NSMutableArray *ranges = [[NSMutableArray alloc] init];
    for (int i=0; i<length; i++){
        int startCodeLength = 0;
        uint8_t byte0 = [self byteOfBuffer:buffer AtIndex:i];
        uint8_t byte1 = [self byteOfBuffer:buffer AtIndex:i+1];
        if (byte0 == 0 && byte1 == 0){
            uint8_t byte2 = [self byteOfBuffer:buffer AtIndex:i+2];
            if (byte2 == 1){
                startCodeLength = 3;
            }else if (byte2 == 0){
                uint8_t byte3 = [self byteOfBuffer:buffer AtIndex:i+3];
                if (byte3 == 1){
                    startCodeLength = 4;
                }
            }
        }
        if (startCodeLength > 0){
            NSRange range = NSMakeRange(i, startCodeLength);
            [ranges addObject:[NSValue valueWithRange:range]];
            i += startCodeLength;
        }
    }
    return ranges;
}

+ (uint8_t)byteOfBuffer:(void *)buffer AtIndex:(int)index
{
    return (*((uint8_t *)buffer + index));
}

@end
