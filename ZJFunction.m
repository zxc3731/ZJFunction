//
//  ZJFunction.m
//  acggou
//
//  Created by MACMINI on 15/6/12.
//  Copyright (c) 2015年 LZJ. All rights reserved.
//

#import "ZJFunction.h"
#import <UIKit/UIKit.h>
#import "NetInterface.h"
#import "sys/utsname.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>
@implementation ZJFunction
#pragma mark - 设置模式
+ (void)setImageMode:(UIImageView *)iv {
    iv.contentMode = UIViewContentModeScaleAspectFit;
}
+ (void)userLoginOut {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:nil forKey:@"cookie"];
    [user setObject:nil forKey:@"userMsg"];
    [user synchronize];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc postNotificationName:@"userLoginOut" object:nil];
}
+ (BOOL)isDateOut:(NSString *)str {
    if (!str || str.length == 0) {
        return NO;
    }
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSDate *detailDate = [df dateFromString:[str componentsSeparatedByString:@" "][0]];
    NSDate *nowDate = [NSDate date];
    if ([nowDate compare:detailDate] == NSOrderedAscending) {
        return NO;
    }
    return YES;
}

+ (NSString *)fliterImageUrl:(NSString *)str andView:(UIView *)vi {
    int scale_screen = (int)[UIScreen mainScreen].scale;
    if (!str || str.length < 5) return @"";
    NSMutableString *str1 = [[NSMutableString alloc] init];
    NSRange range = [str rangeOfString:@"/"];
    if (range.location == NSNotFound) {
        [str1 appendString:str];
        NSRange range1 = [str1 rangeOfString:@"."];
        [str1 insertString:[NSString stringWithFormat:@"_%d%%C3%%97%d", (int)vi.frame.size.width * scale_screen, (int)vi.frame.size.height * scale_screen] atIndex:range1.location];
        NSString *tem = [NSString stringWithFormat:kImagePath, [str1 copy]];
        return tem;
    }
    else{
        NSArray *arr = [str componentsSeparatedByString:@"/"];
        [str1 appendString:[arr lastObject]];
        NSRange range1 = [str1 rangeOfString:@"."];
        [str1 insertString:[NSString stringWithFormat:@"_%d%%C3%%97%d", (int)vi.frame.size.width * scale_screen, (int)vi.frame.size.height * scale_screen] atIndex:range1.location];
        NSString *tem = [NSString stringWithFormat:kImagePath, [str1 copy]];
        return tem;
    }
//    return nil;
}
#pragma mark - 返回手机型号
//if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
//if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
//if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
//if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
//if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
//if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
//if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
//if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
//if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
//if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
//if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
//if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
//if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
//if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
//if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
//if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
//if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
//NSLog(@"NOTE: Unknown device type: %@", deviceString);
//return deviceString;
+ (NSString *)stringIphoneModel {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}
+ (BOOL)isIosNine {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        return YES;
    }
    return NO;
}
+ (CGRect)autoLabelWidthHeight:(fontAndSize)fas andStr:(NSString *)str andLabel:(UILabel *)la {
    
    NSDictionary *parms = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:fas.fontSize]};
    CGRect rect1 = [str boundingRectWithSize:fas.size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:parms context:nil];
    if (la) {
        la.numberOfLines = 0;
        CGRect temrect = la.frame;
        temrect.size.height = rect1.size.height;
        la.frame = temrect;
        la.text = str;
    }
    return rect1;
}
+ (void)starObvious:(CGFloat)point andBackView:(UIView *)bv andBeforeView:(UIView *)bfv {
    bfv.layer.masksToBounds = YES;
    CGFloat precent = point/5.0;
    CGRect rect = bfv.frame;
    rect.size.width = rect.size.width * precent;
    bfv.frame = rect;
}
#pragma mark - 定时执行
static char sleepTimeKeyChar;
+ (void)sleepSomeTimeToAction:(NSTimeInterval)time andBlock:( void(^)(void) )theblock {
    ZJFunction *zjf = [[ZJFunction alloc] init];
    objc_setAssociatedObject(zjf, &sleepTimeKeyChar, theblock, OBJC_ASSOCIATION_RETAIN);
    [NSTimer scheduledTimerWithTimeInterval:time target:zjf selector:@selector(sleepAction:) userInfo:zjf repeats:NO];
}
- (void)sleepAction:(NSTimer *)timer {
    id zjf = timer.userInfo;
    void(^theblock)(void)  = objc_getAssociatedObject(zjf, &sleepTimeKeyChar);
    theblock();
}
#pragma mark - 按钮倒计时
static char sleepSomeTimeToAction_CountDown_char;
int countDownTime;
- (void)sleepSomeTimeToAction_CountDown:(UILabel *)btn andAllSecond:(NSTimeInterval)time andBlock: ( void(^)(void) )theblock {
    NSArray *arr = @[btn];
    countDownTime = time;
    objc_setAssociatedObject(self, &sleepSomeTimeToAction_CountDown_char, theblock, OBJC_ASSOCIATION_RETAIN);
    self.timer_Function = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(sleepAction1:) userInfo:arr repeats:YES];
}
- (void)sleepAction1:(NSTimer *)timer {
    NSArray *tem = (NSArray *)timer.userInfo;
    UILabel *tembtn = tem[0];
    if (countDownTime == 0) {
        [self stopCountDown];
    }
    else
    {
        countDownTime--;
        tembtn.text = [NSString stringWithFormat:@"%d秒", countDownTime];
    }
}
- (void)stopCountDown {
    [self.timer_Function invalidate];
    void(^theblock)(void)  = objc_getAssociatedObject(self, &sleepSomeTimeToAction_CountDown_char);
    if (!theblock) return;
    theblock();
}
#pragma mark - md5加密
+ (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
    ];
}
#pragma mark - 订单订金整合计算
+ (NSInteger)Calculation_Deposit:(CGFloat)input {
//    input = input*0.3;
//    CGFloat yushu = input - (int)input;
//    int hou = (int)input%100;
//    int add = (hou+yushu > 0 && hou+yushu < 50)?50:100;
//    NSInteger res = (int)input + (add - hou);
    input = input*0.3;
    CGFloat yushu = input - (int)input;
    if (yushu > 0.0) {
        return input+1;
    }
    else {
        return input;
    }
}
#pragma mark - 获取系统参数
+ (id)getProjectParms:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"ZJParms" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    return dict[name];
}
#pragma mark - 毛玻璃效果
+ (UIImage *)mohu:(CGImageRef)cgi {
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *image = [CIImage imageWithCGImage:cgi];
    CIFilter *filter = [CIFilter filterWithName:@"n "];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@5.0f forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return blurImage;
}
+ (void)setBgPic:(NSString *)str andPicView:(UIImageView *)pv {
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = pv.bounds;
    [pv addSubview:effectview];
}
#pragma mark - color转Image , 只用于首页navbar
+ (UIImage *)colorToImageAlpha:(CGFloat)alphaValue color:(UIColor *)col {
    CGRect rect = CGRectMake(0, 0, kWidth, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[col colorWithAlphaComponent:alphaValue] CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, kWidth, 20));
    CGContextSetFillColorWithColor(context, [[col colorWithAlphaComponent:alphaValue] CGColor]);
    CGContextFillRect(context, CGRectMake(0, 20, kWidth, 44));
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
#pragma mark - 按比例计算宽高
+ (CGFloat)Calculation_width_height:(WidthHeightNote)mystruct {
    if (mystruct.width == 0&&mystruct.height == 0) {
        return 0;
    }
    else if (mystruct.width == 0) {
        return mystruct.ratio * mystruct.height;
    }
    else {
        return mystruct.width/mystruct.ratio;
    }
}
#pragma mark - 字典转换成字符串 ->url请求专用
+ (NSString *)dictionaryToString:(NSDictionary *)dict {
    if (dict.allKeys.count == 0) {
        return @"";
    }
    NSMutableString *mustr = [[NSMutableString alloc] initWithString:@""];
    for (NSString *str in dict.allKeys) {
        if ([dict[str] isKindOfClass:[NSString class]]) {
            [mustr appendFormat:@"%@=%@&", str, dict[str]];
        }
        else if ([dict[str] isKindOfClass:[NSNumber class]]) {
            [mustr appendFormat:@"%@=%@&", str, [dict[str] stringValue]];
        }
    }
    if (mustr.length >= 1)
        [mustr deleteCharactersInRange:NSMakeRange(mustr.length-1, 1)];
    return mustr;
}

