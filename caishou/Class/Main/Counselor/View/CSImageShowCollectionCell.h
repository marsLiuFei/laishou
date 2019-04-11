//
//  CSImageShowCollectionCell.h
//  caishou
//
//  Created by 刘飞 on 2019/3/21.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSCounselorMienListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSImageShowCollectionCell : UICollectionViewCell
/**
 *  <#define#>
 */
@property(nonatomic, strong)CSCounselorMienListModel *menberModel;
@property(nonatomic, strong)UIImageView *icon;
@end

NS_ASSUME_NONNULL_END
