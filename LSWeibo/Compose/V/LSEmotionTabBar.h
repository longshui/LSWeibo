//
//  LSEmotionTabBar.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LSEmotionTabBarButtonTypeRecent, // 最近
    LSEmotionTabBarButtonTypeDefault, // 默认
    LSEmotionTabBarButtonTypeEmoji, // emoji
    LSEmotionTabBarButtonTypeLxh, // 浪小花
    
} LSEmotionTabBarButtonType;

@class LSEmotionTabBar;
@protocol LSEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(LSEmotionTabBar *)tabBar didSelectButton:(LSEmotionTabBarButtonType)buttonType;

@end

@interface LSEmotionTabBar : UIView

@property (nonatomic, weak) id<LSEmotionTabBarDelegate> delegate;

@end
