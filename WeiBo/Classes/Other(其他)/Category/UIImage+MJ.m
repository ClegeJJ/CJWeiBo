//
//  UIImage+MJ.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "UIImage+MJ.h"

@implementation UIImage (MJ)
+ (UIImage *)imageWithName:(NSString *)name
{
    NSString *newName = [name stringByAppendingString:@"_os7"];
    UIImage *image = [UIImage imageNamed:newName];
    if (image == nil) { // 没有_os7后缀的图片
        image = [UIImage imageNamed:name];
    }
    return image;

}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    
    return [self resizedImageWithName:name left:0.5 top:0.5];
}


+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context, [color CGColor]);
    // 渲染上下文
    CGContextFillRect(context, rect);
    // 从上下文中获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    
    return theImage;
}
@end
