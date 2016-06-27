//
//  LSUserViewController.m
//  LSWeibo
//
//  Created by 龙水健 on 16/6/26.
//  Copyright © 2016年 龙水健. All rights reserved.
//

#import "LSUserViewController.h"
#import "LSUserInfoView.h"
#import "AFNetworking.h"
#import "WeiboUser.h"
#import "LSAccountManager.h"
#import "LSAccount.h"
#import "LSUser.h"
#import "LSStatusViewCell.h"
#import "LSStatusFrame.h"
#import "LSStatus.h"
#import "MJExtension.h"

@interface LSUserViewController()

@property (nonatomic, strong) NSMutableArray *statusFrames;
@property (nonatomic, strong) WeiboUser *userInfo;
@property (nonatomic, strong) LSUser *user;
@property (nonatomic, weak) LSUserInfoView *userInfoView;

@end

@implementation LSUserViewController

- (instancetype)initWithUser:(LSUser *)user {
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.user = user;
    }
    return self;
}

#pragma mark - Lifecycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    //[NSThread sleepForTimeInterval:2.0];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.827 alpha:1.0];
    //设置主题
    [self setNavTheme];
    //设置昵称
    [self setupUserInfo];
    
    //上拉刷新,获取更多数据
    //[self refreshStatus:nil];
}

- (void)dealloc {
    self.statusFrames = nil;
    self.userInfo = nil;
}

//懒加载
-(NSMutableArray *)statusFrames {
    
    if (!_statusFrames) {
        _statusFrames  = [[NSMutableArray alloc] init];
    }
    return _statusFrames;
    
}

- (WeiboUser *)userInfo{
    if (!_userInfo) {
        _userInfo = [[WeiboUser alloc]init];
    }
    return _userInfo;
}

- (LSUser *)user{
    if (!_user) {
        _user = [[LSUser alloc]init];
    }
    return _user;
}

//设置导航栏
-(void)setNavTheme {
    self.title = @"个人主页";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(more) image:@"navigationbar_more"  heighlightImage:@"navigationbar_more_highlighted"];
    
}

//设置用户昵称
-(void)setupUserInfo {
    
    // https://api.weibo.com/2/users/show.json
    // access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    // uid	false	int64	需要查询的用户ID。
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    LSAccount *account = [LSAccountManager shareAccountManager].account;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = self.user.idstr;
    
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.userInfo = [WeiboUser userWithDictionary:responseObject];
        
        //NSLog(@"%@---\n%@-%@",responseObject,self.userInfo.name,self.userInfo.userDescription);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        LSLog(@"请求失败");
        
    }];
    
}

/**
 *  UIRefreshControl进入刷新状态：加载最新的数据
 */
-(void)refreshStatus:(UIRefreshControl *)control {
    
    //接口失败，因为升级了statuses/user_timeline，params的uid或者screen_name只能接受当前用户
    //NSString *url = @"https://api.weibo.com/2/statuses/user_timeline.json";
    NSString *url = @"https://api.weibo.com/2/statuses/user_timeline.json";
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    LSAccount *account = [LSAccountManager shareAccountManager].account;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //params[@"uid"] = self.user.idstr;
    //params[@"uid"] = @1628291124;
    NSLog(@"%@",self.user.idstr);
    //params[@"screen_name"] = self.user.name;
    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    LSStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"userInfo:--%@--",responseObject);
        // 将 "微博字典"数组 转为 "微博模型"数组(NSDictionary->LSStatus)
//        NSArray *newStatuses = [LSStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        
//        // 将 XFStatus数组 转为 XFStatusFrame数组
//        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
//        
//        NSRange range = NSMakeRange(0, newFrames.count);
//        
//        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
//        
//        [self.statusFrames insertObjects:newFrames atIndexes:indexSet];
//        
//        //刷新表格
//        [self.tableView reloadData];
//        //结束刷新
//        [control endRefreshing];
        //显示微博刷新数
        //[self showStatusCount:(int)newStatuses.count];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        LSLog(@"请求失败-%@", error);
    }];
}

//刷新数据
-(void)refreshData {
    
    UIRefreshControl *refresh = [[UIRefreshControl alloc]init];
    
    [refresh addTarget:self action:@selector(refreshStatus:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:refresh];
    
    //进来就开始刷新
    [refresh beginRefreshing];
    
    //一进来就开始加载微博
    [self refreshStatus:refresh];
    
}

/**
 *  将LSStatus模型转为LSStatusFrame模型
 */

-(NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (LSStatus *status in statuses) {
        LSStatusFrame *f = [[LSStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
        
    }
    return frames;
    
}

- (void)more{
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.statusFrames.count;
}

//数据源
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //获得cell
    LSStatusViewCell *cell = [LSStatusViewCell cellWithTableView:tableView];
    
    //给cell传递模型数据
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    scrollView == self.tableView == self.view
    // 如果tableView还没有数据，就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        //[self loadMoreStatus];
    }
    
    /*
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSStatusFrame *frame = self.statusFrames[indexPath.row];
    
    return frame.cellHeight;
    
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
