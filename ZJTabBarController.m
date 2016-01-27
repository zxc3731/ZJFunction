//
//  ZJTabBarController.m
//  ElectronicTradingApp
//
//  Created by MACMINI on 15/12/8.
//  Copyright (c) 2015年 leimingtech. All rights reserved.
//

#import "ZJTabBarController.h"
#import "SelectViewController.h"
#import "ClassifyViewController.h"
#import "ETShoppingCartViewController.h"
#import "ETMineViewController.h"
#import "ETUserLoginViewController.h"
#import "ZJNavigationController.h"
@interface ZJTabBarController ()<UITabBarControllerDelegate>
@property (nonatomic, assign) BOOL isTabbarHidden;
@property (nonatomic, strong) NSArray *firstVCArr;
@end

@implementation ZJTabBarController
- (instancetype)init {
    self = [super init];
    if (self) {
        [self zjInit];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
}
- (void)zjInit {
    NSMutableArray *fvca = [NSMutableArray new];
    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    
    SelectViewController*selectVC = [[SelectViewController alloc] init];
    ZJNavigationController *selectNav = [[ZJNavigationController alloc] initWithRootViewController:selectVC];
    [vcArray addObject:selectNav];
    
    ClassifyViewController *classVC = [[ClassifyViewController alloc] init];
    ZJNavigationController *classNav = [[ZJNavigationController alloc] initWithRootViewController:classVC];
    [vcArray addObject:classNav];
    
    ETShoppingCartViewController *shopVC = [[ETShoppingCartViewController alloc] initWithIsFromTab:YES];
    ZJNavigationController *shopNav = [[ZJNavigationController alloc] initWithRootViewController:shopVC];
    [vcArray addObject:shopNav];
    
    ETMineViewController *mineVC = [[ETMineViewController alloc] init];
    ZJNavigationController *mineNav = [[ZJNavigationController alloc] initWithRootViewController:mineVC];
    [vcArray addObject:mineNav];
    
    self.viewControllers = vcArray;
    NSArray *imgs = @[@"主页新_icon", @"分类_icon", @"购物车_icon", @"用户中心_icon"];
    for (int i=0; i<vcArray.count; i++) {
        UIImage *temimg = [UIImage imageNamed:imgs[i]];
        
        UINavigationController *nav = (UINavigationController *)vcArray[i];
        [fvca addObject:nav.viewControllers.firstObject];
        //        UIImage * img = [UIImage imageWithCGImage:temimg.CGImage scale:2 orientation:UIImageOrientationUp];
        [nav.tabBarItem setImage:temimg];
        nav.tabBarController.tabBar.tintColor = [UIColor colorWithRed:252.0/255.0 green:55.0/255.0 blue:7.0/255.0 alpha:1];
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        nav.tabBarController.tabBar.tintColor = [UIColor orangeColor];
        if (i == 0) {
            UIImage *temimg1 = [UIImage imageNamed:@"主页新2_icon"];
            temimg1 = [temimg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = temimg1;
        }
        else if (i == 1) {
            UIImage *temimg1 = [UIImage imageNamed:@"分类_icon-1"];
            temimg1 = [temimg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = temimg1;
        }
        else if (i == 2) {
            UIImage *temimg1 = [UIImage imageNamed:@"购物车_icon-1"];
            temimg1 = [temimg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = temimg1;
        }
        else if (i == 3) {
            UIImage *temimg1 = [UIImage imageNamed:@"用户中心_icon-1"];
            temimg1 = [temimg1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = temimg1;
        }
    }
    self.firstVCArr = [fvca copy];
}
- (void)zj_setTabbarHidden:(BOOL)isH {
    if (isH != self.tabBar.hidden) {
        if (isH) {
            if (self.tabBar.frame.origin.y>=kHeight) {
                return;
            }
            [UIView animateWithDuration:0.2 animations:^{
                CGRect rect = self.tabBar.frame;
                rect.origin.y += 49;
                self.tabBar.frame = rect;
            } completion:^(BOOL finished) {
                self.tabBar.hidden = isH;
            }];
        }
        else {
            if (self.tabBar.frame.origin.y<=kHeight-49) {
                return;
            }
            self.tabBar.hidden = isH;
            [UIView animateWithDuration:0.2 animations:^{
                CGRect rect = self.tabBar.frame;
                rect.origin.y -= 49;
                self.tabBar.frame = rect;
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}
- (void)zj_TBcallTheTabbar:(id)willcurVC {
    if ([self.firstVCArr containsObject:willcurVC]) {
        [self zj_setTabbarHidden:NO];
    }
    else {
        [self zj_setTabbarHidden:YES];
    }
}

@end
 
