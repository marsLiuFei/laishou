//
//  PhotoPickCell.h
//  vehicleManagementSystem
//
//  Created by 刘飞 on 2019/3/9.
//  Copyright © 2019年 刘布斯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoPickModel.h"

@class HXPhotoView;

NS_ASSUME_NONNULL_BEGIN

@interface PhotoPickCell : UITableViewCell
@property (strong, nonatomic) PhotoPickModel *model;
/**  照片视图  */
@property (nonatomic, strong) HXPhotoView *photoView;
@property (copy, nonatomic) void (^photoViewChangeHeightBlock)(UITableViewCell *myCell);
@end

NS_ASSUME_NONNULL_END
