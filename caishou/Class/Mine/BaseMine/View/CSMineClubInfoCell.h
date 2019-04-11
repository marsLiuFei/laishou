//
//  CSMineClubInfoCell.h
//  caishou
//
//  Created by 刘飞 on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPersonalInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSMineClubInfoCell : UITableViewCell
/**
 *  0-绑定 1-预约
 */
@property(nonatomic, copy)void (^clickBtnBlock)(NSInteger index);
@property(nonatomic, strong)CSPersonalInfoModel *personalModel;
@end

NS_ASSUME_NONNULL_END
