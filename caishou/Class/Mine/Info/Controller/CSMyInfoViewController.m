//
//                       .::::.
//                     .::::::::.
//                    :::::::::::
//                 ..:::::::::::'
//              '::::::::::::'
//                .::::::::::
//           '::::::::::::::..
//                ..::::::::::::.
//              ``::::::::::::::::
//               ::::``:::::::::'        .:::.
//              ::::'   ':::::'       .::::::::.
//            .::::'      ::::     .:::::::'::::.
//           .:::'       :::::  .:::::::::' ':::::.
//          .::'        :::::.:::::::::'      ':::::.
//         .::'         ::::::::::::::'         ``::::.
//     ...:::           ::::::::::::'              ``::.
//    ```` ':.          ':::::::::'                  ::::..
//                       '.:::::'                    ':'````..
//
//  CSMyInfoViewController.m
//  caishou
//
//  Created by ༺ོ࿆强ོ࿆ ༻ on 2019/3/3.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMyInfoViewController.h"
#import "CSMyInfoHeaderView.h"
#import "CSInputTableViewCell.h"
#import "CSLikeTableViewCell.h"
#import "CSPulldownTableViewCell.h"
#import "CSInfoModel.h"
#import "LFDatePickView.h"
#import "LFOneLinePickView.h"
#import <Photos/Photos.h>

@interface CSMyInfoViewController ()<UITableViewDelegate , UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UIAlertViewDelegate>
{
    UITableView *_tableView;
    UIImagePickerController *_imagePickerController;
    CSMyInfoHeaderView *_headerView;
}
/** datas */
@property(nonatomic , strong)NSArray *datas;

@end

@implementation CSMyInfoViewController


NSString *kCSInputTableViewCell = @"kCSInputTableViewCell";
NSString *kCSLikeTableViewCell = @"kCSLikeTableViewCell";
NSString *kCSPulldownTableViewCell = @"kCSPulldownTableViewCell";

- (NSArray *)datas {
    if (!_datas) {
        _datas = [CSInfoModel loadDatasWithNormalModel:self.userInfoModel];
    }
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = true;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:WhiteColor};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.title = @"完善信息";
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = false;
 self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor blackColor]};
    self.navigationController.navigationBar.barTintColor = WhiteColor;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

#pragma mark - setupUI
- (void)setupUI {
    self.view.backgroundColor = [UIColor redColor];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[CSInputTableViewCell class] forCellReuseIdentifier:kCSInputTableViewCell];
    [tableView registerClass:[CSLikeTableViewCell class] forCellReuseIdentifier:kCSLikeTableViewCell];
    [tableView registerClass:[CSPulldownTableViewCell class] forCellReuseIdentifier:kCSPulldownTableViewCell];
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(-(NAV_HEIGHT));
        make.left.right.bottom.mas_equalTo(0);
    }];
    if (@available(iOS 11.0,*)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        tableView.estimatedRowHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.estimatedSectionHeaderHeight = 0;
    }
    CSMyInfoHeaderView *headerView = [[CSMyInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(230))];
    headerView.headerImageClick = ^{
        [self chooseImage];
    };
    headerView.imageStr = self.userInfoModel.headImg;
    tableView.tableHeaderView = headerView;
    _tableView = tableView;
    _headerView = headerView;
    [self createImagePicker];
}
-(void)createImagePicker {
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    //跳转动画效果
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
}

