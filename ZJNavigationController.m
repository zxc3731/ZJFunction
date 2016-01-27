//
//  ZJNavigationController.m
//  acggou
//
//  Created by MACMINI on 15/8/28.
//  Copyright (c) 2015年 LZJ. All rights reserved.
//

#import "ZJNavigationController.h"

@interface ZJNavigationController ()<UIGestureRecognizerDelegate>
{
    id curVc;
    
}
@end

@implementation ZJNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    id target = self.interactivePopGestureRecognizer.delegate;
    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    UISwipeGestureRecognizer *pan = [[UISwipeGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    // 设置手势代理，拦截手势触发
    pan.delegate = self;
    // 给导航控制器的view添加全屏滑动手势
    [self.view addGestureRecognizer:pan];
    // 禁止使用系统自带的滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;

    // Do any additional setup after loading the view.
}
- (void)zjSetMySpecailStop:(id)thevc {
    curVc = thevc;
}
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    if (self.childViewControllers.count == 1 || self.childViewControllers.lastObject == curVc) {
        // 表示用户在根控制器界面，就不需要触发滑动手势，
        return NO;
    }
    
    return YES;
}

@end
