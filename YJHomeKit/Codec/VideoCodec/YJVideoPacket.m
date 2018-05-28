//
//  YJVideoPacket.m
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/3.
//

#import "YJVideoPacket.h"

@implementation YJVideoPacket

- (void)dealloc
{
    if (self.buffer) {
        free(self.buffer);
        self.buffer = NULL;
    }
}

@end
