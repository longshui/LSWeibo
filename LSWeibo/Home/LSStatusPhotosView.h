//
//  LSStatusPhotosView.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/21.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSStatusPhotosView : UIView

@property(nonatomic,strong) NSArray *photos;

/**
 *  根据图片个数计算相册的尺寸
 */
+ (CGSize)sizeWithCount:(int)count;

@end
