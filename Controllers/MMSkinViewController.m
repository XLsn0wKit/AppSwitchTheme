//
//  MMSkinViewController.m
//  MMSkin
//
//  Created by 黄进文 on 2017/2/17.
//  Copyright © 2017年 evenCoder. All rights reserved.
//

#import "MMSkinViewController.h"
#import "UIView+MMExtension.h"
#import "NSObject+MMSkinManager.h"

#define MMColor(r, g, b) [UIColor colorWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:1.0]

#define MMRandomColor MMColor(arc4random_uniform(254),arc4random_uniform(254),arc4random_uniform(254))

@interface MMSkinViewController ()

@end

@implementation MMSkinViewController

static NSString *const MMSkinIdentified = @"MMSkinIdentified";

#pragma mark - 初始化Layout
- (instancetype)init {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 80) / 3;
    layout.itemSize = CGSizeMake(width, width);
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.x = 20;
    self.collectionView.y = 0;
    self.collectionView.width = [UIScreen mainScreen].bounds.size.width - 40;
    self.collectionView.height = [UIScreen mainScreen].bounds.size.height - 40;
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    // 注册
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:MMSkinIdentified];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 60;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MMSkinIdentified forIndexPath:indexPath];
    cell.backgroundColor = MMRandomColor;
    cell.layer.cornerRadius = 10;
    cell.layer.masksToBounds = YES;
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    [self mm_setSkinColor:selectedCell.backgroundColor];
    NSString *color = [NSString stringWithFormat:@"%@", selectedCell.backgroundColor];
    [[NSUserDefaults standardUserDefaults] setObject:color forKey:@"MMSkinColor"];// 保存当前颜色
    [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
}

@end










































