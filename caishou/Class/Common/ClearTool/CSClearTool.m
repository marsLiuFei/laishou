//
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..
//
//
//
//  CSClearTool.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/24.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSClearTool.h"

@implementation CSClearTool

+(NSInteger)getCacheSize {
    //计算结果
    NSInteger totalSize = 0;
    // 构建需要计算大小的文件或文件夹的路径，这里以Documents为例
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    // 1.获得文件夹管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [mgr fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    
    // 3.判断是否为文件夹
    if (dir)//文件夹, 遍历文件夹里面的所有文件
    {
        //这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径),包括子文件夹下面的所有文件及文件夹
        NSArray *subPaths = [mgr subpathsAtPath:path];
        
        //遍历所有子路径
        for (NSString *subPath in subPaths)
        {
            //拼成全路径
            NSString *fullSubPath = [path stringByAppendingPathComponent:subPath];
            
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubPath isDirectory:&dir];
            if (!dir)//子路径是个文件
            {
                //如果是数据库文件，不加入计算
                if ([subPath isEqualToString:@"mySql.sqlite"])
                {
                    continue;
                }
                NSDictionary *attrs = [mgr attributesOfItemAtPath:fullSubPath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        totalSize = totalSize / (1024 * 1024.0);//单位M
    }else//文件
    {
        NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
        totalSize = [attrs[NSFileSize] intValue] / (1024 * 1024.0);//单位M
    }
//     totalSize = totalSize + [SDImageCache sharedImageCache].getSize;
    
    return totalSize;
}
+(void)clearCache:(void(^)(NSError *error))ClearBlock {
//    [[SDImageCache sharedImageCache] clearMemory];
    BOOL clearSuccess = YES;//是否删除成功
    NSError *error = nil;//错误信息
    
    //构建需要删除的文件或文件夹的路径，这里以Documents为例
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString *subPath in subPathArray){
        //如果是数据库文件，不做操作
        if ([subPath isEqualToString:@"mySql.sqlite"]||[subPath containsString:@"Snapshots"]){
            continue;
        }
        
        NSString *filePath = [path stringByAppendingPathComponent:subPath];
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error){
            ClearBlock(error);
            clearSuccess = NO;
        }
    }
    if (clearSuccess) {
         ClearBlock(nil);
    }
}

@end
