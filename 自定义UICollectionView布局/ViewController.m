//
//  ViewController.m
//  自定义UICollectionView布局
//
//  Created by xiangtai on 15/6/24.
//  Copyright (c) 2015年 何凯楠. All rights reserved.
//

#import "ViewController.h"
#import "NNImageCell.h"
#import "NNLineLayout.h"
#import "NNStackLayout.h"
#import "NNCircleLayout.h"

static NSString *const ID = @"image";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic , strong) NSMutableArray *images;
@property (nonatomic , weak) UICollectionView *collectionView;

@end

@implementation ViewController

-(NSMutableArray *)images
{
    if (_images == nil) {
        _images = [[NSMutableArray alloc] init];
        
        for (int i = 1; i <= 20; i++) {
            [_images addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat w = self.view.frame.size.width;
    CGRect rect = CGRectMake(0, 100, w, 200);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[[NNLineLayout alloc] init]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"NNImageCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    //collectionViewLayout:
    //UICollectionViewLayout
    //UICollectionViewFlowLayout  流水布局(系统自带)
    
}

//切换布局
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[NNLineLayout class]]) {
         [self.collectionView setCollectionViewLayout:[[NNCircleLayout alloc] init] animated:YES];
    }else{
        [self.collectionView setCollectionViewLayout:[[NNLineLayout alloc] init] animated:YES];
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NNImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.image = self.images[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //先删除模型数据
    [self.images removeObjectAtIndex:indexPath.item];
    //刷新UI
    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
