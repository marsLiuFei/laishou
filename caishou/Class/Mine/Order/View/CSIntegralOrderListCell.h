//
//  CSIntegralOrderListCell.h
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSIntegralOrderListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSIntegralOrderListCell : UITableViewCell
@property(nonatomic, strong)CSIntegralOrderListModel *orderModel;
/**
 *  <#define#>
 */
@property(nonatomic, copy)void (^cancelBtnClickBlock)(NSString  *result);
@end

NS_ASSUME_NONNULL_END
