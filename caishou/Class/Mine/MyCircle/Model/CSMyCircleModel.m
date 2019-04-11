//
//  CSMyCircleModel.m
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMyCircleModel.h"

@implementation CSMyCircleModel


-(CGFloat)cellHeight{
    
    CGFloat topHeight = [XBWCSCommonTool sizeWithText:self.introduce font:FONT(14) maxW:SCREEN_WIDTH-SIZE(30)].height;
    
    NSInteger ii = self.photoList.count%3;
    BOOL isUp = ii>0;
    NSInteger row = (self.photoList.count/3) + (isUp ? 1:0);
    CGFloat cellHeight = SIZE(90) * row +SIZE(80)+topHeight;
    return cellHeight;
}

@end
