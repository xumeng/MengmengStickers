//
//  ViewController.m
//  XMShare
//
//  Created by Amon on 15/8/6.
//  Copyright (c) 2015年 GodPlace. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "CategoryDetailViewController.h"

#import "XMPushTransition.h"
#import "AppMacro.h"
#import "YYKit.h"
#import "POHorizontalList.h"

@interface ViewController () <POHorizontalListDelegate, UITableViewDataSource, UITableViewDelegate>


//  分组名称
@property (nonatomic, strong) NSArray *groupTitleList;

//  doge列表
@property (nonatomic, strong) NSMutableArray *dogeItemList;

//  金馆长列表
@property (nonatomic, strong) NSMutableArray *kingItemList;

//  本宝宝列表
@property (nonatomic, strong) NSMutableArray *baobaoItemList;

//  叶良辰列表
@property (nonatomic, strong) NSMutableArray *liangchenItemList;

//  狗带列表
@property (nonatomic, strong) NSMutableArray *goudaiItemList;

@end

#define kCellHeight 150.f

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIImage *image = [YYImage imageNamed:@"1.jpeg"];
//    UIImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
//    [self.view addSubview:imageView];
    
    self.title = @"热门推荐";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.sectionFooterHeight = 0;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self configureData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureData {
    
    _groupTitleList = @[  @"doge", @"金馆长", @"猥琐猫", @"叶良辰", @"黄子韬"];
    ListItem *item1= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"doge0"]
                                                text:NSLocalizedString(@"doge正常", nil)];
    ListItem *item2= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"doge1"]
                                                text:NSLocalizedString(@"doge不正常", nil)];
    ListItem *item3= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"doge2"]
                                                text:NSLocalizedString(@"doge进化", nil)];
    
    ListItem *item4= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"doge3"]
                                                text:NSLocalizedString(@"doge变异", nil)];
    
    
    
    ListItem *item5= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"guanzhang1"]
                                                text:NSLocalizedString(@"金馆长正常", nil)
                                        ];
    ListItem *item6= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"guanzhang2"]
                                                text:NSLocalizedString(@"金国宝馆长", nil)
                                        ];
    ListItem *item7= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"guanzhang3"]
                                                text:NSLocalizedString(@"金六八馆长", nil)
                                        ];
    ListItem *item8= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"guanzhang4"]
                                                text:NSLocalizedString(@"金变异馆长", nil)
                                        ];
    
    ListItem *item9= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"mao1"]
                                                text:NSLocalizedString(@"", nil)
                                        ];
    ListItem *item10= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"mao2"]
                                                text:NSLocalizedString(@"", nil)
                                         ];
    ListItem *item11= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"mao3"]
                                                text:NSLocalizedString(@"", nil)
                                         ];
    ListItem *item12= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"mao4"]
                                                text:NSLocalizedString(@"", nil)
                                         ];
    
    ListItem *item13= [[ListItem alloc] initWithFrame:CGRectZero
                                               image:[YYImage imageNamed:@"liangchen1"]
                                                text:NSLocalizedString(@"在下叶良辰", nil)
                                         ];
    ListItem *item14= [[ListItem alloc] initWithFrame:CGRectZero
                                                image:[YYImage imageNamed:@"liangchen2"]
                                                 text:NSLocalizedString(@"良辰很生气", nil)
                                         ];
    ListItem *item15= [[ListItem alloc] initWithFrame:CGRectZero
                                                image:[YYImage imageNamed:@"liangchen3"]
                                                 text:NSLocalizedString(@"良辰不想说话", nil)
                                         ];
    ListItem *item16= [[ListItem alloc] initWithFrame:CGRectZero
                                                image:[YYImage imageNamed:@"liangchen4"]
                                                 text:NSLocalizedString(@"良辰将要吻你", nil)
                                         ];
    
    ListItem *item17= [[ListItem alloc] initWithFrame:CGRectZero
                                                image:[YYImage imageNamed:@"goudai1"]
                                                 text:NSLocalizedString(@"我不会轻易的狗带", nil)
                                         ];
    ListItem *item18= [[ListItem alloc] initWithFrame:CGRectZero
                                                image:[YYImage imageNamed:@"goudai2"]
                                                 text:NSLocalizedString(@"我选择狗带", nil)
                                         ];
    ListItem *item19= [[ListItem alloc] initWithFrame:CGRectZero
                                                image:[YYImage imageNamed:@"goudai3"]
                                                 text:NSLocalizedString(@"如何狗带", nil)
                                         ];
    ListItem *item20= [[ListItem alloc] initWithFrame:CGRectZero
                                                image:[YYImage imageNamed:@"goudai4"]
                                                 text:NSLocalizedString(@"你的香味", nil)
                                         ];
    
    
    
    item1.objectTag = @(1);
    item2.objectTag = @(2);
    item3.objectTag = @(3);
    item4.objectTag = @(4);
    item5.objectTag = @(5);
    item6.objectTag = @(6);
    item7.objectTag = @(7);
    item8.objectTag = @(8);
    item9.objectTag = @(9);
    item10.objectTag = @(10);
    item11.objectTag = @(11);
    item12.objectTag = @(12);
    item13.objectTag = @(13);
    item14.objectTag = @(14);
    item15.objectTag = @(15);
    item16.objectTag = @(16);
    item17.objectTag = @(17);
    item18.objectTag = @(18);
    item19.objectTag = @(19);
    item20.objectTag = @(20);

    
    
    _dogeItemList = [[NSMutableArray alloc] initWithObjects: item1, item2, item3, item4, nil];
    _kingItemList = [[NSMutableArray alloc] initWithObjects: item5, item6, item7, item8, nil];
    _baobaoItemList = [[NSMutableArray alloc] initWithObjects: item9, item10, item11, item12, nil];
    _liangchenItemList = [[NSMutableArray alloc] initWithObjects: item13, item14, item15, item16, nil];
    _goudaiItemList = [[NSMutableArray alloc] initWithObjects: item17, item18, item19, item20, nil];
    
    
    [self.view addSubview:_tableView];
}



