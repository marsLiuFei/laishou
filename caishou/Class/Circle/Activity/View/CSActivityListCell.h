//
//  CSActivityListCell.h
//  caishou
//
//  Created by 刘飞 on 2019/2/23.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSActivityListModel.h"
#import "CSArticleListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSActivityListCell : UITableViewCell
/**
 *  莱瘦圈的活动
 */
@property(nonatomic, strong)CSArticleListModel *articleListModel;
/**
 * 热门活动的活动
 */
@property(nonatomic, strong)CSActivityListModel *activityModel;
@end

NS_ASSUME_NONNULL_END
