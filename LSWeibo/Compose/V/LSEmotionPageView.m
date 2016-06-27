//
//  LSEmotionPageView.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSEmotionPageView.h"
#import "LSEmotion.h"
#import "LSEmotionButton.h"
#import "LSEmotionTool.h"

@interface LSEmotionPageView ()
/** 删除按钮 */
@property (nonatomic, weak) UIButton *deleteButton;

@end

@implementation LSEmotionPageView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteButton = [[UIButton alloc]init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
    }
    return self;
}

-(void)setEmotions:(NSArray *)emotions {
    
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i<count; i++) {
        LSEmotionButton *btn = [[LSEmotionButton alloc]init];
        [self addSubview:btn];
        //设置表情数据
        btn.emotion = emotions[i];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

//监听删除按钮点击
-(void)deleteClick {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"EmotionDidDeleteNotification" object:nil];
    
    
}


/**
 *  监听表情按钮点击
 *
 *  @param btn 被点击的表情按钮
 */

-(void)btnClick:(LSEmotionButton *)btn
{
    
    [self selectEmotion:btn.emotion];
    
}

/**
 *  选中某个表情，发出通知
 *
 *  @param emotion 被选中的表情
 */

-(void)selectEmotion:(LSEmotion *)emotion {
    
    //将这个表情存进沙盒
    [LSEmotionTool addRecentEmotion:emotion];
    
    
    //发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"SelectEmotionKey"] = emotion;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"EmotionDidSelectNotification" object:nil userInfo:userInfo];
    
    
    
}




-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    //内边距
    CGFloat inset = 20;
    NSUInteger count = self.emotions.count;
    CGFloat btnw = (self.width - 2 * inset) /LSEmotionMaxCols;
    CGFloat btnH = (self.height - inset) /LSEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.subviews[i+1];
        btn.width = btnw;
        btn.height = btnH;
        btn.x = inset + (i % LSEmotionMaxCols) * btnw;
        btn.y = inset + (i / LSEmotionMaxCols) * btnH;
        
    }
    // 删除按钮
    self.deleteButton.width = btnw;
    self.deleteButton.height = btnH;
    self.deleteButton.x = self.width - inset - btnw;
    self.deleteButton.y = self.height - btnH;
}

@end
