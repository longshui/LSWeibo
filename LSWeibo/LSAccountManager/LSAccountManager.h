//
//  LSAccountManager.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/20.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LSAccount;

@interface LSAccountManager : NSObject

@property (nonatomic, strong) LSAccount *account;

+ (instancetype)shareAccountManager;

- (void)saveAccount:(LSAccount *)account;

@end
