//
//  YJDelegateVO.h
//  YJHomeKit
//
//  Created by 杨俊 on 2018/5/9.
//

#import <Foundation/Foundation.h>

@interface YJDelegateVO : NSObject
@property (nonatomic, assign) SEL delmethod;
@property (nonatomic,   copy) NSString *aSelector;
@property (nonatomic, strong) NSDictionary *dataDcit;
@property (nonatomic,   weak) id subscriber;
-(instancetype)initWithSel:(SEL)sel data:(NSDictionary *)data;
-(instancetype)initWithSelector:(NSString *)selName data:(NSDictionary *)data;
-(instancetype)initWithSel:(SEL)sel subscriber:(id)subscriber;
-(void)broadCastTopicWithData:(NSDictionary *)data;//发布广播
@end
