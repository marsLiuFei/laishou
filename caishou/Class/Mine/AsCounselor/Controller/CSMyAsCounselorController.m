//
//  CSMyAsCounselorController.m
//  caishou
//
//  Created by 刘飞 on 2019/3/22.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSMyAsCounselorController.h"

#import "CSCounselorDetailModel.h"

#import "CSCounselorDetailHeaderView.h"
#import "CSExhibitionTableViewCell.h"

#import "CSOptimizeNewsCell.h"
#import "CSCounselorSearchView.h"
#import "CSCreateQRCodeView.h"
#import "CSCounselorTitleTableViewCell.h"
#import "CSCounselorMembersTableViewCell.h"

#import "CSUserMemberModel.h"

@interface CSMyAsCounselorController ()<UITableViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITableViewDataSource>
{
    UITableView *_tableView;
    UIImagePickerController *_imagePickerController;
}
@property(nonatomic, strong)CSCounselorDetailHeaderView *headerView;
@property(nonatomic, strong)CSCounselorDetailModel *counselorModel;

@end

@implementation CSMyAsCounselorController


NSString *kCSCounselorTitleTableViewCell = @"kCSCounselorTitleTableViewCell";
NSString *kCSCounselorMembersTableViewCell = @"kCSCounselorMembersTableViewCell";

-(CSCounselorDetailModel *)counselorModel{
    if (!_counselorModel) {
        _counselorModel = [CSCounselorDetailModel new];
    }
    return _counselorModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setupNavView];
    [self loadData];
}

#pragma mark - setupUI
- (void)setupUI {
    [self setNavTitleStr:@""];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupTableView];
    [self setupHeaderView];
    [self createImagePicker];
}
- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kTopHeight) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [tableView registerClass:[CSExhibitionTableViewCell class] forCellReuseIdentifier:@"CSExhibitionTableViewCell"];
    [tableView registerClass:[CSOptimizeNewsCell class] forCellReuseIdentifier:@"CSOptimizeNewsCell"];
    [tableView registerClass:[CSCounselorTitleTableViewCell class] forCellReuseIdentifier:kCSCounselorTitleTableViewCell];
    [tableView registerClass:[CSCounselorMembersTableViewCell class] forCellReuseIdentifier:kCSCounselorMembersTableViewCell];
    [self.view addSubview:tableView];
    _tableView = tableView;
}
- (void) setupHeaderView{
    CSCounselorDetailHeaderView *headerView =   [[CSCounselorDetailHeaderView alloc] init];
    headerView.edit = true;
    self.headerView  = headerView;
    headerView.editIntroBlock = ^(NSString * _Nonnull editStr) {
        [CSApiManager updateIntroduceWithParamDic:@{@"introduce":editStr} CallBack:^(id  _Nonnull data) {
            [Dialog toastCenter:BackMessage];
        } fail:^(NSError * _Nonnull error) {
            [Dialog toastCenter:@"网络错误"];
        }];
    };
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 220);
    _tableView.tableHeaderView = self.headerView;
}
-(void)createImagePicker {
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    //跳转动画效果
    _imagePickerController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    _imagePickerController.allowsEditing = YES;
}

#pragma mark - setupNavView
- (void)setupNavView {
    ws(bself);
    UIButton *codeBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, SIZE(25), SIZE(25)) normalBackgroundImage:@"qrCode" selectedBackgroundImage:@"qrCode" touchUpInsideEvent:nil];
    [codeBtn addTarget:self action:@selector(codeClick) forControlEvents:UIControlEventTouchUpInside];
    codeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *codeItem = [[UIBarButtonItem alloc] initWithCustomView:codeBtn];
    self.navigationItem.rightBarButtonItem =  codeItem;
    CSCounselorSearchView *searchView = [[CSCounselorSearchView alloc] initWithFrame:CGRectMake(0, 0, 180, kNavBarHeight+SafeAreaHeight)];
    searchView.chooseSiteBtnClickBlock = ^{
        if (!ISLOGIN) {
            [bself.navigationController pushViewController:[NSClassFromString(@"CSLoginViewController") new] animated:YES];
            return;
        }
        [bself.navigationController pushViewController:[NSClassFromString(@"CSHomeSearchViewController") new] animated:YES];
            
    };
    self.navigationItem.titleView = searchView;
    
}
#pragma mark - loadData
- (void )loadData{
    ws(bself);
    [CSApiManager counselorDetailsWithParamDic:@{@"substationId":[UDefault getObject:NowSiteId],@"id":isEmptyStr(self.counselorId)?@"":self.counselorId} CallBack:^(id  _Nonnull data) {
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            bself.counselorModel = [CSCounselorDetailModel mj_objectWithKeyValues:data[@"data"]];
            if (bself.counselorModel.mienList.count == 0 ) {
                bself.counselorModel.mienList = @[[CSCounselorMienListModel addMoreModel]];
            }else {
                NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:bself.counselorModel.mienList.count +1];
                [dataArr addObjectsFromArray:bself.counselorModel.mienList];
                [dataArr insertObject:[CSCounselorMienListModel addMoreModel] atIndex:bself.counselorModel.mienList.count];
                bself.counselorModel.mienList = dataArr.copy;
            }
            NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:bself.counselorModel.userList.count +1];
            [dataArr addObjectsFromArray:bself.counselorModel.userList];
            [dataArr insertObject:[CSUserMemberModel loadTitleData] atIndex:0];
            bself.counselorModel.userList = dataArr.copy;
            bself.headerView.counselorDetailModel = bself.counselorModel;
            [self->_tableView reloadData];
        }
        else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}
