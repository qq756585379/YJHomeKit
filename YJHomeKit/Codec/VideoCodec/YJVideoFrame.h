//
//  YJVideoFrame.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/3.
//

#import <Foundation/Foundation.h>

@interface YJVideoFrame : NSObject

@property (nonatomic, strong) NSData *frameInfo; // bytes for TUTK FRAMEINFO_t

+ (instancetype)videoFrameWithPixelBuffer:(CVPixelBufferRef)pixelBuffer;

- (CVPixelBufferRef)pixelBuffer;
- (void)setPixelBuffer:(CVPixelBufferRef)pixelBuffer;

@end
