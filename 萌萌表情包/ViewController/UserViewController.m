//
//  UserViewController.m
//  WeChatStickers
//
//  Created by Amon on 16/3/27.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "UserViewController.h"
#import "TestViewController.h"

#define kGKHeaderHeight 210.f
#define kGKHeaderVisibleThreshold 44.f
#define kGKNavbarHeight 64.f


@implementation UserViewController


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.navigationController setNeedsStatusBarAppearanceUpdate];
}

- (void)initUI {
    self.navigationItem.title = @"个人中心";
    _mainView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
    
    self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, kGKHeaderHeight)];
    self.headerView.backgroundColor = UIColorRandom;
    self.headerView.image = [UIImage imageNamed:@"liangchen2"];
    //    self.headerView.image = [UIImage imageNamed:@"header_background"];
    //    self.headerView.contentMode = UIViewContentModeScaleAspectFill;
    //    self.headerView.clipsToBounds = YES;
    [_mainView addSubview:self.headerView];
    
    
    
    [_mainView setContentSize:CGSizeMake(WIDTH(_mainView), 1000)];
    
    self.nv = GKFadeNavigationControllerNavigationBarVisibilityHidden;
    
    GKFadeNavigationController *navController = (GKFadeNavigationController *)self.navigationController;
    [navController setNeedsNavigationBarVisibilityUpdateAnimated:NO];
    
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

@end
