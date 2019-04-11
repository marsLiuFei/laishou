//
//  CSMyCircleListCell.h
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSMyCircleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSMyCircleListCell : UITableViewCell

@property(nonatomic, strong)CSMyCircleModel *circleModel;
/**
 *
 */
@property(nonatomic, copy)void (^clickImageBlock)(NSInteger index,NSArray *subViews,NSArray *imageArray);
@end

NS_ASSUME_NONNULL_END