- (void)chooseImage {
    UIAlertController *alertCtl =[[UIAlertController alloc]init];
    UIAlertAction *cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *xiangji =[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openCamera];
    }];
    UIAlertAction *xiangce =[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openPhotoLibrary];
    }];
    
    [alertCtl addAction:cancel];
    [alertCtl addAction:xiangji];
    [alertCtl addAction:xiangce];
    
    [self presentViewController:alertCtl animated:YES completion:nil];
}
#pragma mark - openCameraOrPhoto
- (void)openCamera {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        // 判断授权状态
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authStatus == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相机");
            return;
        } else if (authStatus == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请去-> [设置 - 隐私 - 相机 - 项目名称] 打开访问开关" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
            [alertView show];
            return;
        } else if (authStatus == AVAuthorizationStatusAuthorized) {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                //摄像头
                _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:_imagePickerController animated:YES completion:nil];
            }
        } else if (authStatus == AVAuthorizationStatusNotDetermined) { // 用户还没有做出选择
            // 弹框请求用户授权
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                        //摄像头
                        self->_imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                        [self presentViewController:self->_imagePickerController animated:YES completion:nil];
                    }
                }
            }];
        }
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"未检测到您的摄像头, 请在真机上测试" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
- (void)openPhotoLibrary {
    // 判断授权状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted) { // 此应用程序没有被授权访问的照片数据。可能是家长控制权限。
        NSLog(@"因为系统原因, 无法访问相册");
    } else if (status == PHAuthorizationStatusDenied) { // 用户拒绝访问相册
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"请去-> [设置 - 隐私 - 相机 - 项目名称] 打开访问开关" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
        [alertView show];
    } else if (status == PHAuthorizationStatusAuthorized) { // 用户允许访问相册
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            //相册
            _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:_imagePickerController animated:YES completion:nil];
        }
    } else if (status == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        // 弹框请求用户授权
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) { // 用户点击了好
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
                    //相册
                    self->_imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    [self presentViewController:self->_imagePickerController animated:YES completion:nil];
                }
            }
        }];
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage * image = info[@"UIImagePickerControllerEditedImage"];
    
    //压缩图片-- 图片小于1000kb才能够上传
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > 512 && maxQuality > 0.01f) {
        //将图片压缩成1M
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    NSString *loginType = [UDefault getObject:LoginType];
    if ([loginType isEqualToString:@"5"]) {
        //顾问
        [CSApiManager uploadCounselorHeaderImageWithImgeData:data name:@"image" CallBack:^(id  _Nonnull data) {
            if ([data[@"code"] integerValue] == 200) {
                [Dialog toastCenter:@"上传成功"];
                
                [UDefault setObject:@"true" keys:@"updateInfo"];
                [self->_headerView setupHeaderImage:image];
            }
            
        } fail:^(NSError * _Nonnull error) {
            [Dialog toastCenter:@"上传失败"];
        }];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        return ;
        
    }
    
    [CSApiManager uploadHeaderImageWithImgeData:data name:@"image" CallBack:^(id  _Nonnull data) {
        if ([data[@"code"] integerValue] == 200) {
            [Dialog toastCenter:@"上传成功"];
            
            [UDefault setObject:@"true" keys:@"updateInfo"];
            [self->_headerView setupHeaderImage:image];
        }
       
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"上传失败"];
    }];
  
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // 系统是否大于10
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSInfoModel *model = self.datas[indexPath.row];
    if (model.type == MyInfoTypeOther) {
        CSLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSLikeTableViewCell forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    if (model.type == MyInfoTypeSelect) {
        CSPulldownTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSPulldownTableViewCell forIndexPath:indexPath];
        cell.model = model;
        return cell;
    }
    
    CSInputTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSInputTableViewCell forIndexPath:indexPath];
      cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CSInfoModel *model = self.datas[indexPath.row];
    if (model.type == MyInfoTypeSelect) {
        if (indexPath.row == 2) {
            [self creatAlertControllerSheet:model];
            return;
        }
        if (indexPath.row == 3) {
            LFDatePickView *datePcikView = [LFDatePickView new];
            datePcikView.pickerBlock = ^(NSString * _Nonnull resultStr) {
                model.text = resultStr;
                 [self ->_tableView reloadData];
            };
            [datePcikView showInView:[UIApplication sharedApplication].keyWindow];
            return;
        }
        if (indexPath.row == 8) {
            NSArray *showArr = model.subArr;
            LFOneLinePickView *pickView = [LFOneLinePickView new];
            [pickView showInView:[UIApplication sharedApplication].keyWindow sourceDataArray:showArr nowShowString:@""];
            pickView.pickerBlock = ^(NSString * _Nonnull resultStr) {
                model.text = resultStr;
                [self ->_tableView reloadData];
            };
            return;
        }
        
    }
}
-(void)creatAlertControllerSheet:(CSInfoModel *)model {
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"" message:@"请选择您的性别" preferredStyle:UIAlertControllerStyleActionSheet];
    
    // 创建action，这里action1只是方便编写，以后再编程的过程中还是以命名规范为主
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        model.text = @"男";
        [self->_tableView reloadData];
        NSLog(@"点击了男");
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        model.text = @"女";
        [self->_tableView reloadData];
        NSLog(@"点击了女");
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击了取消");
    }];
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action3];
    
    [self presentViewController:actionSheet animated:YES completion:nil];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CSInfoModel *model = self.datas[indexPath.row];
    if (model.type == MyInfoTypeOther) {
        return SIZE(102);
    }
    return SIZE(56);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(5))];
    view.backgroundColor = RGB(238, 238, 238);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SIZE(5);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SIZE(102))];
    bottomView.backgroundColor = [UIColor whiteColor];
    UIButton *button = [ViewCreate createButtonFrame:CGRectMake(0, 0, 0, 0) title:@"提交" titleColor:[UIColor whiteColor] font:MediumFont(16) backgroundColor:RGB(67, 207, 124) touchUpInsideEvent:nil];
    [button addTarget:self action:@selector(commintBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:button];
    button.clipsToBounds = true;
    button.layer.cornerRadius = 10;
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(SIZE(45));
        make.left.offset(SIZE(62));
        make.right.offset(-SIZE(62));
        make.centerY.mas_equalTo(bottomView.mas_centerY);
    }];
    return bottomView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return SIZE(102);
}


