//
//  MutliThreadVC.m
//  Example
//
//  Created by 杨俊 on 2018/5/28.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "MutliThreadVC.h"

@interface MutliThreadVC ()

@end

@implementation MutliThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)testOperationQueue{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *operation1 = [NSBlockOperation blockOperationWithBlock:^{
        
    }];
    
    NSBlockOperation *operation2 = [NSBlockOperation blockOperationWithBlock:^{
       
    }];
    
    [operation2 addDependency:operation1];//必须依赖与1
    [queue addOperation:operation1];
    [queue addOperation:operation2];
}

- (void)testKvc{
//    HMPerson *p = [[HMPerson alloc] init];
//    p.age = 20;
//    int age = [[p valueForKey:@"age"] intValue];
//    NSLog(@"年龄=%d", age);
//    NSLog(@"%f", [[p valueForKey:@"height"] floatValue]);
//
//    float h1 = [[p valueForKey:@"height"] floatValue];
//    float h2 = [[p valueForKeyPath:@"height"] floatValue];
//    NSLog(@"%f %f", h1, h2);
//
//    p.dog = [[HMDog alloc] init];
//    p.dog.name = @"wangcai";
//    NSLog(@"%@", [p valueForKeyPath:@"dog.name"]);
//
//    HMBook *b1 = [[HMBook alloc] init];
//    b1.name = @"kuihua";
//    b1.price = 100.6;
//
//    HMBook *b2 = [[HMBook alloc] init];
//    b2.name = @"pixie";
//    b2.price = 5.6;
//
//    HMBook *b3 = [[HMBook alloc] init];
//    b3.name = @"jiuyin";
//    b3.price = 50.6;
//
//    p.books = @[b1, b2, b3];
//
//    NSLog(@"%@", [p valueForKeyPath:@"books.@count"]); // 计算数组的长度
//    NSArray *names = [p valueForKeyPath:@"books.name"];
//    NSArray *names1 = [p.books valueForKeyPath:@"name"];
//    NSLog(@"%@", names1);
//    NSLog(@"%@",names);
//    //求和公式
//    double sumPrice = [[p valueForKeyPath:@"books.@sum.price"] doubleValue];
//    NSLog(@"%f", sumPrice);
}

@end
