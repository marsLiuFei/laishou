//
//  CSCounselorListModel.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/5.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSCounselorListModel : NSObject

@property(nonatomic, strong)NSString *headImg;
/**
 *--顾问id
 */
@property(nonatomic, strong)NSString *ID;
/**
 *--顾问姓名
 */
@property(nonatomic, strong)NSString *name;
/**
 *--顾问手机号
 */
@property(nonatomic, strong)NSString *mobile;
/**
 *--顾问标签
 */
@property(nonatomic, strong)NSString *label;
/**
 *--会员数
 */
@property(nonatomic, strong)NSString *userNumber;
/**
 *--评分
 */
@property(nonatomic, strong)NSString *score;
/**
 *--所在俱乐部名称
 */
@property(nonatomic, strong)NSString *clubName;
@end

NS_ASSUME_NONNULL_END
/**
 
 {
 "id": "394d0c0b-78c4-483c-aab2-74b047565409", --顾问id
 "name": "张三", --顾问姓名
 "mobile": "12331111", --顾问手机号
 "label": "11,112,3，2，3", --顾问标签
 "userNumber": 1000, --会员数
 "score": 5, --评分
 "clubName": "天上人间" --所在俱乐部名称
 }
 
 */
