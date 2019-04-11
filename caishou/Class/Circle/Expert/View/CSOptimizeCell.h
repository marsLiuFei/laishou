//
//  CSOptimizeCell.h
//  caishou
//
//  Created by 刘飞 on 2019/2/23.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSSevereUserPageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSOptimizeCell : UICollectionViewCell
/**
 *  
 */
@property(nonatomic, strong)UIImageView *icon;;
@property(nonatomic, strong)CSSevereUserPageModel *severeUserModel;
@end

NS_ASSUME_NONNULL_END
