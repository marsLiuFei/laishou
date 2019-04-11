//
//  XBWCSCommonTool.m
//  wcs
//
//  Created by 刘飞 on 2018/8/13.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import "XBWCSCommonTool.h"

static XBWCSCommonTool *instance = nil;

@implementation XBWCSCommonTool



+(instancetype)Instance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XBWCSCommonTool alloc] init];
    });
    return instance;
}



/**
 * 计算文本尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font {
    return [text sizeWithAttributes:@{NSFontAttributeName: font}];
}
/**
 *  计算限定宽度文本尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW {
    CGSize size = CGSizeMake(maxW, CGFLOAT_MAX);
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:size options:options attributes:attrs context:nil].size;
}

/**
 *时间戳转时间
 */
+ (NSString *)timeStampStringToLocalTime:(NSString *)timeStampString{
    NSTimeInterval interval    =[timeStampString doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

+ (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}




//比较两个日期的大小
+ (BOOL)compareDate:(NSDate*)stary withDate:(NSDate*)end
{
    NSComparisonResult result = [stary compare: end];
    if (result==NSOrderedSame)
    {
        //相等
        return NO;
    }else if (result == NSOrderedAscending)
    {
        //结束时间大于开始时间
        return YES;
    }else if (result == NSOrderedDescending)
    {
        //结束时间小于开始时间
        return NO;
    }
    return NO;
}
@end
