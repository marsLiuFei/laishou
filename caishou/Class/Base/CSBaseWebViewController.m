//
//  CSBaseWebViewController.m
//  caishou
//
//  Created by 刘布斯 on 2019/3/18.
//  Copyright © 2019年 mars. All rights reserved.
//

#import "CSBaseWebViewController.h"
#import <WebKit/WebKit.h>
#import "CSShareView.h"

@interface CSBaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>
@property(nonatomic,strong)WKWebView * singWebView;
@property(nonatomic,strong)CALayer * progresslayer;
/** collectBtn */
@property(nonatomic , strong)UIButton *collectBtn;


@end

@implementation CSBaseWebViewController

- (CALayer *)progresslayer
{
    if (!_progresslayer) {
        UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 3)];
        progress.backgroundColor = [UIColor clearColor];
        [self.view addSubview:progress];
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 0, 3);
        layer.backgroundColor = MainColor.CGColor;
        [progress.layer addSublayer:layer];
        self.progresslayer = layer;
    }
    return _progresslayer;
}

- (WKWebView *)singWebView
{
    if (!_singWebView) {
        //初始化一个WKWebViewConfiguration对象
        WKWebViewConfiguration *config = [WKWebViewConfiguration new];
        //        //初始化偏好设置属性：preferences
        config.preferences = [WKPreferences new];
        //是否支持JavaScript
        config.preferences.javaScriptEnabled = YES;
        //不通过用户交互，是否可以打开窗口
        config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
        NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width,inital-scale=1.0,maximum-scale=1.0,user-scalable=no'); document.getElementsByTagName('head')[0].appendChild(meta);";
        
        WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        WKUserContentController *wkUController = [[WKUserContentController alloc] init];
        [wkUController addUserScript:wkUScript];
        
        config.userContentController = wkUController;
        _singWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT) configuration:config];
        _singWebView.UIDelegate = self;
        _singWebView.navigationDelegate = self;
        //WKWebView有一个属性estimatedProgress，就是当前网页加载的进度，所以首先监听这个属性
        [_singWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
    }
    return _singWebView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.singWebView];
    [self.singWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
  
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupRightNav];
}

- (void)setupRightNav {
    self.collectBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, SIZE(25), SIZE(25)) normalBackgroundImage:@"benifit_collect" selectedBackgroundImage:@"benifit_collected" touchUpInsideEvent:nil];
    [self.collectBtn addTarget:self action:@selector(collectArticle:) forControlEvents:UIControlEventTouchUpInside];
    self.collectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc] initWithCustomView:self.collectBtn];
    self.collectBtn.selected = NO;

    UIButton *shareBtn = [ViewCreate createButtonFrame:CGRectMake(0, 0, SIZE(25), SIZE(25)) normalBackgroundImage:@"share_green" selectedBackgroundImage:@"share_green" touchUpInsideEvent:nil];
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    if (self.share&& self.collect) {
        self.navigationItem.rightBarButtonItems = @[shareItem,collectItem];
    }else if (self.collect) {
       self.navigationItem.rightBarButtonItems = @[collectItem];
    }else if (self.share) {
       self.navigationItem.rightBarButtonItems = @[shareItem];
    }
}
- (void)collectArticle:(UIButton *)sender {
    if (self.collectBtn.selected) {
        [self deleteCollectWIthID:self.chirleId];
    }else {
        [self collectWIthID:self.chirleId];
    }
//    self.collectBtn.selected = !self.collectBtn.selected;
}

//收藏
- (void )collectWIthID:(NSString *)ID{
    ws(bself);
    [CSApiManager collectWithID:ID CallBack:^(id  _Nonnull data) {
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
           bself.collectBtn.selected = YES;
        }
        else if ([BackMessage containsString:@"已收藏"]){
            bself.collectBtn.selected = YES;
        }
        [Dialog toastCenter:BackMessage];
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}
//取消收藏
- (void )deleteCollectWIthID:(NSString *)ID{
    ws(bself);
    [CSApiManager deleteCollectWithID:ID CallBack:^(id  _Nonnull data) {
        if (ResultIsCorrect) {
            MYLog(@"%@",data);
            
            bself.collectBtn.selected = NO;
        }
        [Dialog toastCenter:BackMessage];
    } fail:^(NSError * _Nonnull error) {
        [Dialog toastCenter:@"网络错误"];
    }];
}


- (void)shareClick:(UIButton *)sender {
     [self getSHareInfo];
}
//获取分享商品的链接
- (void )getSHareInfo{
    if (!ISLOGIN) {
        [self.navigationController pushViewController:[NSClassFromString(@"CSLoginViewController") new] animated:YES];
        return;
    }
    
    [[Dialog Instance] showCenterProgressWithLabel:@"获取分享内容中..."];
    [CSApiManager ShareArticleWithID:self.chirleId CallBack:^(id  _Nonnull data) {
        [[Dialog Instance] hideProgress];

        if (ResultIsCorrect) {
//            [Dialog toastCenter:@"已获取分享内容，\n请选择平台进行分享"];
            NSString *shareInfoUrl = [NSString stringWithFormat:@"%@",data[@"data"]];
            [self shareWithTitle:self.shareContent contents:@"点击查看" imageName:self.shareIcon linkUrl:shareInfoUrl];
        }else{
            [Dialog toastCenter:BackMessage];
        }
    } fail:^(NSError * _Nonnull error) {
        [[Dialog Instance] hideProgress];
        [Dialog toastCenter:@"网络错误"];
    }];
}





-(void)setUrl:(NSString *)url{
    _url = url;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [self.singWebView loadRequest:request];
}

-(void)setHtmlString:(NSString *)htmlString{
    _htmlString = htmlString;
    [self.singWebView loadHTMLString:[NSString stringWithFormat:@"<html><head><meta name='viewport' content='width=device-width, initial-scale=1,maximum-scale=1, user-scalable=no'> <meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><style>img{width:100%%;}a{word-wrap: break-word;}</style></head><body>%@</body></html>",_htmlString] baseURL:nil];
}



/**
 清理网页缓存
 */
- (void)deleteWebCache {
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) {
        NSSet *websiteDataTypes = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,
                                                        //WKWebsiteDataTypeOfflineWebApplicationCache,
                                                        WKWebsiteDataTypeMemoryCache,
                                                        //WKWebsiteDataTypeLocalStorage,
                                                        //WKWebsiteDataTypeCookies,
                                                        //WKWebsiteDataTypeSessionStorage,
                                                        //WKWebsiteDataTypeIndexedDBDatabases,
                                                        //WKWebsiteDataTypeWebSQLDatabases
                                                        ]];
        //// Date from
        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        //// Execute
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes modifiedSince:dateFrom completionHandler:^{
            // Done
        }];
    } else {
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *cookiesFolderPath = [libraryPath stringByAppendingString:@"/Cookies"];
        NSError *errors;
        [[NSFileManager defaultManager] removeItemAtPath:cookiesFolderPath error:&errors];
    }
}

- (void)dealloc{
    [self deleteWebCache];
    [(WKWebView *)self.singWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end