#pragma mark - 代理方法

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _groupTitleList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        NSString *title = _groupTitleList[indexPath.row];
        POHorizontalList *list;
        
        if ([indexPath row] == 0) {
            
            list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, WIDTH(_tableView), 150.0) title:title items:_dogeItemList];
            list.categoryName = @"doge";
            list.itemCount = 111;
        } else if ([indexPath row] == 1) {
            
            list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, WIDTH(_tableView), 150.0) title:title items:_kingItemList];
            list.categoryName = @"guanzhang";
            list.itemCount = 247;
        } else if ([indexPath row] == 2) {
            
            list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, WIDTH(_tableView), 150.0) title:title items:_baobaoItemList];
            list.categoryName = @"mao";
            list.itemCount = 61;
        } else if ([indexPath row] == 3) {
            
            list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, WIDTH(_tableView), 150.0) title:title items:_liangchenItemList];
            list.categoryName = @"liangchen";
            list.itemCount = 41;
        } else if ([indexPath row] == 4) {
            
            list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, WIDTH(_tableView), 150.0) title:title items:_goudaiItemList];
            list.categoryName = @"goudai";
            list.itemCount = 33;
        }
    
        [list setDelegate:self];
        [cell.contentView addSubview:list];
        
        if (indexPath.row != [_tableView numberOfRowsInSection:0]) {
            UIView *splitLineView = [[UIView alloc] initWithFrame:CGRectMake(LEFT_PADDING, kCellHeight-1, WIDTH(_tableView)-LEFT_PADDING*2, 0.5)];
            splitLineView.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:splitLineView];
        }
    
    return cell;
}

#pragma mark - UITableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didSelectItem:(ListItem *)item {
    _currentItem = item;
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.paramImage = item.image;
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
    
    if ([item.objectTag isEqual:@(0)]) {
        
    } else if ([item.objectTag isEqual:@(1)]) {
        
    }
}

- (void)showCategoryDetail:(NSString *)categoryName itemCount:(NSInteger)itemCount {
    CategoryDetailViewController *vc = [[CategoryDetailViewController alloc] init];
    vc.categoryName = categoryName;
    vc.itemCount = itemCount;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
