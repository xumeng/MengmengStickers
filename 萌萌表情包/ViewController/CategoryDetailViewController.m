//
//  CategoryDetailViewController.m
//  WeChatStickers
//
//  Created by Amon on 16/3/28.
//  Copyright © 2016年 GodPlace. All rights reserved.
//

#import "CategoryDetailViewController.h"
#import "DetailViewController.h"
#import "YYImage.h"

@implementation CategoryDetailViewController

- (void) initUI {
    self.title = @"分类详情";
    
    
    UICollectionViewFlowLayout *layout=[[ UICollectionViewFlowLayout alloc ] init];
    
    CGRect frame = CGRectMake(0, 0, WIDTH(self.view), HEIGHT(self.view));
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_collectionView];
    
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
}

#pragma mark - UITableView Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _itemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * CellIdentifier = @"cellId";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *imgName = [NSString stringWithFormat:@"%@%ld", _categoryName, indexPath.item+1];
    
    
    YYAnimatedImageView *imgView = [cell.contentView viewWithTag:999];
    UIImage *img = [YYImage imageNamed:imgName];
    
    if (!imgView) {
        imgView = [[YYAnimatedImageView alloc] initWithImage:img];
        imgView.frame = cell.contentView.bounds;
        imgView.tag = 999;
        
        NSInteger listItem = 3;
        if (img.size.width < WIDTH(collectionView) / listItem) {
            imgView.contentMode = UIViewContentModeCenter;
        } else {
            imgView.contentMode = UIViewContentModeScaleAspectFit;
        }
        [cell.contentView addSubview:imgView];
    }
    imgView.image = img;
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger listItem = 3;
    return CGSizeMake(WIDTH(self.view)/listItem, WIDTH(self.view)/listItem);
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


#pragma mark - 用户动作

#pragma mark - UITableView Delegate methods

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailViewController *vc = [[DetailViewController alloc] init];
    UIImageView *selectImageView = [[collectionView cellForItemAtIndexPath:indexPath].contentView viewWithTag:999];
    vc.paramImage = selectImageView.image;
    vc.hidesBottomBarWhenPushed = YES;
//    self.navigationController.delegate = vc;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
