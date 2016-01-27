//
//  UILabel+LinkLabel.h
//  acggou
//
//  Created by MACMINI on 15/6/30.
//  Copyright (c) 2015年 LZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^voidBlock) (void);
@interface UILabel (LinkLabel)

/**
 *  设置链接样色
 *
 *  @param str    字符串
 *  @param finish 如果不为空，block调用执行逻辑
 */
- (void)setUndelineAttribute:(NSString *)str andBlock:(voidBlock)finish;

/**
 *  设置删除线
 *
 *  @param str 字符串
 */
- (void)setDeleteLineAttribute:(NSString *)str;

/**
 *  设置RMB样式UILabel
 *
 *  @param text 字符串
 */
- (void)setTextRMB:(NSString *)text;

@end
