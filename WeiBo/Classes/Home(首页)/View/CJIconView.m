//
//  CJIconView.m
//  WeiBo
//
//  Created by mac527 on 15/9/16.
//  Copyright (c) 2015年 mac527. All rights reserved.
//

#import "CJIconView.h"
#import "CJUser.h"
#import "UIImageView+WebCache.h"
@interface CJIconView ()

@property (nonatomic, weak) UIImageView *verifiedView;

@end

@implementation CJIconView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *verifiedView = [[UIImageView alloc] init];
        verifiedView.bounds = CGRectMake(0, 0, 18, 18);
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return self;
}


- (void)setUser:(CJUser *)user
{
    
    _user = user;
    
    // 下载头像图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];

    // 2.设置加V图片
    switch (user.verified_type) {
        case CJUserVerifiedPersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageWithName:@"avatar_vip"];
            break;
            
        case CJUserVerifiedOrgEnterprice:
        case CJUserVerifiedOrgMedia:
        case CJUserVerifiedOrgWebsite: // 官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageWithName:@"avatar_enterprise_vip"];
            break;
            
        case CJUserVerifiedDaren: // 微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageWithName:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES; // 当做没有任何认证
            break;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.verifiedView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.verifiedView.layer.position = CGPointMake(self.width, self.height);

}

@end
