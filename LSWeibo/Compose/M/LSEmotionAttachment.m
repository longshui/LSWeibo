//
//  LSEmotionAttachment.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSEmotionAttachment.h"
#import "LSEmotion.h"

@implementation LSEmotionAttachment

- (void)setEmotion:(LSEmotion *)emotion
{
    
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}

@end
