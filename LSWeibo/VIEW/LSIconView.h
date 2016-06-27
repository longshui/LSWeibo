//
//  LSIconView.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/23.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IconViewTouchBlock)(void);

@class LSUser;

@interface LSIconView : UIImageView

@property (nonatomic, strong) LSUser *user;

@property (nonatomic, copy) IconViewTouchBlock touchBlock;

@end
