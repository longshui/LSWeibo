//
//  LSAccountManager.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/20.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSAccountManager.h"
#import "LSAccount.h"

#define LSAccountSavePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"WeiboAccount.data"]

@implementation LSAccountManager

+ (instancetype)shareAccountManager {
    static LSAccountManager *accountManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accountManager = [[LSAccountManager alloc] init];
    });
    return accountManager;
}

- (void)saveAccount:(LSAccount *)account {
    // 自定义对象的存储必须用NSKeyedArchiver
    [NSKeyedArchiver archiveRootObject:account toFile:LSAccountSavePath];
}


- (LSAccount *)account{
    if (!_account) {
        // 加载模型
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:LSAccountSavePath];
        
        /*
         * 验证账号是否过期
         */
        //NSDate *now = [NSDate date];
        
        // 如果_account.expiration_time <= now，过期
        /**
         NSOrderedAscending = -1L, 升序，右边 > 左边
         NSOrderedSame, 一样
         NSOrderedDescending 降序，右边 < 左边
         */
        //NSComparisonResult result = [expiresTime compare:now];
//        if ([_account.expiration_time compare:now] != NSOrderedDescending) {  // 过期
//            return nil;
//        }
    }
    
    return _account;
}

- (void)dealloc {
    self.account = nil;
}

@end
