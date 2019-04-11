//
//  CSHotRecommondCell.h
//  caishou
//
//  Created by 刘飞 on 2019/3/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSArticleListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSHotRecommondCell : UITableViewCell
/** 文章数组 */
@property(nonatomic , strong)NSArray<CSArticleListModel *> *articleArray;
@property(nonatomic, copy)void (^collectionViewBlock)(CSArticleListModel *articleModel);



@end

NS_ASSUME_NONNULL_END
