//
//  UIImageView+additional.m
//  ElectronicTradingApp
//
//  Created by MACMINI on 15/12/21.
//  Copyright (c) 2015年 leimingtech. All rights reserved.
//

#import "UIImageView+additional.h"

@implementation UIImageView (additional)
- (void)setClickEnlarge:(BOOL)bl {
    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self removeGestureRecognizer:obj];
    }];
    if (bl) {
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
        [self addGestureRecognizer:tap1];

    }
}
- (void)clickImage:(UITapGestureRecognizer *)tap {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        [MBProgressHUD hideHUDForView:window animated:YES];
    }
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    HUD.mode = MBProgressHUDModeCustomView;
    UIImageView *al = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kWidth-30, kHeight-64-49)];
    al.center = CGPointMake(kWidth/2.0, kHeight/2.0);
    [ZJFunction setImageMode:al];
    al.image = self.image;
    HUD.customView = al;
    HUD.color = [UIColor clearColor];
    HUD.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    HUD.margin = 0;
    CGRect rect = HUD.customView.frame;
    rect.origin.x = 0;
    HUD.customView.frame = rect;
    [HUD show:YES];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHidden:)];
    [HUD addGestureRecognizer:tap1];
}
- (void)clickHidden:(UITapGestureRecognizer *)tap {
    MBProgressHUD *HUD = (MBProgressHUD *)tap.view;
    [HUD hide:YES];
}
@end
