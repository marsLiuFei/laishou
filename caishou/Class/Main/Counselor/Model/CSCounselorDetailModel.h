//
//  CSCounselorDetailModel.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/10.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSArticleListModel.h"
#import "CSCounselorMienListModel.h"
#import "CSUserMemberModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSCounselorDetailModel : NSObject

/**
 *
 **/
@property(nonatomic, strong)NSArray *articleList;
@property(nonatomic, strong)NSString *clubId;
@property(nonatomic, strong)NSString *createTime;
@property(nonatomic, strong)NSString *creater;
@property(nonatomic, strong)NSString *headImg;
@property(nonatomic, strong)NSString *ID;
@property(nonatomic, strong)NSString *introduce;
@property(nonatomic, strong)NSString *isRecommend;
@property(nonatomic, strong)NSString *label;
@property(nonatomic, strong)NSString *loginId;
/** height */
@property(nonatomic , assign)CGFloat height;
/**
 *风采展示
 */
@property(nonatomic, strong)NSArray *mienList;
/** 我的会员 */
@property(nonatomic, strong)NSArray *userList;
@property(nonatomic, strong)NSString *mobile;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSString *recommendTime;
@property(nonatomic, strong)NSString *score;
@property(nonatomic, strong)NSString *states;
@property(nonatomic, strong)NSString *substationId;
@property(nonatomic, strong)NSString *userNumber;
/** 俱乐部名称 */
@property(nonatomic , strong)NSString *clubName;

@end

NS_ASSUME_NONNULL_END

/**
 
 {
 "id": "0ee5554e-0cfc-4669-91c5-e47d9283321c",
 "clubId": "c919de8b-6bfd-43b1-bb67-1e810a74c0f7",
 "loginId": "0785166c-fb6f-4f90-801f-f8dba372bc07",
 "name": "张杰",
 "mobile": "15556728278",
 "label": "1,23,34,5",
 "states": 0,
 "creater": "0785166c-fb6f-4f90-801f-f8dba372bc07",
 "createTime": "2019-02-28T14:04:55.87",
 "isRecommend": 0,
 "recommendTime": null,
 "substationId": "9784e38e-2b9f-4b04-8326-1f1eadb00837",
 "userNumber": 1000,
 "score": 5,
 "headImg": "http://47.94.172.208:20192/file/showimg?filename=201903061111.jpg"
 }
 
 */
