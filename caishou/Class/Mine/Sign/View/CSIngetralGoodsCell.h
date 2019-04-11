//
//  CSIngetralGoodsCell.h
//  caishou
//
//  Created by 刘飞 on 2019/3/1.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSIntegralGoodsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSIngetralGoodsCell : UICollectionViewCell
@property(nonatomic, strong)CSIntegralGoodsModel *integralGoodsModel;
/**
 *
 */
@property(nonatomic, copy)void (^clickBtnBlock)(NSString *goodsID);
@end

NS_ASSUME_NONNULL_END
