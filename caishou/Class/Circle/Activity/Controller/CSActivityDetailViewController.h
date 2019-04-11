//
//  CSActivityDetailViewController.h
//  caishou
//
//  Created by 刘飞 on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSActivityDetailViewController : CSBaseViewController
/**
 *  从订单页面进入，是否需要付款
 */
@property(nonatomic, assign)BOOL isNeedPay;
/**
 *  活动ID
 */
@property(nonatomic, strong)NSString *activityID;
/**
 *活动图片地址
 **/
@property(nonatomic, strong)NSString *activityImageUrl;
@property(nonatomic, strong)NSString *orderID;
@end

NS_ASSUME_NONNULL_END
