//
//  CSCommonHelper.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/24.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSCommonHelper.h"

static CSCommonHelper *instance = nil;

@implementation CSCommonHelper
+(instancetype)Instance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[CSCommonHelper alloc] init];
    });
    return instance;
}


+ (void)showAlterView:(UIViewController *)controller title:(NSString *)title message:(NSString *)message yesBtnTitle:(NSString *)yesTitle noBtnTitle:(NSString *)noTitle  yesBlock:(void (^)(void))yesAction  noBlock:(void (^)(void))noAction{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:1];
    
    if (![noTitle isEqualToString:@""]) {
        //没有取消按钮
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:noTitle style:1 handler:^(UIAlertAction * _Nonnull action) {
            if (noAction == nil) {
                
            }else{
                noAction();
            }
        }];
        [alertController addAction:actionCancel];
    }
    
    
    
    UIAlertAction *actionOk = [UIAlertAction actionWithTitle:yesTitle style:0 handler:^(UIAlertAction * _Nonnull action) {
        
        if (yesAction  == nil) {
            
        }else{
            yesAction();
        }
        
    }];
    [alertController addAction:actionOk];
    [controller presentViewController:alertController animated:YES completion:nil];
    
}

@end
