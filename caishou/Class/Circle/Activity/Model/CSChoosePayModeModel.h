//
//  CSChoosePayModeModel.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/17.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSChoosePayModeModel : NSObject
/**
 *
 **/
@property(nonatomic, strong)NSString *name;
/**
 *
 **/
@property(nonatomic, strong)NSString *iconName;
/**
 *
 **/
@property(nonatomic, strong)NSString *des;
/**
 *
 **/
@property(nonatomic, assign)BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
