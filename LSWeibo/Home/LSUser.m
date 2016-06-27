//
//  LSWeiboUserObject.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/21.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSUser.h"

@implementation LSUser

+(instancetype)userWithDict:(NSDictionary *)dict {
    
    LSUser * user= [[self alloc] init];
    user.name = dict[@"name"];
    user.idstr = dict[@"idstr"];
    user.profile_image_url = dict[@"profile_image_url"];
    
    return user;
    
}

-(void)setMbtype:(int)mbtype {
    
    _mbtype = mbtype;
    self.vip = mbtype > 2;
    
}

@end
