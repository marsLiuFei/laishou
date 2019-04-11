//
//  CSNetwork.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/2.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSNetwork.h"
#import "CSHelper.h"
#import "RSA.h"

@implementation CSNetwork
+ (void)postWithUrl:(NSString *)URL param:(NSDictionary *)param block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
    //post请求
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,URL];
    MYLog(@"请求url = %@",url);
    
    //获取时间戳
    NSString *stamp = [CSHelper getNowTimeTimestamp];
    //获取随机数
    NSString *random = [CSHelper getRandomCunt];
    //生成token
    NSString* publicKeyPath = [[NSBundle mainBundle] pathForResource:@"publicKey" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:publicKeyPath];
    NSString *publicKeyStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString* token = [RSA encryptString:[NSString stringWithFormat:@"%@%@",stamp,random] publicKey:publicKeyStr];
    [manager.requestSerializer setValue:stamp forHTTPHeaderField:@"stamp"];
    [manager.requestSerializer setValue:random forHTTPHeaderField:@"random"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    if (ISLOGIN) {
        NSString *auth = [UDefault getObject:AuthKey];
        [manager.requestSerializer setValue:isEmptyStr(auth)?@"":auth forHTTPHeaderField:@"auth"];
    }
    
    
    MYLog(@"---------\nstamp:%@\nrandom:%@\ntoken:%@\n%@\n---------",stamp,random,token,param);
    
    
    
    
    [manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MYLog(@"响应 = %@", responseObject);
        if ([responseObject[@"result"] integerValue] != 1) {
            //            [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
            //            [Dialog toastCenter:responseObject[@"message"]];
        }
        if ([responseObject[@"result"] integerValue] == -1) {
            [UDefault setObject:@"" keys:AuthKey];
        }
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //数据请求失败，返回错误信息原因 error
        MYLog(@"出错 = %@", error);
        //        [SVProgressHUD dismiss];
        fail(error);
    }];
}
+ (void)getWithUrl:(NSString *)URL param:(NSDictionary *)param block:(void (^)(id data))block fail:(void(^)(NSError *errorString))fail
{
    //创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer=[AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    //内容类型
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
    
    
    //获取时间戳
    NSString *stamp = [CSHelper getNowTimeTimestamp];
    //获取随机数
    NSString *random = [CSHelper getRandomCunt];
    //生成token
    NSString* publicKeyPath = [[NSBundle mainBundle] pathForResource:@"publicKey" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:publicKeyPath];
    NSString *publicKeyStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString* token = [RSA encryptString:[NSString stringWithFormat:@"%@%@",stamp,random] publicKey:publicKeyStr];
    [manager.requestSerializer setValue:stamp forHTTPHeaderField:@"stamp"];
    [manager.requestSerializer setValue:random forHTTPHeaderField:@"random"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    if (ISLOGIN) {
        NSString *auth = [UDefault getObject:AuthKey];
        [manager.requestSerializer setValue:isEmptyStr(auth)?@"":auth forHTTPHeaderField:@"auth"];
    }
    
    //get请求
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseUrl,URL];
    MYLog(@"请求url = %@",url);
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        //数据请求的进度
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        MYLog(@"响应 = %@", responseObject);
        if ([responseObject[@"result"] integerValue] != 1) {
            [Dialog toastCenter:responseObject[@"message"]];
        }
        if ([responseObject[@"result"] integerValue] == -1) {
            [UDefault setObject:@"" keys:AuthKey];
        }
        block(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MYLog(@"出错 = %@", error);
        fail(error);
    }];
}









#pragma mark -- 上传图片
+ (void)uplodatImageWithpath:(NSString *)url imgeData:(NSData *)imageData name:(NSString *)name Block:(void (^)(id data, NSError * error))block
{
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    NSMutableDictionary * param = [@{} mutableCopy];
    NSString *URLString = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
    MYLog(@"%@",URLString);
    
    //上传服务器
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/png", nil];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    
    //获取时间戳
    NSString *stamp = [CSHelper getNowTimeTimestamp];
    //获取随机数
    NSString *random = [CSHelper getRandomCunt];
    //生成token
    NSString* publicKeyPath = [[NSBundle mainBundle] pathForResource:@"publicKey" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:publicKeyPath];
    NSString *publicKeyStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString* token = [RSA encryptString:[NSString stringWithFormat:@"%@%@",stamp,random] publicKey:publicKeyStr];
    [manager.requestSerializer setValue:stamp forHTTPHeaderField:@"stamp"];
    [manager.requestSerializer setValue:random forHTTPHeaderField:@"random"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    if (ISLOGIN) {
        NSString *auth = [UDefault getObject:AuthKey];
        [manager.requestSerializer setValue:isEmptyStr(auth)?@"":auth forHTTPHeaderField:@"auth"];
    }
    
    [manager POST:URLString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
//        [formData appendPartWithFileData:imageData name:@"img" fileName:fileName mimeType:@"image/png"];
        [formData appendPartWithFileData:imageData name:@"fileName" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        MYLog(@"%f",uploadProgress.fractionCompleted);
        
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        block(responseObject,nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        block(nil,error);
        
    }];
    
}
@end
