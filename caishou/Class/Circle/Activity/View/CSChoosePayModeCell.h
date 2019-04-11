//
//  CSChoosePayModeCell.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/17.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSChoosePayModeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSChoosePayModeCell : UITableViewCell
/**
 *
 **/
@property(nonatomic, strong)CSChoosePayModeModel *payMode;
/**
 * 选择哪种支付方式
 **/
@property(nonatomic, strong)void (^choosePayModeBlock)(void );
@end

NS_ASSUME_NONNULL_END
