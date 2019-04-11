//
//  PhotoPickModel.h
//  vehicleManagementSystem
//
//  Created by 刘飞 on 2019/3/9.
//  Copyright © 2019年 刘布斯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoPickModel : NSObject

@property (assign, nonatomic) CGFloat cellHeight;
@property (assign, nonatomic) CGFloat photoViewHeight;
@property (copy, nonatomic) NSArray *photoUrls;

@property (assign, nonatomic) BOOL addCustomAssetComplete;
@property (copy, nonatomic) NSArray *customAssetModels;

@property (assign, nonatomic) NSInteger section;


/**
 这个数组里装的是选择照片的模型  HXPhotoModel
 */
@property (strong, nonatomic) NSMutableArray *endSelectedList;

@property (strong, nonatomic) NSMutableArray *endCameraList;
@property (strong, nonatomic) NSMutableArray *endCameraPhotos;
@property (strong, nonatomic) NSMutableArray *endCameraVideos;
@property (strong, nonatomic) NSMutableArray *endSelectedCameraList;
@property (strong, nonatomic) NSMutableArray *endSelectedCameraPhotos;
@property (strong, nonatomic) NSMutableArray *endSelectedCameraVideos;
@property (strong, nonatomic) NSMutableArray *endSelectedPhotos;
@property (strong, nonatomic) NSMutableArray *endSelectedVideos;
//------//
@property (strong, nonatomic) NSMutableArray *iCloudUploadArray;

@end

NS_ASSUME_NONNULL_END
