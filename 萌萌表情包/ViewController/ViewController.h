//
//  ViewController.h
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@class ListItem;
@interface ViewController : UIViewController<WXApiDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ListItem *currentItem;

@end

