//
//  CSMyCollectModel.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/10.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSMyCollectModel : NSObject
@property(nonatomic, strong)NSString *ID;
@property(nonatomic, strong)NSString *creater;
@property(nonatomic, strong)NSString *simple;
@property(nonatomic, strong)NSString *img;

@property(nonatomic, strong)NSString *createTime;
@property(nonatomic, strong)NSString *likeNumber;
@property(nonatomic, strong)NSString *collectNumber;
@property(nonatomic, strong)NSString *shareNumber;
@property(nonatomic, strong)NSString *articleTitle;
/** 内容 */
@property(nonatomic , strong)NSString *articleContent;

@end

NS_ASSUME_NONNULL_END

/**
 
 {
 "id": "b68dcd2e-232d-434f-993d-d80442bf31ec",
 "creater": "5607a4eb-ca72-42f4-a3dc-005956d95cf1",
 "createTime": "2019-03-02T16:40:03.273",
 "likeNumber": 0,
 "collectNumber": 0,
 "shareNumber": 0,
 "articleTitle": "好人"
 }
 
 */
