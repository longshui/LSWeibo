//
//  LSWeiboUserObject.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/21.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    LSUserVerifiedTypeNone = -1, // 没有任何认证
    
    LSUserVerifiedPersonal = 0,  // 个人认证
    
    LSUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    LSUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    LSUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    LSUserVerifiedDaren = 220 // 微博达人
} LSUserVerifiedType;

@interface LSUser : NSObject

/**	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;

/**	string	用户头像地址，50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;

/** 会员等级 */
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter = isVip) BOOL vip;

/** 认证类型 */
@property (nonatomic, assign) LSUserVerifiedType verified_type;

+ (instancetype)userWithDict:(NSDictionary *)dict;

@end
