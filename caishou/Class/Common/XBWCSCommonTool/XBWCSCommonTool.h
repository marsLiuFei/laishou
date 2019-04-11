//
//  XBWCSCommonTool.h
//  wcs
//
//  Created by 刘飞 on 2018/8/13.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XBWCSCommonTool : NSObject



+(instancetype)Instance;
/**
 *  购物车数量
 */
@property (nonatomic, assign) NSInteger shoppingCarNum;


/**
 * 计算文本尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font;
/**
 *  计算限定宽度文本尺寸
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW;
/**
 *时间戳转时间
 */
+ (NSString *)timeStampStringToLocalTime:(NSString *)timeStampString;

+ (BOOL)isNum:(NSString *)checkedNumString;
//比较两个日期的大小
+ (BOOL)compareDate:(NSDate*)stary withDate:(NSDate*)end;
@end
