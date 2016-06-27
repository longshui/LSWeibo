//
//  LSEmotionTabBarButton.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSEmotionTabBarButton.h"

@implementation LSEmotionTabBarButton

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        // 设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
    }
    return self;
}

//重写highlight方法，取消掉高亮状态
-(void)setHighlighted:(BOOL)highlighted {
    
}

@end
