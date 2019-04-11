//
//  XBWCSGoodsDetailContentInfoCell.h
//  wcs
//
//  Created by 刘飞 on 2018/8/2.
//  Copyright © 2018年 ahxb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReloadBlock)(void);
@interface XBWCSGoodsDetailContentInfoCell : UITableViewCell

@property(nonatomic,copy)NSString *htmlString;
@property(nonatomic,copy)ReloadBlock reloadBlock;
+(CGFloat)cellHeight;

@end
