//
//  YJVideoPacket.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/3.
//

#import <Foundation/Foundation.h>

@interface YJVideoPacket : NSObject
@property (nonatomic, strong) NSData *frameInfo; // bytes for TUTK FRAMEINFO_t
@property (nonatomic, assign) uint8_t *buffer;
@property (nonatomic, assign) int length;
@property (nonatomic, assign) int videoWidth;
@property (nonatomic, assign) int videoHeight;
@property (nonatomic, assign) BOOL isIFrame; //是否 I Frame
@end
