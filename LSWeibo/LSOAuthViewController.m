//
//  ViewController.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/16.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSOAuthViewController.h"

@interface LSOAuthViewController ()

@end

@implementation LSOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor blueColor];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(ssoAuthorizeRequest)];
    [self ssoAuthorizeRequest];
}

- (void)ssoAuthorizeRequest {
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kAppRedirectURI;
    request.shouldShowWebViewForAuthIfCannotSSO = YES;
    request.scope = @"all";
    
    //userInfo:用户内容，可为空，微博回调response中的requestUserInfo内容会返回来
    request.userInfo = @{@"SSO_From": @"LSOAuthViewController",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
