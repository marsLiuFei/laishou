//
//  CSOptimizeNewsCell.h
//  caishou
//
//  Created by 刘飞 on 2019/2/23.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSArticleListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSOptimizeNewsCell : UITableViewCell
/**
 *  <#define#>
 */
@property(nonatomic, strong)CSArticleListModel *articleModel;
@end

NS_ASSUME_NONNULL_END