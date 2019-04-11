//
//  CSCommonHelper.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/24.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSBannerModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSCommonHelper : NSObject

+(instancetype)Instance;
/**
 *  俱乐部
 **/
@property(nonatomic, strong)CSBannerModel *ClubPagePosterPoster;
/**
 *  顾问
 **/
@property(nonatomic, strong)CSBannerModel *CounselorPagePosterModel;
/**
 *  活动模型
 **/
@property(nonatomic, strong)CSBannerModel *ActivityPosterModel;
/**
 *  拼团
 **/
@property(nonatomic, strong)CSBannerModel *FitPosterModel;
+ (void)showAlterView:(UIViewController *)controller title:(NSString *)title message:(NSString *)message yesBtnTitle:(NSString *)yesTitle noBtnTitle:(NSString *)noTitle  yesBlock:(void (^)(void))yesAction  noBlock:(void (^)(void))noAction;
@end

NS_ASSUME_NONNULL_END
