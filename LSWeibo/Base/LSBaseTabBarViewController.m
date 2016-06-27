//
//  LSTabBarViewController.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/20.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSBaseTabBarViewController.h"
#import "LSHomeTableViewController.h"
#import "LSComposeViewController.h"
#import "LSMessageViewController.h"
#import "LSProfileViewController.h"
#import "LSDiscoverViewController.h"
#import "LSBaseNavigationController.h"
#import "LSTabBar.h"
#import "FXBlurView.h"

@interface LSBaseTabBarViewController () <LSTabBarDelegate>

@property (nonatomic,weak)UIButton *plus;
@property (nonatomic,weak)FXBlurView *blurView;
@property (nonatomic,weak)UIImageView *text;
@property (nonatomic,weak)UIImageView *ablum;
@property (nonatomic,weak)UIImageView *camera;
@property (nonatomic,weak)UIImageView *sign;
@property (nonatomic,weak)UIImageView *comment;
@property (nonatomic,weak)UIImageView *more;

@end

@implementation LSBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LSHomeTableViewController *homeViewController = [[LSHomeTableViewController alloc]init];
    homeViewController.title = @"首页";
    homeViewController.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    homeViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    LSBaseNavigationController *homeNavigationController = [[LSBaseNavigationController alloc]initWithRootViewController:homeViewController];
    
    LSMessageViewController *messageViewController = [[LSMessageViewController alloc] init];
    messageViewController.title = @"消息";
    messageViewController.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
    messageViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_message_center_selected"];
    LSBaseNavigationController *messageNavigationController = [[LSBaseNavigationController alloc]initWithRootViewController:messageViewController];
    
    LSDiscoverViewController *discoverViewController = [[LSDiscoverViewController alloc] init];
    discoverViewController.title = @"发现";
    discoverViewController.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    discoverViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discover_selected"];
    LSBaseNavigationController *discoverNavigationController = [[LSBaseNavigationController alloc]initWithRootViewController:discoverViewController];
    
    LSProfileViewController *profileViewController = [[LSProfileViewController alloc] init];
    profileViewController.title = @"我";
    profileViewController.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    profileViewController.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_profile_selected"];
    LSBaseNavigationController *profileNavigationController = [[LSBaseNavigationController alloc]initWithRootViewController:profileViewController];
    
    self.viewControllers = [NSArray arrayWithObjects:homeNavigationController, messageNavigationController, discoverNavigationController, profileNavigationController, nil];
    
    //更换系统自带的tabbar
    LSTabBar *tab = [[LSTabBar alloc]init];
    tab.delegate = self;
    [self setValue:tab forKey:@"tabBar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBarDidClickPlusButton:(LSTabBar *)tabBar {
    FXBlurView *blurView = [[FXBlurView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    blurView.tintColor = [UIColor clearColor];
    self.blurView = blurView;
    
    [self.view addSubview:blurView];
    
    UIImageView *compose = [[UIImageView alloc]init];
    [compose setImage:[UIImage imageNamed:@"compose_slogan"]];
    compose.frame = CGRectMake(0, 100, self.view.frame.size.width, 48);
    compose.contentMode = UIViewContentModeCenter;
    [blurView addSubview:compose];
    
    
    UIView *bottom = [[UIView alloc]init];
    
    bottom.frame = CGRectMake(0, self.view.bounds.size.height - 44, self.view.bounds.size.height, 44);
    
    bottom.backgroundColor = [UIColor whiteColor];
    
    //bottom.contentMode = UIViewContentModeCenter;
    
    
    UIButton *plus = [UIButton buttonWithType:UIButtonTypeCustom];
    
    plus.frame = CGRectMake((self.view.bounds.size.width - 25) * 0.5, 8, 25, 25);
    
    [plus setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_add"] forState:UIControlStateNormal];
    
    [bottom addSubview:plus];
    
    [UIView animateWithDuration:0.2 animations:^{
        
        plus.transform = CGAffineTransformMakeRotation(M_PI_4);
        self.plus = plus;
        
    }];
    
    [plus addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    [blurView addSubview:bottom];
    
    
    UIImageView *text = [self btnAnimateWithFrame:CGRectMake(31, 500, 71, 100) imageName:@"tabbar_compose_idea" text:@"文字" animateFrame:CGRectMake(31, 280, 71, 100) delay:0.0];
    [self setAction:text action:@selector(compose)];
    self.text = text;
    
    UIImageView *ablum = [self btnAnimateWithFrame:CGRectMake(152, 500, 71, 100) imageName:@"tabbar_compose_photo" text:@"相册" animateFrame:CGRectMake(152, 280, 71, 100) delay:0.1];
    self.ablum = ablum;
    
    UIImageView *camera = [self btnAnimateWithFrame:CGRectMake(273, 500, 71, 100) imageName:@"tabbar_compose_camera" text:@"摄影" animateFrame:CGRectMake(273, 280, 71, 100) delay:0.15];
    self.camera = camera;
    
    UIImageView *sign = [self btnAnimateWithFrame:CGRectMake(31, 700, 71, 100) imageName:@"tabbar_compose_lbs" text:@"签到" animateFrame:CGRectMake(31, 410, 71, 100) delay:0.2];
    self.sign = sign;
    
    
    UIImageView *comment = [self btnAnimateWithFrame:CGRectMake(152, 700, 71, 100) imageName:@"tabbar_compose_review" text:@"评论" animateFrame:CGRectMake(152, 410, 71, 100) delay:0.25];
    self.comment = comment;
    
    UIImageView *more = [self btnAnimateWithFrame:CGRectMake(273, 700, 71, 100) imageName:@"tabbar_compose_more" text:@"更多" animateFrame:CGRectMake(273, 410, 71, 100) delay:0.3];
    self.more = more;
    
    
}

//按钮出来动画
-(UIImageView *)btnAnimateWithFrame:(CGRect)frame imageName:(NSString *)imageName text:(NSString *)text animateFrame:(CGRect)aniFrame delay:(CGFloat)delay {
    
    UIImageView *btnContainer = [[UIImageView alloc]init];
    
    btnContainer.frame  = frame;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    
    [btnContainer addSubview:image];
    
    UILabel *word = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, 71, 25)];
    [word setText:text];
    [word setTextAlignment:NSTextAlignmentCenter];
    [word setFont:[UIFont systemFontOfSize:15]];
    [word setTextColor:[UIColor grayColor]];
    
    [btnContainer addSubview:word];
    
    [self.blurView addSubview:btnContainer];
    
    [UIView animateWithDuration:0.5 delay:delay usingSpringWithDamping:0.6 initialSpringVelocity:0.05 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        btnContainer.frame  = aniFrame;
        
    } completion:^(BOOL finished) {
        
    }];
    
    return btnContainer;
}


//设置按钮方法
-(void)setAction:(UIImageView *)imageView action:(SEL)action{
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:gesture];
    
}

