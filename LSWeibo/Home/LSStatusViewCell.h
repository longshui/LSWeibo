//
//  LSStatusViewCell.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/23.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSStatusFrame;

@interface LSStatusViewCell : UITableViewCell

@property (nonatomic, strong) LSStatusFrame *statusFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
