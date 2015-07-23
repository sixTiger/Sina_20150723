//
//  XXBNewFeatureViewController.m
//  2014_11_20_微博
//
//  Created by Mac10.9 on 14-11-23.
//  Copyright (c) 2014年 xiaoxiaobing. All rights reserved.
//

#import "XXBNewFeatureViewController.h"
#import "XXBCollectionViewCell.h"


#define newFeatureImageCount 4

@interface XXBNewFeatureViewController ()

@property (weak, nonatomic) UIPageControl *pageControl;

@end

@implementation XXBNewFeatureViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    // 创建布局参数
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 设置item的尺寸
    layout.itemSize = [UIScreen mainScreen].bounds.size;
    // 设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //控制边距
    layout.minimumLineSpacing = 0;
    return [self initWithCollectionViewLayout:layout];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     *  注册UICollectionViewCell
     */
    [self.collectionView registerClass:[XXBCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self setupCollectionView];
    [self setUpPageControl];
}
- (void)setupCollectionView
{
    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}
- (void)setUpPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = newFeatureImageCount;
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor blackColor];
    pageControl.center = CGPointMake(self.view.width * 0.5, self.view.height);
    _pageControl = pageControl;
    [self.view addSubview:pageControl];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x / scrollView.width + 0.5;
    
    _pageControl.currentPage = page;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return newFeatureImageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XXBCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    // 拼接图片名称
    NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",(int)indexPath.item + 1];
    
    cell.image = [UIImage imageNamed:imageName];
    [cell setIndexPath:indexPath itemCount:newFeatureImageCount];
    return cell;
}
@end
