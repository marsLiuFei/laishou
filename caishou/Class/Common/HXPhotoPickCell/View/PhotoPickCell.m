//
//  PhotoPickCell.m
//  vehicleManagementSystem
//
//  Created by 刘飞 on 2019/3/9.
//  Copyright © 2019年 刘布斯. All rights reserved.
//

#import "PhotoPickCell.h"

@interface PhotoPickCell ()<HXPhotoViewDelegate>
/**  照片管理  */
@property (nonatomic, strong) HXPhotoManager *manager;
@end

@implementation PhotoPickCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.photoView];
}
- (void)setModel:(PhotoPickModel *)model {
    _model = model;
    
    [self.manager changeAfterCameraArray:model.endCameraList];
    [self.manager changeAfterCameraPhotoArray:model.endCameraPhotos];
    [self.manager changeAfterCameraVideoArray:model.endCameraVideos];
    [self.manager changeAfterSelectedCameraArray:model.endSelectedCameraList];
    [self.manager changeAfterSelectedCameraPhotoArray:model.endSelectedCameraPhotos];
    [self.manager changeAfterSelectedCameraVideoArray:model.endSelectedCameraVideos];
    [self.manager changeAfterSelectedArray:model.endSelectedList];
    [self.manager changeAfterSelectedPhotoArray:model.endSelectedPhotos];
    [self.manager changeAfterSelectedVideoArray:model.endSelectedVideos];
    [self.manager changeICloudUploadArray:model.iCloudUploadArray];
    
    // 这些操作需要放在manager赋值的后面，不然会出现重用..
    if (model.section == 0) {
        self.manager.configuration.albumShowMode = HXPhotoAlbumShowModePopup;
        self.photoView.previewStyle = HXPhotoViewPreViewShowStyleDark;
        self.photoView.collectionView.editEnabled = NO;
        self.photoView.hideDeleteButton = YES;
        self.photoView.showAddCell = NO;
        if (!model.addCustomAssetComplete && model.customAssetModels.count) {
            [self.manager addCustomAssetModel:model.customAssetModels];
            model.addCustomAssetComplete = YES;
        }
    }else {
        self.manager.configuration.albumShowMode = HXPhotoAlbumShowModeDefault;
        self.photoView.previewStyle = HXPhotoViewPreViewShowStyleDefault;
        self.photoView.collectionView.editEnabled = YES;
        self.photoView.hideDeleteButton = NO;
        self.photoView.showAddCell = YES;
    }
    
    [self.photoView refreshView];
}
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    if (photoView == self.photoView) {
        self.model.endCameraList = self.manager.afterCameraArray.mutableCopy;
        self.model.endCameraPhotos = self.manager.afterCameraPhotoArray.mutableCopy;
        self.model.endCameraVideos = self.manager.afterCameraVideoArray.mutableCopy;
        self.model.endSelectedCameraList = self.manager.afterSelectedCameraArray.mutableCopy;
        self.model.endSelectedCameraPhotos = self.manager.afterSelectedCameraPhotoArray.mutableCopy;
        self.model.endSelectedCameraVideos = self.manager.afterSelectedCameraVideoArray.mutableCopy;
        self.model.endSelectedList = self.manager.afterSelectedArray.mutableCopy;
        self.model.endSelectedPhotos = self.manager.afterSelectedPhotoArray.mutableCopy;
        self.model.endSelectedVideos = self.manager.afterSelectedVideoArray.mutableCopy;
        self.model.iCloudUploadArray = self.manager.afterICloudUploadArray.mutableCopy;
    }
}
- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    if (photoView != self.photoView) {
        return;
    }
    if (frame.size.height == self.model.photoViewHeight) {
        return;
    }
    self.model.photoViewHeight = frame.size.height;
    if (self.photoViewChangeHeightBlock) {
        self.photoViewChangeHeightBlock(self);
    }
}
- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
        _manager.configuration.photoMaxNum = 9;
    }
    return _manager;
}
- (HXPhotoView *)photoView {
    if (!_photoView) {
        _photoView = [[HXPhotoView alloc] initWithFrame:CGRectMake(SIZE(15), SIZE(10), [UIScreen mainScreen].bounds.size.width - SIZE(30), 0) manager:self.manager];
        _photoView.backgroundColor = [UIColor whiteColor];
        _photoView.lineCount = 4;
        _photoView.spacing = SIZE(10);
        _photoView.delegate = self;
    }
    return _photoView;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
