//
//  LSEmotionAttachment.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSEmotion;

@interface LSEmotionAttachment : NSTextAttachment

@property (nonatomic, strong) LSEmotion *emotion;

@end
