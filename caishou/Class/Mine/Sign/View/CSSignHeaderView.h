//
//  CSSignHeaderView.h
//  caishou
//
//  Created by 刘布斯 on 2019/2/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSIntegralSignDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSSignHeaderView : UICollectionReusableView
/**
 *
 */
@property(nonatomic, strong)CSIntegralSignDetailModel *IntegralSignDetailModel;

//签到按钮被点击
@property(nonatomic, copy)void (^signBtnClickBlock)(void );
//活动按钮被点击
@property(nonatomic, copy)void (^activityBtnClickBlock)(void );
//文章按钮被点击
@property(nonatomic, copy)void (^articleBtnClickBlock)(void );
//拼团按钮被点击
@property(nonatomic, copy)void (^groupBtnClickBlock)(void );
//兑换按钮被点击
@property(nonatomic, copy)void (^convertBtnClickBlock)(void );


@end

NS_ASSUME_NONNULL_END
