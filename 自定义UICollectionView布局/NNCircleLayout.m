//
//  NNCircleLayout.m
//  自定义UICollectionView布局
//
//  Created by xiangtai on 15/6/25.
//  Copyright (c) 2015年 何凯楠. All rights reserved.
//

#import "NNCircleLayout.h"

@implementation NNCircleLayout

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:indexPath.item inSection:0]];
    attris.size = CGSizeMake(50, 50);
    
    //圆的半径
    CGFloat circleRadius = 70;
    
    //圆的中心点
    CGPoint circleCenter = CGPointMake(self.collectionView.frame.size.width * 0.5, self.collectionView.frame.size.height * 0.5);
    
    //每个item之间的角度
    CGFloat angleDetla = M_PI * 2 / [self.collectionView numberOfItemsInSection:0];
    
    //计算每个item的角度
    CGFloat angle = indexPath.item * angleDetla;
    
    attris.center = CGPointMake(circleCenter.x + circleRadius * cosf(angle), circleCenter.y - circleRadius * sinf(angle));
    
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
