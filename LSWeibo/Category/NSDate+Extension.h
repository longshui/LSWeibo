//
//  NSDate+Extension.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/22.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;

@end