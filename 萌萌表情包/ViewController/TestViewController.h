//
//  TestViewController.h
//  WeChatStickers
//
//  Created by Amon on 16/3/31.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "BaseViewController.h"
#import "GKFadeNavigationController.h"

@interface TestViewController : BaseViewController<GKFadeNavigationControllerDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *mainView;

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic)  GKFadeNavigationControllerNavigationBarVisibility nv;

@end
