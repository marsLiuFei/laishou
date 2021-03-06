//
//  CSShareDatePickView.h
//  caishou
//
//  Created by 刘飞 on 2019/3/25.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PickerBlock)(NSString *resultStr);
@interface CSShareDatePickView : UIView
@property(nonatomic,copy)PickerBlock pickerBlock;
/**
 *  @param view 展示在哪个视图上
 */
- (void)showInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
