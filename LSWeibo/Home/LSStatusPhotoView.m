//
//  LSStatusPhotoView.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/21.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSStatusPhotoView.h"
#import "LSPhoto.h"
#import "UIImageView+WebCache.h"

@interface LSStatusPhotoView()

@property (nonatomic, strong) UIImageView *gifView;

@end
@implementation LSStatusPhotoView

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        _gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_gifView];
    }
    return _gifView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容都剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setPhoto:(LSPhoto *)photo
{
    _photo = photo;
    
    // 设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