//发文字微博
-(void)compose {
    
    [self closeClick];
    
    LSComposeViewController *compose = [[LSComposeViewController alloc]init];
    
    LSBaseNavigationController *composeNavController = [[LSBaseNavigationController alloc]initWithRootViewController:compose];
    
    [self presentViewController:composeNavController animated:YES completion:nil];
    
}


//关闭动画
-(void)btnCloseAnimateWithFrame:(CGRect)rect delay:(CGFloat)delay btnView:(UIImageView *)btnView{

    [UIView animateWithDuration:0.3 delay:delay usingSpringWithDamping:0.6 initialSpringVelocity:0.05 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        
        btnView.frame  = rect;
        
    } completion:^(BOOL finished) {
        
    }];
    
}



//关闭按钮
-(void)closeClick {
    
    [UIView animateWithDuration:0.6 animations:^{
        
        self.plus.transform = CGAffineTransformMakeRotation(-M_PI_2);
        [self btnCloseAnimateWithFrame:CGRectMake(273, 700, 71, 100) delay:0.1 btnView:self.more];
        [self btnCloseAnimateWithFrame:CGRectMake(152, 700, 71, 100) delay:0.15 btnView:self.comment];
        [self btnCloseAnimateWithFrame:CGRectMake(31, 700, 71, 100) delay:0.2 btnView:self.sign];
        [self btnCloseAnimateWithFrame:CGRectMake(273, 700, 71, 100) delay:0.25 btnView:self.camera];
        [self btnCloseAnimateWithFrame:CGRectMake(152, 700, 71, 100) delay:0.3 btnView:self.ablum];
        [self btnCloseAnimateWithFrame:CGRectMake(31, 700, 71, 100) delay:0.35 btnView:self.text];
        
        
    } completion:^(BOOL finished) {
        
        [self.text removeFromSuperview];
        [self.ablum removeFromSuperview];
        [self.camera removeFromSuperview];
        [self.sign removeFromSuperview];
        [self.comment removeFromSuperview];
        [self.more removeFromSuperview];
        [self.blurView removeFromSuperview];
    }];
}


@end
