//
//  UIWindow+Extension.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/22.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "LSBaseTabBarViewController.h"
#import "LSNewFeatureController.h"

@implementation UIWindow (Extension)
-(void)switchRootViewController {
    
    // 切换窗口的根控制器
    NSString *key = @"version";
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    // 当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
    self.rootViewController = [[LSBaseTabBarViewController alloc] init];
    if ([currentVersion isEqualToString:lastVersion]) { // 版本号相同：这次打开和上次打开的是同一个版本
        self.rootViewController = [[LSBaseTabBarViewController alloc] init];
    } else { // 这次打开的版本和上一次不一样，显示新特性
        self.rootViewController = [[LSNewFeatureController alloc] init];
        
        // 将当前的版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
   
}
@end
