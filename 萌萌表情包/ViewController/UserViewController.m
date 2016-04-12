//
//  UserViewController.m
//  WeChatStickers
//
//  Created by Amon on 16/3/27.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "UserViewController.h"
#import "AboutViewController.h"
#import "CategoryDetailViewController.h"
#import "XMShareWechatUtil.h"

#define kGKHeaderHeight 135.f
#define kGKHeaderVisibleThreshold 44.f
#define kGKNavbarHeight 64.f

@interface UserViewController ()

@property (nonatomic, strong) UIImageView *logoView;


@end



@implementation UserViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
    [UIView animateWithDuration:.3 animations:^{
//        _tableView.backgroundColor = UIColorRandom;
    }];
}

- (void)initUI {
    self.title = NSLocalizedString(@"user_title", nil);
    self.automaticallyAdjustsScrollViewInsets = NO;
//    _mainView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    _mainView.delegate = self;
//    [self.view addSubview:_mainView];
    
    self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kGKHeaderHeight)];
    self.headerView.backgroundColor = UIColorFromRGB(0xefefef);
//    self.headerView.image = [UIImage imageNamed:@"liangchen2"];
    //    self.headerView.image = [UIImage imageNamed:@"header_background"];
        self.headerView.contentMode = UIViewContentModeScaleAspectFill;
//        self.headerView.clipsToBounds = YES;
//    [self.view addSubview:self.headerView];
//    [_mainView setContentSize:CGSizeMake(WIDTH(_mainView), 1000)];
    
    
    CGRect tableViewFrame = self.view.bounds;
    _tableView = [[UITableView alloc] initWithFrame:tableViewFrame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = UIColorFromRGB(0xefefef);
    _tableView.sectionHeaderHeight = 5;
    _tableView.sectionFooterHeight = 5;
    _tableView.tableHeaderView = self.headerView;
    [self.view addSubview:_tableView];
    _tableView.contentInset = UIEdgeInsetsMake(HEIGHT_OF_TOP_BAR, 0, 0, 0);
    
    UIImage *logoImg = [UIImage imageNamed:@"doge110.jpg"];
    _logoView = [[UIImageView alloc] init];
    _logoView.image = logoImg;
    ViewRadius(_logoView, logoImg.size.width/2);
    [_logoView sizeToFit];
    [self.headerView addSubview:_logoView];
    _logoView.center = self.headerView.center;


    
//    self.nv = GKFadeNavigationControllerNavigationBarVisibilityHidden;
//    
//    GKFadeNavigationController *navController = (GKFadeNavigationController *)self.navigationController;
//    [navController setNeedsNavigationBarVisibilityUpdateAnimated:NO];
    
    [self.view sendSubviewToBack:self.headerView];
    
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSInteger index = [@(offsetY) integerValue] / 10 % 2;

        [UIView animateWithDuration:0.3 animations:^{
            if (index == 0) {
                _logoView.transform = CGAffineTransformMakeRotation(M_PI);
            } else {
                _logoView.transform = CGAffineTransformMakeRotation(0);
            }
            
        }];

    
    
//    CGFloat offsetY = kGKHeaderHeight - scrollView.contentOffset.y;
//    if (offsetY > kGKHeaderHeight) {
//        CGRect tempFrame = self.headerView.frame;
//        tempFrame.origin.y = kGKHeaderHeight - offsetY;
//        tempFrame.size.height =  kGKHeaderHeight + (offsetY - kGKHeaderHeight);
//        self.headerView.frame = tempFrame;
//    }
//    
//    if (offsetY -kGKNavbarHeight < 0) {
//        self.nv = GKFadeNavigationControllerNavigationBarVisibilityVisible;
//    } else {
//        self.nv = GKFadeNavigationControllerNavigationBarVisibilityHidden;
//    }
}

//- (GKFadeNavigationControllerNavigationBarVisibility)preferredNavigationBarVisibility
//{
//    return self.nv;
//}
//
//
//- (void)setNv:(GKFadeNavigationControllerNavigationBarVisibility)nv
//{
//    BOOL change = NO;
//    if (_nv == nv) {
//        change = YES;
//    }
//    _nv = nv;
//    
//    if (change) {
//        GKFadeNavigationController *navController = (GKFadeNavigationController *)self.navigationController;
//        [navController setNeedsNavigationBarVisibilityUpdateAnimated:YES];
//    }
//}

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
    return 80.f*SCALE_OF_IPHONE6_SCREEN;
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
        title = NSLocalizedString(@"user_my_fav", nil);
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            imageName = @"message";
            title = NSLocalizedString(@"user_feedback", nil);
        } else if (indexPath.row == 1) {
            imageName = @"like";
            title = NSLocalizedString(@"user_appstore_comment", nil);
        } else if (indexPath.row == 2) {
            imageName = @"share";
            title = NSLocalizedString(@"user_share", nil);
        }
    } else {
        imageName = @"focus";
        title = NSLocalizedString(@"user_about", nil);
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
        [self gotoShowFav];
    } else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self gotoFeedback];
        } else if (indexPath.row == 1) {
            [self gotoAppStoreComment];
        } else if (indexPath.row == 2) {
            [self gotoShare];
        }
    } else {
        if (indexPath.row == 0) {
            [self gotoContactMe];
        }
    }
    
}


#pragma mark - 用户动作
- (void)gotoShowFav {
//    NSURL*url=[NSURL URLWithString:@"prefs:root=battery"];
//    [[UIApplication sharedApplication] openURL:url];
    CategoryDetailViewController *vc = [[CategoryDetailViewController alloc] init];
    vc.isFav = YES;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)gotoFeedback {
    NSString *subject = NSLocalizedString(@"feedback_subject", nil);
    NSString *body = NSLocalizedString(@"feedback_body", nil);
    NSString *address = @"i@amonxu.com";
    NSString *path = [NSString stringWithFormat:@"mailto:%@?subject=%@&body=%@", address, subject, body];
    NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

- (void)gotoAppStoreComment {
    NSString *url = @"itms-apps://itunes.apple.com/app/id1100617666";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

- (void)gotoShare {
    XMShareWechatUtil *util = [XMShareWechatUtil sharedInstance];
    util.shareTitle = NSLocalizedString(@"share_title", nil);
    util.shareUrl = APP_URL;
    [util shareToWeixinTimeline];
}

- (void)gotoContactMe {
    AboutViewController *vc = [[AboutViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
