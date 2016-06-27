//
//  LSEmotionPageView.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

// 一页中最多3行
#define LSEmotionMaxRows 3
// 一行中最多7列
#define LSEmotionMaxCols 7
// 每一页的表情个数
#define LSEmotionPageSize ((LSEmotionMaxRows * LSEmotionMaxCols) - 1)

@interface LSEmotionPageView : UIView

/** 这一页显示的表情（里面都是XFEmotion模型） */
@property (nonatomic, strong) NSArray *emotions;

@end
