//
//  LSTabBar.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSTabBar;
@protocol LSTabBarDelegate <UITabBarDelegate>

@optional

- (void)tabBarDidClickPlusButton:(LSTabBar *)tabBar;

@end

@interface LSTabBar : UITabBar

@property(nonatomic,weak)id <LSTabBarDelegate> delegate;

@end
