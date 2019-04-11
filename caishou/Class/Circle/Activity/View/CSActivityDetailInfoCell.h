//
//  CSActivityDetailInfoCell.h
//  caishou
//
//  Created by 刘飞 on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSActivityDetailInfoCell : UITableViewCell
/**
 *  内容区域颜色
 */
@property(nonatomic, strong)UIColor *contentColor;
- (void )setIconWithName:(NSString *)iconName content:(NSString *)content isHiddenRightIcon:(BOOL )hidden;
/**
 *  更改右边颜色
 */
@property(nonatomic, strong)NSString *rightIcon;
@end

NS_ASSUME_NONNULL_END
