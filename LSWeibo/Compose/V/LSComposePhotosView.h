//
//  LSComposePhotosView.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSComposePhotosView : UIView

@property (nonatomic, strong,readonly) NSMutableArray *photos;

-(void)addPhoto:(UIImage *)photo;

@end
