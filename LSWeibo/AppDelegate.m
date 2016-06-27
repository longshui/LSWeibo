//
//  AppDelegate.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/16.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "AppDelegate.h"
#import "LSOAuthViewController.h"
#import "LSBaseTabBarViewController.h"
#import "UIWindow+Extension.h"

#import "LSAccountManager.h"
#import "LSAccount.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WeiboSDK enableDebugMode:YES]; //open debug mode
    [WeiboSDK registerApp:kAppKey];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //ViewController *vc = [[ViewController alloc]init];
    //UINavigationController *rootNavCtrl = [[UINavigationController alloc]initWithRootViewController:vc];
    //self.window.rootViewController = rootNavCtrl;
    
    LSBaseTabBarViewController *rootViewController = [[LSBaseTabBarViewController alloc]init];
    self.window.rootViewController = rootViewController;
    
    if ([LSAccountManager shareAccountManager].account) {
        
        [self.window switchRootViewController];
        
    } else{
        
        self.window.rootViewController = [[LSOAuthViewController alloc]init];
    }
    
    //[self ssoAuthorizeRequest];
    
    return YES;
}

- (void)ssoAuthorizeRequest{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kAppRedirectURI;
    request.scope = @"all";
    
    //userInfo:用户内容，可为空，微博回调response中的requestUserInfo内容会返回来
    request.userInfo = @{@"SSO_From": @"LSWeibo",
                         @"Other_Info_1": [NSNumber numberWithInt:123],
                         @"Other_Info_2": @[@"obj1", @"obj2"],
                         @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
    [WeiboSDK sendRequest:request];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

#pragma mark - WeiboSDKDelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    
}

//代码由weibo demo提供
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    
    NSLog(@"didReceiveWeiboResponse:%@",response);
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]) {
        
        //NSString *title = NSLocalizedString(@"发送结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
        
        NSLog(@"didReceiveWeiboResponse_WBSendMessageToWeiboResponse:%@",message);
        //UIAlertAction
        WBSendMessageToWeiboResponse* sendMessageToWeiboResponse = (WBSendMessageToWeiboResponse*)response;
        NSString* accessToken = [sendMessageToWeiboResponse.authResponse accessToken];
        if (accessToken)
        {
            //self.wbtoken = accessToken;
        }
        NSString* userID = [sendMessageToWeiboResponse.authResponse userID];
        if (userID) {
            //self.wbCurrentUserID = userID;
        }
        
    } else if ([response isKindOfClass:WBAuthorizeResponse.class]){
        
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        NSLog(@"didReceiveWeiboResponse_WBAuthorizeResponse-%@",message);
        
        if(response.statusCode == WeiboSDKResponseStatusCodeSuccess){
            LSAccount *account = [[LSAccount alloc]init];
            account.access_token = [(WBAuthorizeResponse *)response accessToken];
            account.uid = [(WBAuthorizeResponse *)response userID];
            account.refresh_token = [(WBAuthorizeResponse *)response refreshToken];
            account.expiration_time = [(WBAuthorizeResponse *)response expirationDate];
            
            [[LSAccountManager shareAccountManager] saveAccount:account];
        }
        
    } else if ([response isKindOfClass:WBPaymentResponse.class]) {
        
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.payStatusCode: %@\nresponse.payStatusMessage: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBPaymentResponse *)response payStatusCode], [(WBPaymentResponse *)response payStatusMessage], NSLocalizedString(@"响应UserInfo数据", nil),response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        NSLog(@"didReceiveWeiboResponse_WBPaymentResponse-%@",message);
        
    } else if ([response isKindOfClass:WBSDKAppRecommendResponse.class]) {
        NSString *message = [NSString stringWithFormat:@"accesstoken:\n%@\nresponse.StatusCode: %d\n响应UserInfo数据:%@\n原请求UserInfo数据:%@",[(WBSDKAppRecommendResponse *)response accessToken],(int)response.statusCode,response.userInfo,response.requestUserInfo];
        NSLog(@"didReceiveWeiboResponse_WBSDKAppRecommendResponse-%@",message);
        
    } else if([response isKindOfClass:WBShareMessageToContactResponse.class]) {
        
        NSString *message = [NSString stringWithFormat:@"%@: %d\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode, NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil),response.requestUserInfo];
       NSLog(@"didReceiveWeiboResponse_WBShareMessageToContactResponse-%@",message);
        WBShareMessageToContactResponse* shareMessageToContactResponse = (WBShareMessageToContactResponse*)response;
        
        NSString* accessToken = [shareMessageToContactResponse.authResponse accessToken];
        if (accessToken) {
            //self.wbtoken = accessToken;
        }
        
        NSString* userID = [shareMessageToContactResponse.authResponse userID];
        if (userID) {
            //self.wbCurrentUserID = userID;
        }
    }
}

@end
