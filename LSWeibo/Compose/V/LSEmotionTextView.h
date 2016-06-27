//
//  LSEmotionTextView.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSTextView.h"

@class LSEmotion;

@interface LSEmotionTextView : LSTextView

-(void)insertEmotion:(LSEmotion *)emotion;
- (NSString *)fullText;

@end
