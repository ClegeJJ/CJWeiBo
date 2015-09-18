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
#import "CJComposeToolBar.h"
#import "MBProgressHUD+MJ.h"
@interface CJComposeViewController () <UITextViewDelegate,CJComposeToolBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic ,weak) CJTextView *textView;
@property (nonatomic ,weak) CJComposeToolBar *toolBar;
@property (nonatomic ,weak) UIImageView *imageView;
@end

@implementation CJComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置textView
    [self setupTextView];
    
    // 设置imageView
    [self setupImageView];
    
    // 设置工具条
    [self setupToolBar];
    

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
    textView.alwaysBounceVertical = YES;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    // 添加通知 监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


/**
 *  键盘弹出会调用
 */
- (void)keyboardWillShow:(NSNotification *)note
{

    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 取出键盘高度
    CGFloat keyboardY = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    // 动画时间
    [UIView animateWithDuration:duration animations:^{
        
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, -keyboardY);
    }];

}

/**
 *  键盘关闭会调用
 */
- (void)keyboardWillHide:(NSNotification *)note
{
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 动画时间
    [UIView animateWithDuration:duration animations:^{
        
            self.toolBar.transform = CGAffineTransformIdentity;
    
    }];

}



/**
 *  设置工具条
 */
- (void)setupToolBar
{
    CJComposeToolBar *toolBar = [[CJComposeToolBar alloc] init];
    CGFloat toolBarX = 0;
    CGFloat toolBarW = self.view.frame.size.width;
    CGFloat toolBarH = 44;
    CGFloat toolBarY = self.view.frame.size.height - toolBarH;
    toolBar.frame = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
}

/**
 *  设置imageView
 */
- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(10, 120, 70, 70);
    [self.view addSubview:imageView];
    self.imageView = imageView;

}

#pragma mark - CJComposeToolBar 代理方法
- (void)composeToolBar:(CJComposeToolBar *)toolBar didClickButton:(CJComposeToolBarButtonType)type
{
    
    
    switch (type) {
        case CJComposeToolBarButtonTypeCamera:
            [self openCemera];
            break;
        case CJComposeToolBarButtonTypePhotoLibrary:
            [self openPhotoLibaray];
            break;
        case CJComposeToolBarButtonTypeMention:
            break;
        case CJComposeToolBarButtonTypeTrend:
            break;
        case CJComposeToolBarButtonTypeEmotion:
            break;
            
        default:
            break;
    }


}
/**
 *  打开相机
 */
- (void)openCemera
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}
/**
 *  打开相册
 */
- (void)openPhotoLibaray
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];

}

#pragma mark - UIImagePickerController 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //  销毁picker控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //  取出图片
    self.imageView.image = info[UIImagePickerControllerOriginalImage];
    
}

#pragma mark - textView代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    [self.textView endEditing:YES];
    
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

/**
 *  发送
 */
- (void)send
{
    if (self.imageView.image) {
        [self sendStatusWithPhoto];
    }else{
        [self sendStatusWithoutPhoto];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

/**
 *  有图
 */
- (void)sendStatusWithPhoto
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [CJAccountTool account].access_token;
    
    // 3.发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) { // 在发送请求之前调用这个block
        // 必须在这里说明要上传哪些文件
        
        NSData *data = UIImageJPEGRepresentation(self.imageView.image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];

    
    
}

/**
 *  无图
 */
- (void)sendStatusWithoutPhoto
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"status"] = self.textView.text;
    params[@"access_token"] = [CJAccountTool account].access_token;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          [MBProgressHUD showSuccess:@"发送成功"];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          [MBProgressHUD showError:@"发送失败"];
      }];
    
}
@end
