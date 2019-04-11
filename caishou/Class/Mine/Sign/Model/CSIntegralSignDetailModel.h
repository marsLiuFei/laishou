//
//  CSIntegralSignDetailModel.h
//  caishou
//
//  Created by 刘飞 on 2019/3/18.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSIntegralGoodsModel.h"
#import "CSSignRecordsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSIntegralSignDetailModel : NSObject


/**
 *  今日是否签到
 */
@property(nonatomic, assign)BOOL dayIsSign;
/**
 *
 */
@property(nonatomic, strong)NSString *desc;
/**
 *当前积分
 */
@property(nonatomic, strong)NSString *integral;
/**
 *  商品数组
 */
@property(nonatomic, strong)NSArray *list;
/**
 *
 */
@property(nonatomic, strong)NSString *order;

/**
 *
 */
@property(nonatomic, strong)NSString *page;
/**
 *
 */
@property(nonatomic, strong)NSString *records;
/**
 *
 */
@property(nonatomic, strong)NSString *rows;
/**
 *
 */
@property(nonatomic, strong)NSString *sidx;
/**
 *签到列表
 */
@property(nonatomic, strong)NSArray *signLogList;
/**
 *
 */
@property(nonatomic, strong)NSString *sord;
/**
 *
 */
@property(nonatomic, strong)NSString *table;
/**
 *
 */
@property(nonatomic, strong)NSString *total;
@end

NS_ASSUME_NONNULL_END
