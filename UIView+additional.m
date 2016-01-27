//
//  UIView+additional.m
//  ElectronicTradingApp
//
//  Created by MACMINI on 15/11/6.
//  Copyright (c) 2015年 leimingtech. All rights reserved.
//

#import "UIView+additional.h"
#import <objc/runtime.h>
@implementation UIView (additional)
@dynamic borderWhich;
static char borderWhichKey_top;
static char borderWhichKey_left;
static char borderWhichKey_bottom;
static char borderWhichKey_right;
- (void)setBorderWhich:(ZJViewBorder)borderWhich {
    CGFloat bh = self.layer.borderWidth;
    
    if (borderWhich & ZJViewBorderBottom) {
        [self addBottomBorder:self borderHeight:bh];
    }
    if (borderWhich & ZJViewBorderLeft) {
        [self addLeftBorder:self borderHeight:bh];
    }
    if (borderWhich & ZJViewBorderRight) {
        [self addRightBorder:self borderHeight:bh];
    }
    if (borderWhich & ZJViewBorderTop) {
        [self addTopBorder:self borderHeight:bh];
    }
    self.layer.borderWidth = 0;
}
- (void)addTopBorder:(UIView *)vi borderHeight:(CGFloat)bh {
    CGColorRef col = vi.layer.borderColor;
    if (vi.layer.borderWidth > 1000 || vi.layer.borderWidth == 0) {
        bh = 1;
    }
    else
        bh = vi.layer.borderWidth;
    CALayer *border = objc_getAssociatedObject(self, &borderWhichKey_top);
    if (!border) {
        border = [CALayer new];
        objc_setAssociatedObject(self, &borderWhichKey_top, border, OBJC_ASSOCIATION_RETAIN);
    }
    border.frame = CGRectMake(0, 0, vi.frame.size.width, bh);
    border.backgroundColor = col;
    [vi.layer addSublayer:border];
}
- (void)addLeftBorder:(UIView *)vi borderHeight:(CGFloat)bh{
    CGColorRef col = vi.layer.borderColor;
    if (vi.layer.borderWidth > 1000 || vi.layer.borderWidth == 0) {
        bh = 1;
    }
    else
        bh = vi.layer.borderWidth;
    CALayer *border = objc_getAssociatedObject(self, &borderWhichKey_left);
    if (!border) {
        border = [CALayer new];
        objc_setAssociatedObject(self, &borderWhichKey_left, border, OBJC_ASSOCIATION_RETAIN);
    }
    border.frame = CGRectMake(0, 0, bh, vi.frame.size.height);
    border.backgroundColor = col;
    [vi.layer addSublayer:border];
}
- (void)addBottomBorder:(UIView *)vi borderHeight:(CGFloat)bh{
    CGColorRef col = vi.layer.borderColor;
    if (vi.layer.borderWidth > 1000 || vi.layer.borderWidth == 0) {
        bh = 1;
    }
    else
        bh = vi.layer.borderWidth;
    CALayer *border = objc_getAssociatedObject(self, &borderWhichKey_bottom);
    if (!border) {
        border = [CALayer new];
        objc_setAssociatedObject(self, &borderWhichKey_bottom, border, OBJC_ASSOCIATION_RETAIN);
    }
    border.frame = CGRectMake(0, vi.frame.size.height-bh, vi.frame.size.width, bh);
    border.backgroundColor = col;
    [vi.layer addSublayer:border];
}
- (void)addRightBorder:(UIView *)vi borderHeight:(CGFloat)bh{
    CGColorRef col = vi.layer.borderColor;
    if (vi.layer.borderWidth > 1000 || vi.layer.borderWidth == 0) {
        bh = 1;
    }
    else
        bh = vi.layer.borderWidth;
    CALayer *border = objc_getAssociatedObject(self, &borderWhichKey_right);
    if (!border) {
        border = [CALayer new];
        objc_setAssociatedObject(self, &borderWhichKey_right, border, OBJC_ASSOCIATION_RETAIN);
    }
    border.frame = CGRectMake(vi.frame.size.width-bh, 0, bh, vi.frame.size.height);
    border.backgroundColor = col;
    [vi.layer addSublayer:border];
}

#pragma mark - 画圆点
- (void)zj_ViewWithNumberPoint:(NSInteger)num {
    CGFloat pointWidth = 20;
    
    UILabel *temlal = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - pointWidth/2, - pointWidth/2, pointWidth, pointWidth)];
    temlal.textColor = [UIColor whiteColor];
    temlal.backgroundColor = [UIColor redColor];
    temlal.clipsToBounds = YES;
    temlal.layer.cornerRadius = pointWidth/2;
    temlal.textAlignment = NSTextAlignmentCenter;
    temlal.font = [UIFont boldSystemFontOfSize:10];
    temlal.text = @(num).stringValue;
    
    [self addSubview:temlal];
}
@end
