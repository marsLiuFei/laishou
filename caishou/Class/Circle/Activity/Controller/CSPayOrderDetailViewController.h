//
//  CSPayOrderDetailViewController.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/15.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseViewController.h"
#import "CSActivityDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSPayOrderDetailViewController : CSBaseViewController
/**
 *  从订单页面进入且需要支付
 */
@property(nonatomic, assign)BOOL isNeedPay;
@property(nonatomic, strong)CSActivityDetailModel *activityDetailModel;
/**
 *  订单ID
 */
@property(nonatomic, strong)NSString *orderID;

@end

NS_ASSUME_NONNULL_END
