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
    CGFloat iconViewWH = 35;
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
    
    // 5.时间
//    CGFloat timeLabelX = nameLabelX;
//    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + CJStatusFrameBorder;
//    dict[NSFontAttributeName] = CJStatusTimeFont;
//    CGSize timeLabelSize = [status.created_at sizeWithAttributes:dict];
//    _timeLabelF = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
//
//    // 6.来源
//    CGFloat sourceViewX = CGRectGetMaxX(_timeLabelF) + CJStatusFrameBorder;
//    CGFloat sourceViewY = timeLabelY;
//    dict[NSFontAttributeName] = CJStatusSourceFont;
//    CGSize sourceViewSize = [status.source sizeWithAttributes:dict];
//    _sourceLabelF = (CGRect){{sourceViewX,sourceViewY},sourceViewSize};
    
    // 7.正文
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = CGRectGetMaxY(_iconViewF) + CJStatusFrameBorder;
    CGFloat contentLabelMaxW = topViewW - CJStatusFrameBorder * 2;
    dict[NSFontAttributeName] = CJStatusContentFont;
    CGSize contentLabelSize = [status.text boundingRectWithSize:CGSizeMake(contentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    _contentLabelF = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};

    
    
//    // 8.配图   整合到下面去了！！！！
//    if (status.thumbnail_pic) { // 有配图  --- 无转发微博
//        CGFloat photoViewX = contentLabelX;
//        CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + CJStatusFrameBorder;
//        CGFloat photoViewWH = 70;
//        _photoViewF = CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH);
//    }
    
        
    // 9.被转发的微博的View
    if (status.retweeted_status) { // 有转发微博
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) + CJStatusFrameBorder;
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewH = 0;
        
        // 10.被转发微博用户的昵称
        CGFloat retweetNameLabelX = CJStatusFrameBorder;
        CGFloat retweetNameLabelY = CJStatusFrameBorder;
        dict[NSFontAttributeName] = CJRetweetStatusNameFont;
        NSString *newName = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];
        CGSize retweetNameLabelSize = [newName sizeWithAttributes:dict];
        _retweetNameLabelF = (CGRect){{retweetNameLabelX,retweetNameLabelY},retweetNameLabelSize};

        // 11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + CJStatusFrameBorder;
        CGFloat retweetContentLabelMaxW = retweetViewW - CJStatusFrameBorder * 2;
        dict[NSFontAttributeName] = CJRetweetStatusContentFont;
        CGSize retweetContentLabelSize = [status.retweeted_status.text boundingRectWithSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;

        _retweetContentLabelF = (CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
        
        // 12.被转发微博的配图
        if (status.retweeted_status.thumbnail_pic) { // 被转发的微博有配图
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelF) + CJStatusFrameBorder;
            CGFloat retweetPhotoViewWH = 70;

            _retweetPhotoViewF = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewWH, retweetPhotoViewWH);
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewF);

        }else { // 被转发的微博无配图
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF);
        }
        retweetViewH += CJStatusFrameBorder;
        _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);

        // 有转发微博的topView高度
        topViewH = CGRectGetMaxY(_retweetViewF);

    }else { // 无转发微博
        if (status.thumbnail_pic) { // 有配图
            
            // 8.配图
            CGFloat photoViewX = contentLabelX;
            CGFloat photoViewY = CGRectGetMaxY(_contentLabelF) + CJStatusFrameBorder;
            CGFloat photoViewWH = 70;
            _photoViewF = CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH);
            topViewH = CGRectGetMaxY(_photoViewF);

        }else{ // 无配图
            topViewH = CGRectGetMaxY(_contentLabelF);

        }
    }

    topViewH += CJStatusFrameBorder;
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);

    // 13.工具条
    CGFloat statusToolX = 0;
    CGFloat statusToolY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolW = topViewW;
    CGFloat statusToolH = 35;
    _statusToolF = CGRectMake(statusToolX, statusToolY, statusToolW, statusToolH);
    
    
    // 14.cell的高度
    _cellHeight = CGRectGetMaxY(_statusToolF) + CJStatusFrameBorder;
    
}


@end
