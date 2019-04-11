//
//  CSActivityOrderListCell.h
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSActivityOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSActivityOrderListCell : UITableViewCell
@property(nonatomic, strong)CSActivityOrderListModel *order;
/**
 *  
 */
@property(nonatomic, copy)void (^btnClickBlock)(BOOL isCancelBtn,NSString *orderID,BOOL isNeedPay);
@end

NS_ASSUME_NONNULL_END
