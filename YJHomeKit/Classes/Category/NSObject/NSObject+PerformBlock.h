//
//  NSObject+YJPerformBlock.h
//  Pods
//
//  Created by 杨俊 on 2017/12/23.
//

#import <Foundation/Foundation.h>

@interface NSObject (PerformBlock)

// try catch
- (NSException *)tryCatch:(void(^)(void))block;
- (NSException *)tryCatch:(void(^)(void))block finally:(void(^)(void))aFinisheBlock;

/**
 *  在主线程运行block
 *
 *  @param aInMainBlock 被运行的block
 */
- (void)performInMainThreadBlock:(void(^)(void))aInMainBlock;
/**
 *  延时在主线程运行block
 *
 *  @param aInMainBlock 被运行的block
 *  @param delay        延时时间
 */
- (void)performInMainThreadBlock:(void(^)(void))aInMainBlock afterSecond:(NSTimeInterval)delay;
/**
 *  在非主线程运行block
 *
 *  @param aInThreadBlock 被运行的block
 */
- (void)performInThreadBlock:(void(^)(void))aInThreadBlock;
/**
 *  延时在非主线程运行block
 *
 *  @param aInThreadBlock 被运行的block
 *  @param delay          延时时间
 */
- (void)performInThreadBlock:(void(^)(void))aInThreadBlock afterSecond:(NSTimeInterval)delay;

-(void)yj_performSelector:(SEL)aSelector withObject:(id)object;

-(void)yj_performSelectorName:(NSString *)aSelector withObject:(id)object;

@end
