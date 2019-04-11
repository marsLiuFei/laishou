//
//  CSHomeSessionHeaderView.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/21.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSHomeSessionHeaderModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSHomeSessionHeaderView : UITableViewHeaderFooterView
/** model */
@property(nonatomic , strong)CSHomeSessionHeaderModel *headerModel;

/**
 *  <#define#>
 */
@property(nonatomic, copy)void (^moreBtnClickBlock)(void );

@end

NS_ASSUME_NONNULL_END
