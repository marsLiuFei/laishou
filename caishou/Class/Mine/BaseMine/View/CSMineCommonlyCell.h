//
//  CSMineCommonlyCell.h
//  caishou
//
//  Created by 刘飞 on 2019/2/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSMineCommonlyCell : UITableViewCell
/**
 *
 */
@property(nonatomic, copy)NSString *imageName;
/**
 *
 */
@property(nonatomic, copy)NSString *titleName;

/**
 *  是否设置标题居左
 */
@property(nonatomic, assign)BOOL isSetTitleNameLabelLeft;

/**
 *  展示的文本
 */
@property(nonatomic, copy)NSString *content;
/**
 *  是否隐藏右边的箭头
 */
@property(nonatomic, assign)BOOL hiddenRightImage;
/**
 *  是否选中积分抵扣的按钮
 */
@property(nonatomic, strong)UIButton *selectedBtn;


/**
 *  是否展示选中的按钮
 */
@property(nonatomic, assign)BOOL isShowSelectedBtn;

/**
 *  选择了积分兑换
 */
@property(nonatomic, copy)void (^selectedIntegralBlock)(void);
@end

NS_ASSUME_NONNULL_END
