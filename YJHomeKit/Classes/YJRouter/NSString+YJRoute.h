//
//  NSString+YJRoute.h
//  YJRouter
//
//  Created by 杨俊 on 2018/11/18.
//  Copyright © 2018年 杨俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface NSString (YJRoute)

+ (NSDictionary *)getDictFromUrl:(NSURL *)url;

@end

