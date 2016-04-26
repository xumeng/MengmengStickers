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

//  68列表
@property (nonatomic, strong) NSMutableArray *liubaItemList;

//  恶搞兔列表
@property (nonatomic, strong) NSMutableArray *egaotuItemList;

//  恶搞馆长列表
@property (nonatomic, strong) NSMutableArray *egaoguanzhangItemList;

@end

#define kCellHeight 150.f

extern BOOL reviewStatus;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"main_title", nil);
    
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
    
    if (reviewStatus) {
        _groupTitleList = @[
                            NSLocalizedString(@"cate_doge", nil),
                            NSLocalizedString(@"cate_68", nil),
                            NSLocalizedString(@"cate_egaotu", nil),
                            NSLocalizedString(@"cate_egaoguanzhang", nil),

                            ];
    } else {
        _groupTitleList = @[
                            NSLocalizedString(@"cate_doge", nil),
                            NSLocalizedString(@"cate_68", nil),
                            NSLocalizedString(@"cate_egaotu", nil),
                            NSLocalizedString(@"cate_egaoguanzhang", nil),
                            NSLocalizedString(@"cate_guanzhang", nil),
                            NSLocalizedString(@"cate_weisuocat", nil),
                            NSLocalizedString(@"cate_yeliangchen", nil),
                            NSLocalizedString(@"cate_huangzitao", nil),
                            ];
    }
    
    
    _dogeItemList = [[NSMutableArray alloc] init];
    _kingItemList = [[NSMutableArray alloc] init];
    _baobaoItemList = [[NSMutableArray alloc] init];
    _liangchenItemList = [[NSMutableArray alloc] init];
    _goudaiItemList = [[NSMutableArray alloc] init];
    _liubaItemList = [[NSMutableArray alloc] init];
    _egaotuItemList = [[NSMutableArray alloc] init];
    _egaoguanzhangItemList = [[NSMutableArray alloc] init];
    

    
    for (NSInteger i =1; i<13; i++) {
        NSString *imgName = [NSString stringWithFormat:@"doge%ld", i-1];
        ListItem *item1= [[ListItem alloc] initWithFrame:CGRectZero
                                                   image:[YYImage imageNamed:imgName]
                                                    text:NSLocalizedString(@"doge正常", nil)
                                                imageUrl:imgName];
        item1.objectTag = @(i);
        [_dogeItemList addObject:item1];
    }
    
    for (NSInteger i =1; i<13; i++) {
        NSString *imgName = [NSString stringWithFormat:@"guanzhang%ld", i];
        ListItem *item1= [[ListItem alloc] initWithFrame:CGRectZero
                                                   image:[YYImage imageNamed:imgName]
                                                    text:NSLocalizedString(@"doge正常", nil)
                                                imageUrl:imgName];
        item1.objectTag = @(i);
        [_kingItemList addObject:item1];
    }
    
    for (NSInteger i =1; i<13; i++) {
        NSString *imgName = [NSString stringWithFormat:@"mao%ld", i];
        ListItem *item1= [[ListItem alloc] initWithFrame:CGRectZero
                                                   image:[YYImage imageNamed:imgName]
                                                    text:NSLocalizedString(@"doge正常", nil)
                                                imageUrl:imgName];
        item1.objectTag = @(i);
        [_baobaoItemList addObject:item1];
    }
    
    for (NSInteger i =1; i<13; i++) {
        NSString *imgName = [NSString stringWithFormat:@"68%ld", i];
        ListItem *item1= [[ListItem alloc] initWithFrame:CGRectZero
                                                   image:[YYImage imageNamed:imgName]
                                                    text:NSLocalizedString(@"doge正常", nil)
                                                imageUrl:imgName];
        item1.objectTag = @(i);
        [_liubaItemList addObject:item1];
    }
    
    for (NSInteger i =1; i<13; i++) {
        NSString *imgName = [NSString stringWithFormat:@"egaotu%ld", i];
        ListItem *item1= [[ListItem alloc] initWithFrame:CGRectZero
                                                   image:[YYImage imageNamed:imgName]
                                                    text:NSLocalizedString(@"doge正常", nil)
                                                imageUrl:imgName];
        item1.objectTag = @(i);
        [_egaotuItemList addObject:item1];
    }
    
    for (NSInteger i =1; i<13; i++) {
        NSString *imgName = [NSString stringWithFormat:@"egaoguanzhang%ld", i];
        ListItem *item1= [[ListItem alloc] initWithFrame:CGRectZero
                                                   image:[YYImage imageNamed:imgName]
                                                    text:NSLocalizedString(@"doge正常", nil)
                                                imageUrl:imgName];
        item1.objectTag = @(i);
        [_egaoguanzhangItemList addObject:item1];
    }
    
    for (NSInteger i =1; i<13; i++) {
        NSString *imgName = [NSString stringWithFormat:@"liangchen%ld", i];
        ListItem *item1= [[ListItem alloc] initWithFrame:CGRectZero
                                                   image:[YYImage imageNamed:imgName]
                                                    text:NSLocalizedString(@"doge正常", nil)
                                                imageUrl:imgName];
        item1.objectTag = @(i);
        [_liangchenItemList addObject:item1];
    }
    
    for (NSInteger i =1; i<13; i++) {
        NSString *imgName = [NSString stringWithFormat:@"goudai%ld", i];
        ListItem *item1= [[ListItem alloc] initWithFrame:CGRectZero
                                                   image:[YYImage imageNamed:imgName]
                                                    text:NSLocalizedString(@"doge正常", nil)
                                                imageUrl:imgName];
        item1.objectTag = @(i);
        [_goudaiItemList addObject:item1];
    }
    
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
            list.categoryName = CATE_NAME_DOGE;
            list.itemCount = 111;
        } else if ([indexPath row] == 1) {
            
            list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, WIDTH(_tableView), 150.0) title:title items:_liubaItemList];
            list.categoryName = CATE_NAME_LIUBA;
            list.itemCount = 83;
        }  else if ([indexPath row] == 2) {
            
            list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, WIDTH(_tableView), 150.0) title:title items:_egaotuItemList];
            list.categoryName = CATE_NAME_EGAOTU;
            list.itemCount = 103;
        }  else if ([indexPath row] == 3) {
            
            list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, WIDTH(_tableView), 150.0) title:title items:_egaoguanzhangItemList];
            list.categoryName = CATE_NAME_EGAOGUANZHANG;
            list.itemCount = 87;
        } else if ([indexPath row] == 4) {
            
            list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, WIDTH(_tableView), 150.0) title:title items:_kingItemList];
            list.categoryName = CATE_NAME_GUANZHANG;
            list.itemCount = 217;
        } else if ([indexPath row] == 5) {
            
            list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, WIDTH(_tableView), 150.0) title:title items:_baobaoItemList];
            list.categoryName = CATE_NAME_WEISUOCAT;
            list.itemCount = 61;
        }   else if ([indexPath row] == 6) {
            
            list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, WIDTH(_tableView), 150.0) title:title items:_liangchenItemList];
            list.categoryName = CATE_NAME_LIANGCHEN;
            list.itemCount = 41;
        } else if ([indexPath row] == 7) {
            
            list = [[POHorizontalList alloc] initWithFrame:CGRectMake(0.0, 0.0, WIDTH(_tableView), 150.0) title:title items:_goudaiItemList];
            list.categoryName = CATE_NAME_GOUDAI;
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
    [self addUmengEvent:HOME_SHOW_DETAIL];
    DetailViewController *vc = [[DetailViewController alloc] init];
    vc.paramImage = item.image;
    vc.paramImageName = item.imageUrl;
    vc.hidesBottomBarWhenPushed = YES;
    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showCategoryDetail:(NSString *)categoryName itemCount:(NSInteger)itemCount {
    [self addUmengEvent:HOME_SHOW_CATEGORY];
    CategoryDetailViewController *vc = [[CategoryDetailViewController alloc] init];
    vc.categoryName = categoryName;
    vc.itemCount = itemCount;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
