//
//  LSIconView.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/23.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSIconView.h"
#import "LSUser.h"
#import "UIImageView+WebCache.h"

@interface LSIconView ()

@property (nonatomic, weak) UIImageView *verifiedView;

@end

@implementation LSIconView

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesture];
    }
    
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (self.touchBlock) {
        self.touchBlock();
    }
}

- (void)dealloc {
    self.user = nil;
    self.touchBlock = nil;
}

-(UIImageView *)verifiedView {
    
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc]init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    
    return _verifiedView;
    
}

-(void)setUser:(LSUser *)user {
    
    _user = user;
    
    // 1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    // 2.设置加V图片
    
    switch (user.verified_type) {
        case LSUserVerifiedPersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case LSUserVerifiedOrgEnterprice:
        case LSUserVerifiedOrgMedia:
        case LSUserVerifiedOrgWebsite: // 官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case LSUserVerifiedDaren: // 微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES; // 当做没有任何认证
            break;
            
    }
}

-(void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.verifiedView.size = self.verifiedView.image.size;
    
    self.verifiedView.x = self.width - self.verifiedView.width * 0.6;
    self.verifiedView.y = self.height - self.verifiedView.height * 0.6;

}


@end
