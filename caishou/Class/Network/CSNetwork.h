//
//  CSNetwork.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/2.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSNetwork : NSObject
+ (void)postWithUrl:(NSString *)URL param:(NSDictionary *)param block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;
+ (void)getWithUrl:(NSString *)URL param:(NSDictionary *)param block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail;

#pragma mark -- 上传图片
+ (void)uplodatImageWithpath:(NSString *)url imgeData:(NSData *)imageData name:(NSString *)name Block:(void (^)(id data, NSError * error))block;
@end

NS_ASSUME_NONNULL_END
