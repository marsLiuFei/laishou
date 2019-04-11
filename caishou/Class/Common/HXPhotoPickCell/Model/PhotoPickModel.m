//
//  PhotoPickModel.m
//  vehicleManagementSystem
//
//  Created by 刘飞 on 2019/3/9.
//  Copyright © 2019年 刘布斯. All rights reserved.
//

#import "PhotoPickModel.h"

@implementation PhotoPickModel
- (CGFloat)cellHeight {
    _cellHeight = self.photoViewHeight+SIZE(20);
    return _cellHeight;
}
- (CGFloat)photoViewHeight {
    if (_photoViewHeight == 0) {
        _photoViewHeight = (([UIScreen mainScreen].bounds.size.width - SIZE(30)) - 4 * (4 - 1)) / 4;
    }
    return _photoViewHeight;
}
- (NSMutableArray *)endCameraList {
    if (!_endCameraList) {
        _endCameraList = [NSMutableArray array];
    }
    return _endCameraList;
}
- (NSMutableArray *)endCameraPhotos {
    if (!_endCameraPhotos) {
        _endCameraPhotos = [NSMutableArray array];
    }
    return _endCameraPhotos;
}
- (NSMutableArray *)endCameraVideos {
    if (!_endCameraVideos) {
        _endCameraVideos = [NSMutableArray array];
    }
    return _endCameraVideos;
}
- (NSMutableArray *)endSelectedCameraList {
    if (!_endSelectedCameraList) {
        _endSelectedCameraList = [NSMutableArray array];
    }
    return _endSelectedCameraList;
}
- (NSMutableArray *)endSelectedCameraPhotos {
    if (!_endSelectedCameraPhotos) {
        _endSelectedCameraPhotos = [NSMutableArray array];
    }
    return _endSelectedCameraPhotos;
}
- (NSMutableArray *)endSelectedCameraVideos {
    if (!_endSelectedCameraVideos) {
        _endSelectedCameraVideos = [NSMutableArray array];
    }
    return _endSelectedCameraVideos;
}
- (NSMutableArray *)endSelectedList {
    if (!_endSelectedList) {
        _endSelectedList = [NSMutableArray array];
    }
    return _endSelectedList;
}
- (NSMutableArray *)endSelectedPhotos {
    if (!_endSelectedPhotos) {
        _endSelectedPhotos = [NSMutableArray array];
    }
    return _endSelectedPhotos;
}
- (NSMutableArray *)endSelectedVideos {
    if (!_endSelectedVideos) {
        _endSelectedVideos = [NSMutableArray array];
    }
    return _endSelectedVideos;
}
- (NSMutableArray *)iCloudUploadArray {
    if (!_iCloudUploadArray) {
        _iCloudUploadArray = [NSMutableArray array];
    }
    return _iCloudUploadArray;
}
@end
