//
//  LSAccountObject.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/20.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSAccount.h"

@implementation LSAccount

-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.refresh_token forKey:@"refresh_token"];
    [aCoder encodeObject:self.refresh_token forKey:@"expiration_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.refresh_token = [aDecoder decodeObjectForKey:@"refresh_token"];
        self.expiration_time = [aDecoder decodeObjectForKey:@"expiration_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    
    return self;
}

- (void)dealloc {
    self.access_token = nil;
    self.uid = nil;
    self.refresh_token = nil;
    self.expiration_time = nil;
    self.name = nil;
}

@end
