//
//  LSComposeToolbar.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LSComposeToolbarButtonTypeCamera, // 拍照
    LSComposeToolbarButtonTypePicture, // 相册
    LSComposeToolbarButtonTypeMention, // @
    LSComposeToolbarButtonTypeTrend, // #
    LSComposeToolbarButtonTypeEmotion // 表情
} LSComposeToolbarButtonType;

@class LSComposeToolbar;

@protocol LSComposeToolbarDelegate <NSObject>

@optional
-(void)composeToolbar:(LSComposeToolbar *)toolbar didClickButton:(LSComposeToolbarButtonType)buttonType;

@end

@interface LSComposeToolbar : UIView

@property (nonatomic, weak) id<LSComposeToolbarDelegate> delegate;
/** 是否要显示键盘按钮  */
@property (nonatomic, assign) BOOL showKeyboardButton;

@end
