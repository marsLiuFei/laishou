//
//  CSSignUpPeopleCell.h
//  caishou
//
//  Created by 刘飞 on 2019/2/26.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface CSSignUpPeopleCell : UITableViewCell
/**
 *  <#define#>
 */
@property(nonatomic, strong)NSArray *models;
/**
 *  点击了更多按钮
 */
@property(nonatomic, copy)void (^clickMoreBtnBlock)(void );
@end

NS_ASSUME_NONNULL_END
