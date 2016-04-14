//
//  BaseViewController.m
//  WeChatStickers
//
//  Created by Amon on 16/3/27.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "BaseViewController.h"
#import "MobClick.h"

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureData];
    
    [self initBaseUI];
    
    [self initUI];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count-2] == self) {
        
    }
    else{
        
    }
    [super viewDidDisappear:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)initBaseUI
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initUI
{
    
}

- (void)configureData
{
    
}

- (void)gotoBack
{
    if ([self.navigationController.viewControllers indexOfObject:self] == 0) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)umengEvent:(NSString *)eventId attributes:(NSDictionary *)attributes number:(NSNumber *)number {
    NSString *numberKey = @"__ct__";
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:attributes];
    [mutableDictionary setObject:[number stringValue] forKey:numberKey];
    [MobClick event:eventId attributes:mutableDictionary];
}

- (void)addUmengEvent:(NSString *)eventId {
    [MobClick event:eventId];
}


@end
