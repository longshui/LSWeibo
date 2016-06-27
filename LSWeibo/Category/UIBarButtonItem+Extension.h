//
//  UIBarButtonItem+Extension.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/22.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image heighlightImage:(NSString *)heilightImage;

@end
