//
//  CSBaseViewController.m
//  caishou
//
//  Created by 刘飞 on 2019/2/19.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseViewController.h"
#import "CSBaseWebViewController.h"
#import "CSShareView.h"

@interface CSBaseViewController ()
@end

@implementation CSBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    UIImageView *imgView =  [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    imgView.hidden = YES;
}
- (void)setNavTitleStr:(NSString *)navTitleStr
{
    _navTitleStr = navTitleStr;
    self.navigationItem.title = navTitleStr;
    [self.navigationController.navigationBar setBackIndicatorImage:[UIImage imageNamed:@"back"]];
    [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"back"]];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}


//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
#pragma mark - 设置导航栏
- (void)setNavWithTitle:(NSString *)title isShowBack:(BOOL)isShowBack{
    if (isShowBack) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBtn:)];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
    self.navigationItem.title = title;
}


#pragma mark - 导航栏点击方法
- (void)clickLeftBtn:(UIButton *)leftBtn {
    if (self.navigationController.viewControllers.count == 1)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark -- 分享
- (void )shareWithTitle:(NSString *)title contents:(NSString *)contents imageName:(NSString *)imageName linkUrl:(NSString *)linkUrl{
    ws(wself);
    CSShareView *shareView = [CSShareView new];
    shareView.clickBtnBlock = ^(NSInteger index) {
        //点击了哪种分享功能 0-微信朋友圈 1-微信 2-qq 3-qq空间 4-微博
        switch (index) {
            case 0:
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatTimeLine]) {
                    [wself shareTextToPlatformType:UMSocialPlatformType_WechatTimeLine title:title contents:contents imageName:imageName linkUrl:linkUrl];
                }
                
                break;
            case 1:
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_WechatSession]) {
                    [wself shareTextToPlatformType:UMSocialPlatformType_WechatSession title:title contents:contents imageName:imageName linkUrl:linkUrl];
                }
                break;
            case 2:
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_QQ]) {
                    [wself shareTextToPlatformType:UMSocialPlatformType_QQ title:title contents:contents imageName:imageName linkUrl:linkUrl];
                }
                break;
            case 3:
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Qzone]) {
                    [wself shareTextToPlatformType:UMSocialPlatformType_Qzone title:title contents:contents imageName:imageName linkUrl:linkUrl];
                }
                break;
           
            case 4:
                if ([[UMSocialManager defaultManager] isInstall:UMSocialPlatformType_Sina]) {
                    [wself shareTextToPlatformType:UMSocialPlatformType_Sina title:title contents:contents imageName:imageName linkUrl:linkUrl];
                }
                break;
            default:
                break;
        }
    };
    [shareView showInView:[UIApplication sharedApplication].keyWindow];
}

#pragma mark - share type
//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType title:(NSString *)title contents:(NSString *)contents imageName:(NSString *)imageName linkUrl:(NSString *)linkUrl
{
    
    UIImage *image = [imageName hasPrefix:@"http"]?[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageName]]]:[UIImage imageNamed:imageName];
    
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //    //设置文本
    //    messageObject.text = @"";
    
    if (isEmptyStr(linkUrl)) {
        //创建图片内容对象
        UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
        [shareObject setShareImage:image];
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }else{
        //链接分享
        //        messageObject.text = shareUrl;
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:contents thumImage:image];
        //设置网页地址
        shareObject.webpageUrl = linkUrl;
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
    }
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
        [self alertWithError:error];
    }];
    
    
}
- (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"分享成功"];
        [Dialog toastCenter:result];
    }
    else{
        if ((int)error.code == 2009) {
            result = [NSString stringWithFormat:@"取消分享"];
            [Dialog toastCenter:result];
        }
        else{
            result = [NSString stringWithFormat:@"分享失败"];
            [Dialog toastCenter:result];
        }
    }
}
/**
 *加载url网址
 */
- (void )loadUrl:(NSString *)url{
    CSBaseWebViewController *vc = [CSBaseWebViewController new];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *跳转网页
 **/
- (void )loadHtmlContents:(NSString *)htmlContents {
    CSBaseWebViewController *vc = [CSBaseWebViewController new];
    vc.htmlString = htmlContents;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void )loadHtmlContents:(NSString *)htmlContents isShare:(BOOL)share collect:(BOOL)collect chirleId:(NSString *)chirleId shareContent:(NSString *)shareContent shareIcon:(NSString *)shareIcon {
    CSBaseWebViewController *vc = [[CSBaseWebViewController alloc] init];
    vc.htmlString = htmlContents;
    vc.share = share;
    vc.collect = collect;
    vc.chirleId = chirleId;
    vc.shareContent = shareContent;
    vc.shareIcon = shareIcon;
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  跳转视频播放
 */
- (void )videoPlayerWithUrl:(NSString *)videoUrl placeholdImage:(NSString *)imageUrl{
    CSVideoPlayerCOntroller *vc = [CSVideoPlayerCOntroller new];
    vc.videoUrl = videoUrl;
    vc.imageUrl = imageUrl;
    [self.navigationController pushViewController:vc animated:YES];
}



/**
 *  查看图片大图
 */
-(void)post:(NSInteger)index subviews:(NSArray *)subviews arr:(NSArray *)imageUrl{
    NSMutableArray *photoArrs = [NSMutableArray new];
    
    [imageUrl enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        GKPhoto *photo        = [GKPhoto new];
        if ([obj hasPrefix:@"http"]) {
            photo.url         = [NSURL URLWithString:obj];
        }else {
            photo.image       = [UIImage imageNamed:obj];
        }
        if (idx >= subviews.count) {
            return ;
        }
        photo.sourceImageView = subviews[idx];
        [photoArrs addObject:photo];
    }];
    
    GKPhotoBrowser *browser = [GKPhotoBrowser photoBrowserWithPhotos:photoArrs currentIndex:index];
    //        browser.photos       = photoArrs;
    //        browser.currentIndex = index;
    browser.showStyle    = GKPhotoBrowserShowStyleZoom;
    
    [browser showFromVC:self];
}

@end
