//
//  CSHotHeaderView.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSBannerModel.h"
#import "CSHotOptionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSHotHeaderView : UIView
/**
 *  轮播图模型数组
 */
@property(nonatomic, copy)NSArray <CSBannerModel *>*models;
/** 删选分类数组 */
@property(nonatomic , strong)NSArray<CSHotOptionModel*> *optionsModels;

/** 回调 */
@property(nonatomic , copy)void(^selectOptionBlock)(NSInteger index , CSHotOptionModel *optionModel);
/**
 *
 **/
@property(nonatomic, strong)void (^bannerClick)(NSString *jumpUrl);


@end

NS_ASSUME_NONNULL_END
