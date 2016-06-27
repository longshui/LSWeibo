//
//  LSUserViewController.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/26.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LSUser;

@interface LSUserViewController : UITableViewController

- (instancetype)initWithUser:(LSUser *)user;

@end
