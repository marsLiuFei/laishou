//
//  CSChoosePayModeView.h
//  caishou
//
//  Created by 刘布斯 on 2019/3/17.
//  Copyright © 2019年 mars. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^PickerBlock)(NSString *resultStr);
@interface CSChoosePayModeView : UIView
@property(nonatomic,copy)PickerBlock pickerBlock;
/**
 *  @param view 展示在哪个视图上
 *  @param sourceData 需要展示的数据数组
 *  @param nowShowString 当前展示的数据
 */
- (void)showInView:(UIView *)view sourceDataArray:(NSArray *)sourceData  nowShowString:(NSString *)nowShowString;

@end

NS_ASSUME_NONNULL_END
