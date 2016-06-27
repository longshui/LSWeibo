//
//  LSAccountObject.h
//  LSWeibo
//
//  Created by 龙水健 on 16/6/20.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LSAccount : NSObject <NSCoding>

/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

@property (nonatomic, copy) NSString *refresh_token;

/**　string	access_token的生命周期，单位是秒数。*/
//@property (nonatomic, copy) NSNumber *expires_in;

/**　string	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

/**	
 *  access token的创建时间 
 */
//@property (nonatomic, strong) NSDate *created_time;

/** 用户昵称  */
@property (nonatomic, copy) NSString *name;

/**
 *  access token的过期时间
 */
@property (nonatomic, strong) NSDate *expiration_time;

@end
