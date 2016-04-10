//
//  UserViewController.m
//  WeChatStickers
//
//  Created by Amon on 16/3/27.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "UserViewController.h"
#import "TestViewController.h"

#define kGKHeaderHeight 175.f
#define kGKHeaderVisibleThreshold 44.f
#define kGKNavbarHeight 64.f


@implementation UserViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
    [UIView animateWithDuration:.3 animations:^{
//        _tableView.backgroundColor = UIColorRandom;
    }];
}

- (void)initUI {
    self.navigationItem.title = @"个人中心";
    self.automaticallyAdjustsScrollViewInsets = NO;
//    _mainView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    _mainView.delegate = self;
//    [self.view addSubview:_mainView];
    
    self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kGKHeaderHeight)];
    self.headerView.backgroundColor = UIColorRandom;
//    self.headerView.image = [UIImage imageNamed:@"liangchen2"];
    //    self.headerView.image = [UIImage imageNamed:@"header_background"];
        self.headerView.contentMode = UIViewContentModeScaleAspectFill;
//        self.headerView.clipsToBounds = YES;
//    [_mainView addSubview:self.headerView];
//    [_mainView setContentSize:CGSizeMake(WIDTH(_mainView), 1000)];

    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = UIColorFromRGB(0xefefef);
    _tableView.sectionHeaderHeight = 5;
    _tableView.sectionFooterHeight = 5;

    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = self.headerView;
    
    self.nv = GKFadeNavigationControllerNavigationBarVisibilityHidden;
    
    GKFadeNavigationController *navController = (GKFadeNavigationController *)self.navigationController;
    [navController setNeedsNavigationBarVisibilityUpdateAnimated:NO];
    
    [self.view sendSubviewToBack:self.headerView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = kGKHeaderHeight - scrollView.contentOffset.y;
    if (offsetY > kGKHeaderHeight) {
        CGRect tempFrame = self.headerView.frame;
        tempFrame.origin.y = kGKHeaderHeight - offsetY;
        tempFrame.size.height =  kGKHeaderHeight + (offsetY - kGKHeaderHeight);
        self.headerView.frame = tempFrame;
    }
    
    if (offsetY -kGKNavbarHeight < 0) {
        self.nv = GKFadeNavigationControllerNavigationBarVisibilityVisible;
    } else {
        self.nv = GKFadeNavigationControllerNavigationBarVisibilityHidden;
    }
}

- (GKFadeNavigationControllerNavigationBarVisibility)preferredNavigationBarVisibility
{
    return self.nv;
}


- (void)setNv:(GKFadeNavigationControllerNavigationBarVisibility)nv
{
    BOOL change = NO;
    if (_nv == nv) {
        change = YES;
    }
    _nv = nv;
    
    if (change) {
        GKFadeNavigationController *navController = (GKFadeNavigationController *)self.navigationController;
        [navController setNeedsNavigationBarVisibilityUpdateAnimated:YES];
    }
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    } else {
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    NSString *title;
    NSString *imageName;
    
    if (indexPath.section == 0) {
        imageName = @"fav";
        title = @"我的收藏";
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            imageName = @"message";
            title = @"良辰不介意你的吐槽";
        } else if (indexPath.row == 1) {
            imageName = @"like";
            title = @"给个好评，良辰必有重谢";
        } else if (indexPath.row == 2) {
            imageName = @"share";
            title = @"给良辰个面子，介绍给好友";
        }
    } else {
        imageName = @"focus";
        title = @"更多关于我良辰";
    }
    
    
    cell.imageView.image = [UIImage imageNamed:imageName];
    cell.textLabel.text = title;
    cell.textLabel.font = FONT_CUSTOM(3, 15);
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        
    } else {
        if (indexPath.row == 0) {
            [self gotoFeedback];
        } else if (indexPath.row == 1) {
            [self gotoAppStoreComment];
        } else if (indexPath.row == 2) {
            [self gotoContactMe];
        }
    }
    
}


#pragma mark - 用户动作
- (void)gotoShowCollect {
    
}

- (void)gotoFeedback {
    NSString *subject = @"听说你很屌";
    NSString *body = @"今天来就是告诉你，";
    NSString *address = @"gosu@foxmail.com";
    NSString *path = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", address, subject, body];
    NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
    

}

- (void)gotoAppStoreComment {
    NSString *url = @"itms-apps://itunes.apple.com/app/id1100617666";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)gotoContactMe {
    
}


@end
