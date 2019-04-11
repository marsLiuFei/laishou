//
//  CSAreaViewController.h
//  caishou
//
//  Created by 刘飞 on 2019/3/18.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseViewController.h"
#import "CSSiteModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSAreaViewController : CSBaseViewController
/**
 *  站点数组
 */
@property(nonatomic, strong)NSArray *siteArray;
/**
 *  选择的分站
 */
@property(nonatomic, copy)void (^selectedSiteModeBlock)(CSSiteModel *siteModel);
@end

NS_ASSUME_NONNULL_END
