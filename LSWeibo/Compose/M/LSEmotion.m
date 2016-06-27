//
//  LSEmotion.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSEmotion.h"
#import "MJExtension.h"

@interface LSEmotion() <NSCoding>

@end
@implementation LSEmotion

MJCodingImplementation

- (BOOL)isEqual:(LSEmotion *)other
{
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}

@end
