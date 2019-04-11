//
//  CSGoodsSpecificationsCell.h
//  caishou
//
//  Created by 刘飞 on 2019/2/28.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSSpellGoodsDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSGoodsSpecificationsCell : UITableViewCell
/**
 *
 **/
@property(nonatomic, strong)void (^addOrCutBtnClickBlock)(BOOL isAdd,NSString *nowCount);
@property(nonatomic, strong)CSSpellGoodsDetailModel *spellModel;
@end

NS_ASSUME_NONNULL_END
