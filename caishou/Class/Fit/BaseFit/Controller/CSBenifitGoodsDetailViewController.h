//
//  CSBenifitGoodsDetailViewController.h
//  caishou
//
//  Created by 刘飞 on 2019/2/27.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSBenifitGoodsDetailViewController : CSBaseViewController

/**
 *  拼团ID
 */
@property(nonatomic, strong)NSString *indentCode;
@property(nonatomic, strong)NSString *goodsID;
@property(nonatomic, strong)void (^needRefreshBLock)(void);
@end

NS_ASSUME_NONNULL_END