#pragma mark - Click
- (void)commintBtnClick:(UIButton *)sender {
    [CSApiManager putMyInfoWithParamDic:[self getParams] CallBack:^(id  _Nonnull data) {
         [Dialog toastCenter:BackMessage];
        
            [UDefault setObject:@"true" keys:@"updateInfo"];
        [self.navigationController popViewControllerAnimated:true];
    } fail:^(NSError * _Nonnull error) {
         [Dialog toastCenter:@"网络错误"];
    }];
}

- (NSDictionary *)getParams{
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:self.datas.count];
    if (isEmptyStr(((CSInfoModel *)self.datas[1]).text)) {
        [Dialog toastCenter:@"手机号不能为空"];
        return nil;
    }
    if (isEmptyStr(((CSInfoModel *)self.datas[4]).text)) {
        [Dialog toastCenter:@"身高不能为空"];
        return nil;
    }
    if (isEmptyStr(((CSInfoModel *)self.datas[5]).text)) {
        [Dialog toastCenter:@"体重不能为空"];
        return nil;
    }
   
    params[@"name"] = ((CSInfoModel *)self.datas[0]).text;
    params[@"mobile"] = ((CSInfoModel *)self.datas[1]).text;
    params[@"sex"] = [((CSInfoModel *)self.datas[2]).text isEqualToString:@"男"]?@1:@2;
    params[@"birthday"] = ((CSInfoModel *)self.datas[3]).text;
    params[@"height"] = ((CSInfoModel *)self.datas[4]).text;
    params[@"weight"] = ((CSInfoModel *)self.datas[5]).text;
    params[@"targetWeight"] = ((CSInfoModel *)self.datas[6]).text;
    params[@"befond"] = ((CSInfoModel *)self.datas[7]).selectTag;
    params[@"industry"] = ((CSInfoModel *)self.datas[8]).text;
    params[@"job"] = ((CSInfoModel *)self.datas[9]).text;
    params[@"chestWai"] = ((CSInfoModel *)self.datas[10]).text;
    params[@"waistWai"] = ((CSInfoModel *)self.datas[11]).text;
    params[@"hipWai"] = ((CSInfoModel *)self.datas[12]).text;
    return params;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
