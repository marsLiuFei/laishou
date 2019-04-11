//
//  CSPayDetailInfoCell.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/16.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSActivityDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSPayDetailInfoCell : UITableViewCell
/**
 * 活动信息
 **/
@property(nonatomic, strong)CSActivityDetailModel *activityDetailModel;
/**
 * 支付方式
 **/
@property(nonatomic, strong)NSString *payMode;
/**
 *选择支付方式按钮被点击
 **/
@property(nonatomic, strong)void (^choosePayModeBlock)(void );
@end

NS_ASSUME_NONNULL_END
