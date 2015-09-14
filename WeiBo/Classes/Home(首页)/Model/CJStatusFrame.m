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
    
    // 2.头像
    CGFloat iconViewX = CJStatusFrameBorder;
    CGFloat iconViewY = CJStatusFrameBorder;
    CGFloat iconViewWH = 35;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    
    // 3.昵称
    CGFloat nameViewX = CGRectGetMaxX(_iconViewF) + CJStatusFrameBorder;
    CGFloat nameViewY = iconViewY;
    dict[NSFontAttributeName] = CJStatusNameFont;
    CGSize nameViewSize = [status.user.name sizeWithAttributes:dict];
    _nameLabelF = (CGRect){{nameViewX,nameViewY},nameViewSize};

    
    // 4.vip
    if (status.user.isVip) {
        CGFloat vipViewX = nameViewX;
        CGFloat vipViewY = CGRectGetMaxY(_nameLabelF) + CJStatusFrameBorder;
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameViewSize.height;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    // 5.时间
    CGFloat timeViewX = nameViewX;
    CGFloat timeViewY = CGRectGetMaxY(_nameLabelF);
    dict[NSFontAttributeName] = CJStatusTimeFont;
    CGSize timeViewSize = [status.created_at sizeWithAttributes:dict];
    _timeLabelF = (CGRect){{timeViewX,timeViewY},timeViewSize};

    // 6.来源
    CGFloat sourceViewX = CGRectGetMaxX(_timeLabelF) + CJStatusFrameBorder;
    CGFloat sourceViewY = timeViewY;
    dict[NSFontAttributeName] = CJStatusSourceFont;
    CGSize sourceViewSize = [status.source sizeWithAttributes:dict];
    _sourceLabelF = (CGRect){{sourceViewX,sourceViewY},sourceViewSize};
    
    // 7.正文
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = CGRectGetMaxY(_iconViewF) + CJStatusFrameBorder;
    CGFloat contentLabelMaxW = topViewW - CJStatusFrameBorder * 2;
    dict[NSFontAttributeName] = CJStatusContentFont;
    CGSize contentLabelSize = [status.text sizeWithFont:CJStatusContentFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};

    CGFloat topViewH = CGRectGetMaxY(_contentLabelF) + CJStatusFrameBorder;
//    CJLog(@"%f",topViewH);
    _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    
    _cellHeight = topViewH;
}


@end
