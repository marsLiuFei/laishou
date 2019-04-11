//
//  CSHomeHeaderView.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/20.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSBannerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSHomeHeaderView : UIView
/**
 *  轮播图模型数组
 */
@property(nonatomic, copy)NSArray <CSBannerModel *>*models;

@property (nonatomic,copy)void(^bannerClick)(CSBannerModel *bannerModel);

@end

NS_ASSUME_NONNULL_END
