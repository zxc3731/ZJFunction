//
//  UIView+additional.h
//  ElectronicTradingApp
//
//  Created by MACMINI on 15/11/6.
//  Copyright (c) 2015年 leimingtech. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ZJViewBorder) {
    ZJViewBorderTop = 1<<1,
    ZJViewBorderLeft = 1<<2,
    ZJViewBorderBottom = 1<<3,
    ZJViewBorderRight = 1<<4,
};
@interface UIView (additional)
@property (nonatomic, assign) ZJViewBorder borderWhich;
- (void)zj_ViewWithNumberPoint:(NSInteger)num;
@end
