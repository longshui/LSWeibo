//
//  LSStatusToolbar.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/23.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSStatus;
@interface LSStatusToolbar : UIView

@property(nonatomic, strong) LSStatus *status;

+(instancetype)toolbar;

@end
