//
//  LSEmotionKeyboard.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSEmotionKeyboard.h"
#import "LSEmotionTabBar.h"
#import "LSEmotionListView.h"
#import "LSEmotion.h"
#import "MJExtension.h"
#import "LSEmotionTool.h"

@interface LSEmotionKeyboard() <LSEmotionTabBarDelegate>

/** 保存正在显示listView */
@property (nonatomic, weak) LSEmotionListView *showingListView;
/** 表情内容 */
@property (nonatomic, strong) LSEmotionListView *recentListView;
@property (nonatomic, strong) LSEmotionListView *defaultListView;
@property (nonatomic, strong) LSEmotionListView *emojiListView;
@property (nonatomic, strong) LSEmotionListView *lxhListView;

/** tabbar */
@property (nonatomic, weak) LSEmotionTabBar *tabBar;

@end

@implementation LSEmotionKeyboard

-(LSEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[LSEmotionListView alloc] init];
        //加载沙盒中的数据
        self.recentListView.emotions = [LSEmotionTool recentEmotions];
        
    }
    return _recentListView;
}

-(LSEmotionListView *)defaultListView {
    
    if (!_defaultListView) {
        self.defaultListView = [[LSEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        
        self.defaultListView.emotions = [LSEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
        
    }
    return _defaultListView;
    
}

- (LSEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[LSEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [LSEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
    }
    return _emojiListView;
}

- (LSEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[LSEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [LSEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
    }
    return _lxhListView;
}



-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // tabbar
        LSEmotionTabBar *tabbar = [[LSEmotionTabBar alloc]init];
        tabbar.delegate = self;
        [self addSubview:tabbar];
        self.tabBar = tabbar;
        // 表情选中的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect) name:@"EmotionDidSelectNotification" object:nil];
    }
    
    
    return self;
}


-(void)emotionDidSelect {
    
    self.recentListView.emotions = [LSEmotionTool recentEmotions];
    
}

-(void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 1.tabbar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    // 2.表情内容
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
    
}

#pragma mark - XFEmotionTabBarDelegate
- (void)emotionTabBar:(LSEmotionTabBar *)tabBar didSelectButton:(LSEmotionTabBarButtonType)buttonType {
    
    // 移除正在显示的listView控件
    [self.showingListView removeFromSuperview];
    
    // 根据按钮类型，切换contentView上面的listview
    switch (buttonType) {
        case LSEmotionTabBarButtonTypeDefault:{//默认
            
            [self addSubview:self.defaultListView];
            
            break;
        }
        case LSEmotionTabBarButtonTypeLxh:{//浪小花
            [self addSubview:self.lxhListView];
            
            break;
        }
        case LSEmotionTabBarButtonTypeEmoji:{ //Emoji
            [self addSubview:self.emojiListView];
            
            break;
        }
            
        case LSEmotionTabBarButtonTypeRecent:{ //最近
            
            [self addSubview:self.recentListView];
            break;
        }
            
    }
    
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    // 重新计算子控件的frame(setNeedsLayout内部会在恰当的时刻，重新调用layoutSubviews，重新布局子控件)
    [self setNeedsLayout];
}

@end
