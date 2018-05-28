//
//  RunTimeVC.m
//  Example
//
//  Created by 杨俊 on 2018/5/18.
//  Copyright © 2018年 上海创米科技有限公司. All rights reserved.
//

#import "RunTimeVC.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Person.h"

@interface RunTimeVC ()

@end

@implementation RunTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self exchangeMethod];
}

-(void)exchangeMethod{
    Method method1 = class_getInstanceMethod([Person class], @selector(run));
    Method method2 = class_getInstanceMethod([Person class], @selector(study));
    method_exchangeImplementations(method1, method2);
    Person *p = [[Person alloc] init];
    [p run];
    [p sleep];
    
    // 存储实例变量列表中实例变量的数量
    unsigned int ivarCount = 0;
    // 返回一个数组，数组中的元素都是Ivar
    Ivar *ivarList = class_copyIvarList([Person class], &ivarCount);
    
    for (int i = 0; i < ivarCount; i++) {
        Ivar ivar = ivarList[i];
        // 获取实例变量的名称
        const char *name = ivar_getName(ivar);
        NSLog(@"name--%s",name);
    }
    
    // 存储方法列表中方法的数量
    unsigned int methodCount = 0;
    // 返回一个数组，数组中的元素都是Method
    Method *methodList = class_copyMethodList([Person class], &methodCount);
    for (int i = 0; i < methodCount; i++) {
        Method method = methodList[i];
        // 获取对应方法选择器
        SEL methodSel = method_getName(method);
        // 将方法选择器转为字符串
        NSString *methodName = NSStringFromSelector(methodSel);
        NSLog(@"methodName--%@",methodName);
    }
    
    // 动态创建Student类
    Class Student = objc_allocateClassPair([Person class], "Student", 0);
    // 动态为Student类添加实例变量 studyId， 类型是 NSString
    BOOL isAddIvar = class_addIvar(Student, "studyId", sizeof(NSString *), 0, "@");
    // 判断是否添加成功
    if (!isAddIvar) {
        NSLog(@"添加实例变量失败");
    }
    
    // 创建Student对象为我们动态添加的实例变量赋值
    id student = [[Student alloc] init];
    // 使用kvc为对象的属性设置值
    [student setValue:@"100号" forKey:@"studyId"];
    NSLog(@"studyId = %@",[student valueForKey:@"studyId"]);
    
    //  动态为Student类添加 study 方法
    BOOL isAddMethod = class_addMethod([Student class], @selector(study), (IMP)study_imp, "v@:");
    //  判断是否添加方法成功
    if (!isAddMethod) {
        NSLog(@"添加方法失败");
    }
    //  使用我们动态添加的方法
    [student study];
}

- (void)study {
    NSLog(@"study");
}

// 方法的实现 id self, SEL _cmd 是C语言函数默认的两个参数
void study_imp(id self, SEL _cmd) {
    NSLog(@"study_imp");
}

@end