#pragma mark - Action
- (void)codeClick {
    CSCreateQRCodeView *codeView = [[CSCreateQRCodeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    codeView.headImageUrl = self.counselorModel.headImg;
    codeView.codeStr = self.counselorId;
    [[UIApplication sharedApplication].keyWindow addSubview:codeView];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
       return  self.counselorModel.articleList.count;
    }
    return self.counselorModel.userList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        ws(bself);
        CSExhibitionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSExhibitionTableViewCell" forIndexPath:indexPath];
        cell.sourceData = self.counselorModel.mienList;
        cell.clickImageBlock = ^(NSInteger index, NSArray * _Nonnull subViews, NSArray * _Nonnull imageArray) {
            if (index == bself.counselorModel.mienList.count -1) {
                [self uploadImage];
            }
            [bself post:index subviews:subViews arr:imageArray];
        };
        return cell;
    }
    if (indexPath.section == 2) {
        CSOptimizeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSOptimizeNewsCell" forIndexPath:indexPath];
        cell.articleModel = self.counselorModel.articleList[indexPath.row];
        return cell;
    }
    if (indexPath.row == 0) {
        CSCounselorTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSCounselorTitleTableViewCell forIndexPath:indexPath];
        return cell;
    }
    CSCounselorMembersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCSCounselorMembersTableViewCell forIndexPath:indexPath];
    cell.userModel = self.counselorModel.userList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {

    }
    else{
        CSArticleListModel *articleModel = self.counselorModel.articleList[indexPath.row];
        if (articleModel.isVideo) {
            [self videoPlayerWithUrl:articleModel.articleContent  placeholdImage:articleModel.img];
        }else{
            [self loadHtmlContents:articleModel.articleContent isShare:true collect:true chirleId:articleModel.ID shareContent:articleModel.articleTitle shareIcon:articleModel.img];
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        NSInteger ii = self.counselorModel.mienList.count%4;
        BOOL isUp = ii>0;
        NSInteger row = (self.counselorModel.mienList.count/4) + (isUp ? 1:0);
        CGFloat width = (SCREEN_WIDTH - SIZE(30))/4.f;

        CGFloat height = width*row;
        return height;
    }
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return SIZE(21);
        }
        return SIZE(60);
    }
    return SIZE(120);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.viewWidth, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titlLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 30)];
    titlLabel.text = @"我的会员";
    if (section == 1) {
       titlLabel.text = @"风采展示";
    }else if (section == 2) {
      titlLabel.text = @"发布的文章";
//        [self addPublishedOption:headerView];
        
    }
    titlLabel.font =  [UIFont fontWithName:@"PingFangSC-Medium" size: 16];
    titlLabel.textColor = RGB(67, 207, 124);
    [headerView addSubview:titlLabel];
    return headerView;
}
- (void)addPublishedOption:(UIView *)superView {
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -75 - 30, 0, 75, 30)];
    hintLabel.text = @"立即发表";
    hintLabel.font =  [UIFont fontWithName:@"PingFangSC-Medium" size: 16];
    hintLabel.textColor = RGB(67, 207, 124);
    [superView addSubview:hintLabel];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(superView.viewWidth - 30, 7, 15, 15)];
    imageView.image = [UIImage imageNamed:@"edit"];
    [superView addSubview:imageView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(_tableView.viewWidth -75 - 30, 0, 105, 30);
    [superView addSubview:button];
    [button addTarget:self action:@selector(publishedArticle) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)publishedArticle {
    NSLog(@"12345678");
}
#pragma mark - 上传风采图片
- (void)uploadImage {
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

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSURL *url  = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:url];
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
    
    [CSApiManager addMienImageWithImgeData:data name:@"image" CallBack:^(id  _Nonnull data) {
        if ([data[@"code"] integerValue] == 200) {
            [Dialog toastCenter:@"上传成功"];
            [self loadData];
        }else {
             [Dialog toastCenter:BackMessage];
        }
        
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"上传失败"];
    }];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
