//
//  ProvinceArrayModel.h
//  ShoppingMall
//
//  Created by ahxb on 2018/6/5.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceArrayModel : NSObject

+(instancetype)sharedProvinceArrayModel;

@property(nonatomic,strong)NSMutableArray * provinceArray;

@end
