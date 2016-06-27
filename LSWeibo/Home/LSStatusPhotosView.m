//
//  LSStatusPhotosView.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/21.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSStatusPhotosView.h"
#import "LSPhoto.h"
#import "LSStatusPhotoView.h"

#define XFStatusPhotoWH 70
#define XFStatusPhotoMargin 10
#define XFStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation LSStatusPhotosView

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
    }
    
    return self;
}


- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    int photosCount = (int)photos.count;
    
    
    // 创建足够数量的图片控件
    // 这里的self.subviews.count不要单独赋值给其他变量
    while (self.subviews.count < photosCount) {
        LSStatusPhotoView *photoView = [[LSStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    // 遍历所有的图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        LSStatusPhotoView *photoView = self.subviews[i];
        
        if (i < photosCount) { // 显示
            photoView.photo = photos[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    //设置图片的尺寸和位置
    int photosCount = (int)self.photos.count;
    int maxCol = XFStatusPhotoMaxCol(photosCount);
    for (int i = 0; i<photosCount; i++) {
        LSStatusPhotoView *photoView = self.subviews[i];
        int col = i % maxCol;
        photoView.x = col * (XFStatusPhotoWH + XFStatusPhotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (XFStatusPhotoWH + XFStatusPhotoMargin);
        photoView.width = XFStatusPhotoWH;
        photoView.height = XFStatusPhotoWH;
    }
    
}

+ (CGSize)sizeWithCount:(int)count
{
    // 最大列数（一行最多有多少列）
    int maxCols = XFStatusPhotoMaxCol(count);
    
    int cols = (count >= maxCols)? maxCols : count;
    CGFloat photosW = cols * XFStatusPhotoWH + (cols - 1) * XFStatusPhotoMargin;
    
    // 行数
    int rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * XFStatusPhotoWH + (rows - 1) * XFStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
