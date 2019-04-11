//
//  CSFitScannigMenuCell.h
//  caishou
//
//  Created by 刘飞 on 2019/2/27.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CSFitScannigMenuCell : UITableViewCell
/**
 *  
 */
@property(nonatomic, copy)void (^clickBlock)(NSInteger index);
@property(nonatomic, strong)NSArray *infoDicArray;
@end

NS_ASSUME_NONNULL_END
