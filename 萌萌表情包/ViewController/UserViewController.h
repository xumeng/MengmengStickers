//
//  UserViewController.h
//  WeChatStickers
//
//  Created by Amon on 16/3/27.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "BaseViewController.h"
#import "GKFadeNavigationController.h"


typedef NS_ENUM(NSInteger, USER_ITEM) {
    USER_ITEM_FAV           = 0,
    USER_ITEM_FEEDBACK,
    USER_ITEM_APPSTORE_COMMEND,
    USER_ITEM_CONTACT
};
@interface UserViewController : BaseViewController<GKFadeNavigationControllerDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

//@property (nonatomic, strong) UIScrollView *mainView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *headerView;

@property (nonatomic)  GKFadeNavigationControllerNavigationBarVisibility nv;


@end
