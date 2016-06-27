//
//  LSEmotionTabBar.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSEmotionTabBar.h"
#import "LSEmotionTabBarButton.h"

@interface LSEmotionTabBar()

@property (nonatomic, weak) LSEmotionTabBarButton *selectedBtn;

@end

@implementation LSEmotionTabBar

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setupBtn:@"最近" buttonType:LSEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:LSEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:LSEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:LSEmotionTabBarButtonTypeLxh];
        
    }
    return self;
}

/**
 *  创建一个按钮
 *
 *  @param title 按钮文字
 */
- (LSEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(LSEmotionTabBarButtonType)buttonType {
    
    LSEmotionTabBarButton *btn = [[LSEmotionTabBarButton alloc]init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = buttonType;
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
    
    
    if (buttonType == LSEmotionTabBarButtonTypeDefault) {
        [self btnClick:btn];
    }
    
    // 设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    
    
    
    return btn;
    
}

//重写delegate 方法
-(void)setDelegate:(id<LSEmotionTabBarDelegate>)delegate {
    
    _delegate = delegate;
    
    //选中默认按钮
    [self btnClick:(LSEmotionTabBarButton *)[self viewWithTag:LSEmotionTabBarButtonTypeDefault]];
    
}


/**
 *  按钮点击
 */
- (void)btnClick:(LSEmotionTabBarButton *)btn {
    
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:(int)btn.tag];
    }
    
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        LSEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i * btnW;
        btn.height = btnH;
    }
}


@end