+ (NSString *)removeWhiteSpace:(NSString *)str {
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (NSString *)zj_timeStampFormat:(id)stamp {
    if ([stamp isKindOfClass:[NSString class]]) {
        NSString * str = stamp;
        if (str.length >= 10) {
            NSTimeInterval _interval2=[[str substringToIndex:10] doubleValue];
            NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
            NSDateFormatter *objDateformat2 = [[NSDateFormatter alloc] init];
            [objDateformat2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            return [objDateformat2 stringFromDate: date2];
        }
    }
    else if ([stamp isKindOfClass:[NSNumber class]]) {
        NSString * str = [stamp stringValue];
        if (str.length >= 10) {
            NSTimeInterval _interval2=[[str substringToIndex:10] doubleValue];
            NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:_interval2];
            NSDateFormatter *objDateformat2 = [[NSDateFormatter alloc] init];
            [objDateformat2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            return [objDateformat2 stringFromDate: date2];
        }
    }
    return nil;
}

static char screenshot_char;
- (void)zj_Screenshot:(UIView *)sender andBlock:( void(^)(NSError *err) )theblock {
    objc_setAssociatedObject(self, &screenshot_char, theblock, OBJC_ASSOCIATION_RETAIN);
    
    UIImage *temimg = [self screenView:sender];
    UIImageWriteToSavedPhotosAlbum(temimg, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
- (UIImage*)screenView:(UIView *)view{
//    CGRect rect = view.frame;
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    [view.layer renderInContext:context];
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return img;
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    //    [self.navigationController.view.layer renderInContext:context]
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    // Was there an error?
    void(^theblock)(NSError *) = objc_getAssociatedObject(self, &screenshot_char);
    objc_setAssociatedObject(self, &screenshot_char, nil, OBJC_ASSOCIATION_RETAIN);
    theblock(error);
}
+ (UIColor *)stringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    unsigned red,green,blue;
    NSRange range;
    range.length = 2;
    range.location = 1;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&red];
    range.location = 3;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&green];
    range.location = 5;
    [[NSScanner scannerWithString:[str substringWithRange:range]] scanHexInt:&blue];
    UIColor *color= [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1];
    return color;
}
@end
