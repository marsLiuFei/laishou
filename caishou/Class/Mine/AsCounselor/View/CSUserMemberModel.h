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
//  CSUserMemberModel.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/23.
//  Copyright © 2019年 mars. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSUserMemberModel : NSObject

/** bmi */
@property(nonatomic , strong)NSString *bmi;
/** 头像  */
@property(nonatomic , strong)NSString *headImg;
/** 电话 */
@property(nonatomic , strong)NSString *mobile;
/** 名称 */
@property(nonatomic , strong)NSString *name;
/** 体重 */
@property(nonatomic , strong)NSString *weight;

//bmi = "22.77";
//headImg = "http://47.99.100.88:81/file/showimg?filename=20190319232937.png";
//mobile = 18410286181;
//name = 123;
//weight = 54;

+ (CSUserMemberModel *)loadTitleData;

@end

NS_ASSUME_NONNULL_END
