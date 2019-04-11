//
//  CSHelper.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/2.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSHelper : NSObject
//获取当前时间戳  （以毫秒为单位）
+(NSString *)getNowTimeTimestamp;
//获取一个6位随机数
+(NSString  *)getRandomCunt;
@end

NS_ASSUME_NONNULL_END
