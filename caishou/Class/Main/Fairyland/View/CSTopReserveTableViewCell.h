//
//  CSTopReserveTableViewCell.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/1.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSCounselorPageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSTopReserveTableViewCell : UITableViewCell
/** model */
@property(nonatomic , strong)CSCounselorPageModel *counselorModel;
/** club */
@property(nonatomic , strong)NSString *clubStr;
/** index */
@property(nonatomic , assign)NSInteger index;


@end

NS_ASSUME_NONNULL_END
