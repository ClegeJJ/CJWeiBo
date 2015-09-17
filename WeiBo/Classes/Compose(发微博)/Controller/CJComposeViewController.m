//
//  CJComposeViewController.m
//  WeiBo
//
//  Created by mac527 on 15/9/17.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJComposeViewController.h"
#import "AFNetworking.h"
#import "CJAccountTool.h"
#import "CJAccount.h"
#import "CJTextView.h"
#import "MBProgressHUD+MJ.h"
@interface CJComposeViewController ()

@property (nonatomic ,weak) CJTextView *textView;

@end

@implementation CJComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    // 设置textView
    [self setupTextView];
    
}


/**
 *  ViewDidLoad中 设置self.navigationItem.rightBarButtonItem.enabled 的颜色无效。。。 ios 8 Bug；
 */
- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    //     设置导航栏内容
    [self setupNavBar];
    // 弹出键盘
    [self.textView becomeFirstResponder];
    
}

/**
 *  设置导航栏
 */
- (void)setupNavBar
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发微博";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}
/**
 *  设置textView
 */
- (void)setupTextView
{
    CJTextView *textView = [[CJTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"分享点新鲜事...";
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 添加通知 监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
}

/**
 *  通知： 当textView中的文字改变了
 */
- (void)textDidChange
{

    self.navigationItem.rightBarButtonItem.enabled = self.textView.text.length;

}

- (void)cancel
{
    [self.textView endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)send
{
    
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = [CJAccountTool account].access_token;
    parameters[@"status"] = self.textView.text;
    
    
    [self.textView endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // 3.发送GET请求 获取微博数据
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         [MBProgressHUD showSuccess:@"发送成功"];
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         [MBProgressHUD showError:@"发送失败"];
     }];
}
@end
