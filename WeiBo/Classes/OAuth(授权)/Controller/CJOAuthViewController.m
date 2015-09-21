//
//  CJOAuthViewController.m
//  WeiBo
//
//  Created by mac527 on 15/9/12.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJOAuthViewController.h"

#import "CJOAuthTool.h"

#import "CJAccount.h"

#import "CJLaunchTool.h"

#import "CJAccountTool.h"

#import "MBProgressHUD+MJ.h"

@interface CJOAuthViewController () <UIWebViewDelegate>

@end

@implementation CJOAuthViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.添加webView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.frame;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    
    // 2.发送code请求
    
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@",AppKey,AppRedirectURL];
    NSURL *url = [NSURL URLWithString:urlStr];

    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
    
}

/**
 *  webView代理方法 当webView发送一个请求之前都会先调用这个方法, 询问代理可不可以加载这个页面(请求)
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    // 1.请求URL数据  @"https://api.weibo.com/oauth2/authorize?client_id=3087428443&redirect_uri=http://www.baidu.com"];
    NSString *urlStr = [request.URL absoluteString];
    
    // 2.查找code=在url中范围
    NSRange range = [urlStr rangeOfString:@"code="];
    // 3.如果URL中有code 拦截code
    if (range.length) {
        
        NSUInteger index = range.location + range.length;
       
        //4.取出code换取accessToken
        NSString *code = [urlStr substringFromIndex:index];
        
        //5.发送POST请求给新浪，用code换取accessToken
        [self accessTokenWithCode:code];
        
        return NO;
        
    }
    
    return YES;
}
/**
 * 开始加载会调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"哥正在帮你加载中..."];
}

/**
 * 完成加载会调用
 */
- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{

    [MBProgressHUD hideHUD];
}

/**
 *  发送POST请求给新浪
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // 1.封装请求参数
    CJOAuthParma *parma = [[CJOAuthParma alloc] init];
    parma.client_id = AppKey;
    parma.client_secret = AppSecret;
    parma.grant_type = @"authorization_code";
    parma.code = code;
    parma.redirect_uri = AppRedirectURL;

    
    // 2.发送POST请求 获取access_token
    [CJOAuthTool oauthWithParam:parma success:^(CJOAuthResult *result) {

        // 5.存储模型数据
        [CJAccountTool saveAccount:result];
        
        // 6.选择要跳转的控制器
        [CJLaunchTool chooseRootViewController];
        
        // 7.隐藏弹窗
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUD];
    }];

}


@end
