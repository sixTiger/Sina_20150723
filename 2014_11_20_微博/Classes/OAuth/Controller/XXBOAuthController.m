//
//  XXBOAuthController.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-24.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBOAuthController.h"
#import "XXBAccount.h"
#import "XXBAccountTools.h"
#import "XXBRootViewTools.h"
#import "XXBHttpTool.h"
#import "2014_11_20_微博config.h"



@interface XXBOAuthController ()<UIWebViewDelegate>

@end

@implementation XXBOAuthController

- (void)loadView
{
    [super loadView];
    self.view = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupOAuthController];
}
- (void)setupOAuthController
{
    // 加载登录界面
    UIWebView *webView = (UIWebView *)self.view;
    webView.delegate = self;
    // 创建url == 完整url = 基本url + 参数
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",XXBAppkey,XXBRedirectUrl];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 加载请求
    [webView loadRequest:request];
}
// 开始加载请求的时候调用
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载........"];
}
// 加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}
#pragma mark UIWebView代理

// 是否允许加载这个请求,加载一个网页之前调用这个方法
// 拦截requestToken
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    // 获取请求标记
    NSString *urlStr = request.URL.absoluteString;
    
    // 搜索有木有code=
    NSRange range = [urlStr rangeOfString:@"code="];
    
    // 判断请求的url字符串有木有code=
    if (range.length) { // 有长度才有code=
        
        // 获取code
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        
        // 自定义方法,获取accessToken,封装功能,简化代码
        [self accessTokenWithCode:code];
        [XXBAccountTools getAccessTokenWithCode:code success:^{
            [MBProgressHUD hideHUD];
            // 选择进入新特性还是首页
            // 判断有没有新特性,从而选择窗口的根控制器
            [XXBRootViewTools chooseRootViewController:[UIApplication sharedApplication].keyWindow];
        } failure:^(NSError *error) {
            XXBLog(@"%@",error);
        }];
        // 不需要加载回调界面
        return NO;
    }
    return YES;
}
- (void)accessTokenWithCode:(NSString *)code
{

}
@end
