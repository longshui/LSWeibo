//
//  LSTextView.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/24.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSTextView : UITextView

/** 占位文字 */
@property (nonatomic,copy)NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic,strong)UIColor *placeholderColor;

@end
