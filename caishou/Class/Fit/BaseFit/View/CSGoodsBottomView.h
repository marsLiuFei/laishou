//
//  CSGoodsBottomView.h
//  caishou
//
//  Created by 刘飞 on 2019/2/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSSpellGoodsDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSGoodsBottomView : UIView
/**
 *  是否展示参加拼团的按钮
 */
@property(nonatomic, assign)BOOL isShowJoinBtn;
@property(nonatomic, strong)CSSpellGoodsDetailModel *spellGoodsModel;
/**
 *@params index 0-首页 1-收藏 2-客服
 **/
@property(nonatomic, copy)void (^clickBtkBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
