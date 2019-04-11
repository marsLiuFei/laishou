//
//  CSPKDataTableViewCell.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPKInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSPKDataTableViewCell : UITableViewCell
/** pkInfoModel */
@property(nonatomic , strong)CSPKInfoModel *pkInfoModel;

/** block */
@property(nonatomic , copy)void(^PKClickBlock)(void);

@end

NS_ASSUME_NONNULL_END
