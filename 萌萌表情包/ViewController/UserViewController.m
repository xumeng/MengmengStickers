//
//  UserViewController.m
//  WeChatStickers
//
//  Created by Amon on 16/3/27.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "UserViewController.h"
#import "TestViewController.h"


@implementation UserViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)initUI {
    self.view.backgroundColor = UIColorRandom;
    
    UIButton *btn = [[UIButton alloc] init];
    btn.width = 100;
    btn.height = 44;
    btn.top = 100;
    btn.centerX = self.view.centerX;
    [btn setTitle:@"go" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoTest) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    [self.view addSubview:btn];
}

- (void)gotoTest {
    TestViewController *vc = [[TestViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
