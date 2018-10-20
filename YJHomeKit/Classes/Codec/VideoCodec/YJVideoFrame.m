//
//  YJVideoFrame.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/3.
//

#import "YJVideoFrame.h"

@implementation YJVideoFrame
{
    CVPixelBufferRef _pixelBuffer;
}

+ (instancetype)videoFrameWithPixelBuffer:(CVPixelBufferRef)pixelBuffer
{
    YJVideoFrame *instance = [[self alloc] init];
    [instance setPixelBuffer:pixelBuffer];
    return instance;
}

- (CVPixelBufferRef)pixelBuffer
{
    return _pixelBuffer;
}

- (void)setPixelBuffer:(CVPixelBufferRef)pixelBuffer
{
    if (_pixelBuffer) {
        CVPixelBufferRelease(_pixelBuffer);
    }
    _pixelBuffer = CVPixelBufferRetain(pixelBuffer);
}

- (void)dealloc
{
    if (_pixelBuffer) {
        CVPixelBufferRelease(_pixelBuffer);
    }
}

@end
