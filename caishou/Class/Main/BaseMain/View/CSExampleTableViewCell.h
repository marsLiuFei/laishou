//
//  CSExampleTableViewCell.h
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSExampleTableViewCell : UITableViewCell
/**
 *  <#define#>
 */
@property(nonatomic, copy)void (^moreBtnClickBlock)(void );
@property(nonatomic, strong)NSString *userNumber;
@end

NS_ASSUME_NONNULL_END
