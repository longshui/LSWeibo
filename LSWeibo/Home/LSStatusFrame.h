//
//  LSStatusFrame.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/21.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <Foundation/Foundation.h>

// 昵称字体
#define LSStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define LSStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define LSStatusCellSourceFont LSStatusCellTimeFont
// 正文字体
#define LSStatusCellContentFont [UIFont systemFontOfSize:14]
// 被转发微博的正文字体
#define LSStatusCellRetweetContentFont [UIFont systemFontOfSize:13]

@class LSStatus;

@interface LSStatusFrame : NSObject

@property (nonatomic, strong) LSStatus *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign) CGRect photosViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetViewF;
/** 转发微博正文 + 昵称 */
@property (nonatomic, assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic, assign) CGRect retweetPhotosViewF;
/** 底部工具条 */
@property (nonatomic, assign) CGRect toolbarF;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
