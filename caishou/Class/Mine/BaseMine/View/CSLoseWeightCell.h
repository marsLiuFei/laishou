//
//  CSLoseWeightCell.h
//  caishou
//
//  Created by 刘飞 on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSPersonalInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CSLoseWeightCell : UITableViewCell
/**
 *点击了开始减肥按钮
 **/
@property(nonatomic, copy)void (^loseFatBtnClickBlock)(void );
@property(nonatomic, strong)CSPersonalInfoModel *personalModel;
@end

NS_ASSUME_NONNULL_END
