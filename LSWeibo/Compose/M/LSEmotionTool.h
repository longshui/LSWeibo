//
//  LSEmotionTool.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSEmotion;

@interface LSEmotionTool : NSObject

+ (void)addRecentEmotion:(LSEmotion *)emotion;

+ (NSArray *)recentEmotions;

@end
