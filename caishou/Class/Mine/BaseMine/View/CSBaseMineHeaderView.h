//
//  CSBaseMineHeaderView.h
//  caishou
//
//  Created by 刘飞 on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPersonalInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSBaseMineHeaderView : UIView

/**
 *  是不是顾问，是顾问的话隐藏订单和收藏按钮
 */
@property(nonatomic, assign)BOOL isCounlor;

/** infoBtnClick */
@property(nonatomic , copy)void (^InfoBlock)(void);
/** orderBtnClick */
@property(nonatomic , copy)void (^OrderBlock)(void);

/**
 *  <#define#>
 */
@property(nonatomic, strong)CSPersonalInfoModel *personalModel;
/**
 *  BtnClick
 *  0-订单 1-发表 2-收藏 3-我的成绩 4-我的圈子 5-我的俱乐部 6-我的管家服务
 */
@property(nonatomic , copy)void (^otherBtnClickBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
