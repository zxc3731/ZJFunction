//
//  UILabel+LinkLabel.m
//  acggou
//
//  Created by MACMINI on 15/6/30.
//  Copyright (c) 2015年 LZJ. All rights reserved.
//

#import "UILabel+LinkLabel.h"
#import <objc/runtime.h>
static char labelTapKey;
@implementation UILabel (LinkLabel)
- (void)setUndelineAttribute:(NSString *)str andBlock:(voidBlock)finish {
    if (str.length == 0) {
        return;
    }
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(linkAction:)];
    [self addGestureRecognizer:tap];
    
    objc_setAssociatedObject(self, &labelTapKey, finish, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
//    [attri addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, str.length)];
//    [attri addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0, str.length)];
    self.textColor = [UIColor blueColor];
    [self setAttributedText:attri];
}
- (void)setDeleteLineAttribute:(NSString *)str {
    if (str.length == 0) {
        return;
    }
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:str];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, str.length)];
    [attri addAttribute:NSStrikethroughColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, str.length)];
    [self setAttributedText:attri];
}
- (void)linkAction:(UITapGestureRecognizer *)tap {
    voidBlock finish = objc_getAssociatedObject(tap.view, &labelTapKey);
    finish();
}
- (void)setTextRMB:(NSString *)text {
    self.text = [NSString stringWithFormat:@"￥%@", text];
}
@end
 
