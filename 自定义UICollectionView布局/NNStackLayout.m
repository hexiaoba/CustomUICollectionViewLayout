//
//  NNCircleLayout.m
//  自定义UICollectionView布局
//
//  Created by xiangtai on 15/6/25.
//  Copyright (c) 2015年 何凯楠. All rights reserved.
//

#import "NNStackLayout.h"

#define NNRandom0_1 arc4random_uniform(100)/100.0

@implementation NNStackLayout

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *angles = @[@(0),@(-0.2),@(-0.4),@(0.2),@(0.4)];
    UICollectionViewLayoutAttributes *attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:0]];
    attris.size = CGSizeMake(100, 100);
//    attris.center = CGPointMake(arc4random_uniform(self.collectionView.frame.size.width), arc4random_uniform(self.collectionView.frame.size.height));
    attris.center = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    
    if (indexPath.item < 5) {
//        attris.transform = CGAffineTransformMakeRotation(arc4random_uniform(self.collectionView.frame.size.width));
        CGFloat angle = [angles[indexPath.item] floatValue];
        attris.transform = CGAffineTransformMakeRotation(angle);
        //zIndex值越大，越在上面
        attris.zIndex = [self.collectionView numberOfItemsInSection:indexPath.section] - indexPath.item;
    }else{
        attris.hidden = YES;
    }
    return attris;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *array = [NSMutableArray array];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes *attris = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [array addObject:attris];
    }
    return array;
}

@end
