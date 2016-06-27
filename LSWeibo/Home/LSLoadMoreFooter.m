//
//  LSLoadMoreFooter.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/23.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSLoadMoreFooter.h"

@implementation LSLoadMoreFooter

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UILabel *label = [[UILabel alloc]init];
        label.width = [UIScreen mainScreen].bounds.size.width;
        label.height = 44;
        label.text = @"加载更多内容";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:18 weight:2.0];
        
        [self addSubview:label];
    }
    
    return self;
}

@end
