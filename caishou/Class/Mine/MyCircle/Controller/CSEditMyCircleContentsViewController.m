//
//  CSEditMyCircleContentsViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/3/11.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSEditMyCircleContentsViewController.h"
#import "CSNetwork.h"
#import "CSEditTextCell.h"

@interface CSEditMyCircleContentsViewController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  图片选择器
 */
@property(nonatomic, strong)PhotoPickModel *pickerModel;
@property(nonatomic, strong)UITableView *tableView;
/**
 *  图片链接数组
 */
@property(nonatomic, strong)NSString *fileNameArrayM;
@end

@implementation CSEditMyCircleContentsViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = NO;
}

-(PhotoPickModel *)pickerModel{
    if (!_pickerModel) {
        _pickerModel = [PhotoPickModel new];
    }
    return _pickerModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitleStr:@""];
    self.fileNameArrayM = @"";
    self.view.backgroundColor = WhiteColor;
    [self initTableView];
    
    
    UIButton *submitBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, SIZE(60), SIZE(30)) title:@"提交" titleColor:MainColor font:FONT(15) backgroundColor:ClearColor touchUpInsideEvent:nil];
    [submitBtn addTarget:self action:@selector(submitInfo) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitBtn];
}
//提交信息
- (void )submitInfo{
    [self.view endEditing:YES];
    self.fileNameArrayM = @"";
    
    CSEditTextCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (isEmptyStr(cell.textView.text)) {
        [Dialog toastCenter:@"请输入内容后再提交"];
        return;
    }
    
    
    [[Dialog Instance] showCenterProgressWithLabel:@"提交信息中..."];
    ws(bself);
   
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //提交信息的时候先上传图片，获取到图片链接后，再提交整体信息
        dispatch_group_t group = dispatch_group_create();
        for (int i=0; i<self.pickerModel.endSelectedList.count; i++) {
            HXPhotoModel *model = self.pickerModel.endSelectedList[i];
            UIImage *image = model.thumbPhoto;
            //压缩图片-- 图片小于1000kb才能够上传
            NSData * data = UIImageJPEGRepresentation(image, 1.0);
            CGFloat dataKBytes = data.length/1000.0;
            CGFloat maxQuality = 0.9f;
            CGFloat lastData = dataKBytes;
            while (dataKBytes > 1024 && maxQuality > 0.01f) {
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
            dispatch_group_enter(group);
            [bself upImageData:data CallBack:^(BOOL isSuccess) {
                dispatch_group_leave(group);
            }];
        }
        
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [[Dialog Instance] hideProgress];
            [CSApiManager AddPhotoWithParamDic:@{@"picture":isEmptyStr(bself.fileNameArrayM)?@"":bself.fileNameArrayM,@"introduce":isEmptyStr(cell.textView.text)?@"":cell.textView.text} CallBack:^(id  _Nonnull data) {
                [Dialog toastCenter:BackMessage];
                if (ResultIsCorrect) {
                    if (bself.needRefreshBlock) {
                        bself.needRefreshBlock();
                    }
                    [bself.navigationController popViewControllerAnimated:YES];
                }
            } fail:^(NSError * _Nonnull error) {
                [Dialog toastCenter:@"网络错误"];
            }];
        });
    });
    
    
   
}

- (void )upImageData:(NSData *)imageData CallBack:(void(^)(BOOL isSuccess))callBack{
    ws(bself);
    [CSNetwork uplodatImageWithpath:@"Upload/UploadImg" imgeData:imageData name:@"image" Block:^(id  _Nonnull data, NSError * _Nonnull error) {
        if (!error) {
            callBack(YES);
            MYLog(@"%@",data);
            if (ResultIsCorrect) {
                NSString *fileName = [NSString stringWithFormat:@"%@",data[@"data"][@"fileName"]];
                if (isEmptyStr(bself.fileNameArrayM)) {
                    bself.fileNameArrayM = fileName;
                }else{
                    bself.fileNameArrayM = [NSString stringWithFormat:@"%@;%@",bself.fileNameArrayM,fileName];
                }
            }else{
                 [Dialog toastCenter:BackMessage];
            }
           
        }else {
            callBack(NO);
            [Dialog toastCenter:@"网络错误"];
        }
    }];
    
}



- (void )initTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, NAV_HEIGHT,SCREEN_WIDTH, SCREEN_HEIGHT -NAV_HEIGHT) style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = NORMAL_BGCOLOR;
    _tableView.delegate   = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[PhotoPickCell class] forCellReuseIdentifier:@"PhotoPickCell"];
    [_tableView registerClass:[CSEditTextCell class] forCellReuseIdentifier:@"CSEditTextCell"];
    [self.view addSubview:_tableView];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        self.tableView.estimatedRowHeight = 0;
        self.tableView.estimatedSectionFooterHeight = 0;
        self.tableView.estimatedSectionHeaderHeight = 0;
    }
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.edges.mas_equalTo(self.view.safeAreaInsets);
        }else{
            make.edges.equalTo(self.view);
        }
    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return SIZE(150);
    }
    
    return self.pickerModel.cellHeight;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return SIZE(10);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        PhotoPickCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PhotoPickCell"];
        self.pickerModel.section = indexPath.section;
        cell.model = self.pickerModel;
        HXWeakSelf
        [cell setPhotoViewChangeHeightBlock:^(UITableViewCell *mycell) {
            NSIndexPath *myIndexPath = [weakSelf.tableView indexPathForCell:mycell];
            if (myIndexPath) {
                [weakSelf.tableView reloadRowsAtIndexPaths:@[myIndexPath] withRowAnimation:NO];
            }
        }];
        return cell;
    }
    CSEditTextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CSEditTextCell"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    HXPhoto3DTouchViewController *vc = (HXPhoto3DTouchViewController *)viewControllerToCommit;
    PhotoPickCell *cell = (PhotoPickCell *)[self.tableView cellForRowAtIndexPath:vc.indexPath];
    [cell.photoView jumpPreviewViewControllerWithModel:vc.model];
}
@end
