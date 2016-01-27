//
//  ZJFunction.h
//  acggou
//
//  Created by MACMINI on 15/6/12.
//  Copyright (c) 2015年 LZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZJRequest.h"

typedef struct wh{
    CGFloat width;
    CGFloat height;
    CGFloat ratio;
}WidthHeightNote;
//typedef NS_ENUM(NSInteger, ZJPhoneModel) {
//    ZJPhoneModel_1G = 0,
//    ZJPhoneModel_3G,
//    ZJPhoneModel_3GS,
//    ZJPhoneModel_4,
//    ZJPhoneModel_4S,
//    ZJPhoneModel_5,
//    ZJPhoneModel_5S,
//    ZJPhoneModel_6,
//    ZJPhoneModel_6S,
//    ZJPhoneModel_1G,
//    ZJPhoneModel_1G,
//    ZJPhoneModel_1G,
//    ZJPhoneModel_1G,
//    ZJPhoneModel_1G,
//    ZJPhoneModel_1G,
//    ZJPhoneModel_1G,
//    ZJPhoneModel_1G0,
//};
typedef void(^voidBlock)(void);
@interface ZJFunction : NSObject
@property (nonatomic, strong) NSTimer *timer_Function;
/**
 *  设置图片的拉伸模式
 *
 *  @param iv UIImageView
 */
+ (void)setImageMode:(UIImageView *)iv;
/**
 *  用户退出，旧御宅购
 */
+ (void)userLoginOut;
/**
 *  检查时间是否过期，跟现在时间做比较
 *
 *  @param str 指定时间字符串
 *
 *  @return 是否
 */
+ (BOOL)isDateOut:(NSString *)str;
/**
 *  返回手机类型
 *
 *  @return 字符串
 */
+ (NSString *)stringIphoneModel;
/**
 *  自动计算Label高度
 *
 *  @param fas 包括font,size
 *  @param str label字符串
 *  @param la  指定label
 *
 *  @return
 */
+ (CGRect)autoLabelWidthHeight:(fontAndSize)fas andStr:(NSString *)str andLabel:(UILabel *)la;
/**
 *  设置评分星星
 *
 *  @param point 分数, 5星为满
 *  @param bv    背景，满星
 *  @param bfv   前景，结果
 */
+ (void)starObvious:(CGFloat)point andBackView:(UIView *)bv andBeforeView:(UIView *)bfv;
/**
 *  定时器
 *
 *  @param time     指定时间
 *  @param theblock block
 */
+ (void)sleepSomeTimeToAction:(NSTimeInterval)time andBlock:( void(^)(void) )theblock;
/**
 *  顾名思义
 *
 *  @param str
 *
 *  @return
 */
+ (NSString *)md5:(NSString *)str;
/**
 *  label上面的倒数时间
 *
 *  @param btn      label
 *  @param time     倒数时间
 *  @param theblock block
 */
- (void)sleepSomeTimeToAction_CountDown:(UILabel *)btn andAllSecond:(NSTimeInterval)time andBlock: ( void(^)(void) )theblock;
/**
 *  停止倒数
 */
- (void)stopCountDown;

+ (NSInteger)Calculation_Deposit:(CGFloat)input;

+ (id)getProjectParms:(NSString *)name;

/**
 *  设置毛玻璃
 *
 *  @param cgi 图片CGImageRef
 *
 *  @return UIImage
 */
+ (UIImage *)mohu:(CGImageRef)cgi;
/**
 *  在指定UIImageView，设置毛玻璃
 *
 *  @param str ？？？
 *  @param pv  指定UIImageView
 */
+ (void)setBgPic:(NSString *)str andPicView:(UIImageView *)pv;
/**
 *  返回UIImage，指定透明度，颜色
 *
 *  @param alphaValue
 *  @param col
 *
 *  @return
 */
+ (UIImage *)colorToImageAlpha:(CGFloat)alphaValue color:(UIColor *)col;
/**
 *  字典转 "key=value&key=value....."
 *
 *  @param dict
 *
 *  @return
 */
+ (NSString *)dictionaryToString:(NSDictionary *)dict;
/**
 *  判断是否iOS9
 *
 *  @return 
 */
+ (BOOL)isIosNine;
/**
 *  去除字符串两边空白
 *
 *  @param str
 *
 *  @return
 */
+ (NSString *)removeWhiteSpace:(NSString *)str;
/**
 *  13位时间戳字符串处理返回格式化后的时间字符串
 *
 *  @param str 时间戳字符串, NSString和 NSNumber
 *
 *  @return 格式化后的时间字符串
 */
+ (NSString *)zj_timeStampFormat:(id)stamp;
/**
 *  屏幕截图
 *
 *  @param sender   view
 *  @param theblock block
 */
- (void)zj_Screenshot:(UIView *)sender andBlock:( void(^)(NSError *err) )theblock;

+ (UIColor *)stringTOColor:(NSString *)str;
@end
