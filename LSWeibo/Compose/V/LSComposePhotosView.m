//
//  LSComposePhotosView.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSComposePhotosView.h"

@implementation LSComposePhotosView

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        _photos = [NSMutableArray array];
    }
    return self;
}


-(void)addPhoto:(UIImage *)photo {
    
    UIImageView *photoView = [[UIImageView alloc]init];
    photoView.image = photo;
    
    [self addSubview:photoView];
    //图片储存
    [self.photos addObject:photo];
    
}


-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    // 设置图片的尺寸和位置
    NSUInteger count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH = 80;
    CGFloat imageMargin = 10;
    
    for (int i = 0 ; i<count; i++) {
        UIImageView *image = self.subviews[i];
        
        int col = i % maxCol;
        image.x = col * (imageWH + imageMargin) + imageMargin;
        
        int row = i / maxCol;
        image.y = row * (imageWH + imageMargin);
        image.width = imageWH;
        image.height = imageWH;
        
    }
    
}

@end
