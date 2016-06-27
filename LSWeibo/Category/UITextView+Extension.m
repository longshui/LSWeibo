//
//  UITextView+Extension.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/22.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)
-(void)insertAttributeText:(NSAttributedString *)text {
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc]init];
    //拼接之前的文件
    [attributedText appendAttributedString:self.attributedText];
   
    //拼接图片
    NSUInteger loc = self.selectedRange.location;
    //[attributedText insertAttributedString:text atIndex:loc];
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
    [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];

    self.attributedText = attributedText;
    
    //移除光标到表情的后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
   
}


@end
