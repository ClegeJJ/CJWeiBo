//
//  CJOAuthViewController.m
//  WeiBo
//
//  Created by mac527 on 15/9/12.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJOAuthViewController.h"

#import "AFNetworking.h"

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
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3087428443&redirect_uri=http://www.baidu.com"];
    
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
        
    }
    return YES;
}
/**
 * 开始加载会调用
 */
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"杰哥正在帮你加载中..."];
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
 
 client_id	    true	string	申请应用时分配的AppKey。
 client_secret	true	string	申请应用时分配的AppSecret。
 grant_type	    true	string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时

 code	        true	string	调用authorize获得的code值。
 redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
 */
- (void)accessTokenWithCode:(NSString *)code
{
    // AFNetworking\AFN
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    //告诉管理对象响应的数据为JSON
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.封装请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"client_id"] = @"3087428443";
    parameters[@"client_secret"] = @"cb2c460dcf79e93e80d4a8f396ee4013";
    parameters[@"grant_type"] = @"authorization_code";
    parameters[@"code"] = code;
    parameters[@"redirect_uri"] = @"http://www.baidu.com";
    
    // 3.发送POST请求 获取access_token
    [mgr POST:@"https://api.weibo.com/oauth2/access_token" parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
          // 4.封装 responseObject字典转换成模型
          CJAccount *account = [[CJAccount alloc] initWithDict:responseObject];
          
          // 5.存储模型数据
          [CJAccountTool saveAccount:account];
        
          // 6.选择要跳转的控制器
          [CJLaunchTool chooseRootViewController];
          
          // 7.隐藏弹窗
          [MBProgressHUD hideHUD];
          
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD hideHUD];
        
    }];
    
    

}


@end
