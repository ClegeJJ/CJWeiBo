//
//  CJStatusFrame.m
//  WeiBo
//
//  Created by mac527 on 15/9/13.
//  Copyright (c) 2015年 mac527. All rights reserved.
//  

#import "CJStatusFrame.h"
#import "CJStatus.h"
#import "CJUser.h"
#import "CJStatusPhotosView.h"
@implementation CJStatusFrame

- (void)setStatus:(CJStatus *)status
{
    _status = status;

    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    // 1.topView
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    
    // 2.头像
    CGFloat iconViewX = CJStatusFrameBorder;
    CGFloat iconViewY = CJStatusFrameBorder;
    CGFloat iconViewWH = 45;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + CJStatusFrameBorder;
    CGFloat nameLabelY = iconViewY;
    dict[NSFontAttributeName] = CJStatusNameFont;
    CGSize nameLabelSize = [status.user.name sizeWithAttributes:dict];
    _nameLabelF = (CGRect){{nameLabelX,nameLabelY},nameLabelSize};

    
    // 4.vip
    CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + CJStatusFrameBorder;
    CGFloat vipViewY = nameLabelY;
    CGFloat vipViewW = 14;
    CGFloat vipViewH = nameLabelSize.height;
    _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    
    // 7.正文
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = CGRectGetMaxY(_iconViewF) + CJStatusFrameBorder;
    CGFloat contentLabelMaxW = topViewW - CJStatusFrameBorder * 2;
    dict[NSFontAttributeName] = CJStatusContentFont;
//    CGSize contentLabelSize = [status.text boundingRectWithSize:CGSizeMake(contentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    CGSize contentLabelSize = [status.attributedString boundingRectWithSize:CGSizeMake(contentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    _contentLabelF = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};
    // 9.被转发的微博的View
    if (status.retweeted_status) { // 有转发微博
        CGFloat retweetViewX = 0;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + CJStatusFrameBorder/2;
        CGFloat retweetViewW = topViewW;
        CGFloat retweetViewH = 0;
        
        // 10.被转发微博的正文
        CGFloat retweetContentLabelX = CJStatusFrameBorder;
        CGFloat retweetContentLabelY = CJStatusFrameBorder;
        CGFloat retweetContentLabelMaxW = retweetViewW - CJStatusFrameBorder * 2;
        dict[NSFontAttributeName] = CJRetweetStatusContentFont;
        CGSize retweetContentLabelSize = [status.retweeted_status.retweetedAttributedSting boundingRectWithSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        _retweetContentLabelF = (CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
        retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        
        // 11.被转发微博的配图
        if (status.retweeted_status.pic_urls.count) { // 被转发的微博有配图
            CGFloat retweetPhotosViewX = retweetContentLabelX;
            CGFloat retweetPhotosViewY = CGRectGetMaxY(_retweetContentLabelF) + CJStatusFrameBorder;
            CGSize retweetPhotosSize = [CJStatusPhotosView sizeWithCount:(int)status.retweeted_status.pic_urls.count];
            _retweetPhotosViewF = (CGRect){{retweetPhotosViewX,retweetPhotosViewY},retweetPhotosSize};
            retweetViewH = CGRectGetMaxY(_retweetPhotosViewF) + CJStatusFrameBorder;
        }else{
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF) + CJStatusFrameBorder;
        }
        
        
        // 12.被转发微博的工具条
        if (status.retweeted_status.isDetail) { // 显示在详情界面
            CGFloat toolbarY = 0;
            CGFloat toolbarW = 200;
            CGFloat toolbarX = retweetViewW - toolbarW;
            CGFloat toolbarH = 20;
            if (status.retweeted_status.pic_urls.count) { // 有图
                toolbarY = CGRectGetMaxY(_retweetPhotosViewF) + CJStatusFrameBorder;
            }else{ // 无图
                toolbarY = CGRectGetMaxY(_retweetContentLabelF) + CJStatusFrameBorder;
            }
            _retweetToolBarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
            retweetViewH = CGRectGetMaxY(_retweetToolBarF) + 5;
        }

        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);

        // 有转发微博的topView高度
        topViewH = CGRectGetMaxY(_retweetViewF);

    }else { // 无转发微博
        if (status.pic_urls.count) { // 有配图
            
            // 8.配图
            CGFloat photosViewX = contentLabelX;
            CGFloat photosViewY = CGRectGetMaxY(_contentLabelF) + CJStatusFrameBorder;
            CGSize photosSize = [CJStatusPhotosView sizeWithCount:(int)status.pic_urls.count];
            _photosViewF = (CGRect){{photosViewX,photosViewY},photosSize};
            topViewH = CGRectGetMaxY(_photosViewF);

        }else{ // 无配图
            topViewH = CGRectGetMaxY(_contentLabelF);

        }
        topViewH += CJStatusFrameBorder;
    }
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);


    // 13.工具条
    CGFloat statusToolX = 0;
    CGFloat statusToolY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolW = topViewW;
    CGFloat statusToolH = 36;
    _statusToolF = CGRectMake(statusToolX, statusToolY, statusToolW, statusToolH);
    
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolF) + CJStatusCellBorder;

}



@end
