//
//  CSGroupBookOrderListCell.h
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSGroupBookOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSGroupBookOrderListCell : UITableViewCell
@property(nonatomic, strong)CSGroupBookOrderListModel *orderModel;
/**
 *
 */
@property(nonatomic, copy)void (^btnClickBlock)(BOOL isShare,NSString *goodsID,NSString *goodsName,NSString *orderID);
@end

NS_ASSUME_NONNULL_END
