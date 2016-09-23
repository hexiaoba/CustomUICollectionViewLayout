//
//  NNLineLayout.m
//  自定义UICollectionView布局
//
//  Created by xiangtai on 15/6/24.
//  Copyright (c) 2015年 何凯楠. All rights reserved.
//

#import "NNLineLayout.h"

static const CGFloat NNItemWH = 100;

@implementation NNLineLayout

-(instancetype)init
{
    if (self = [super init]) {
        //初始化
    }
    return self;
}

//准备操作,一些初始化工作最好在这个方法中做
-(void)prepareLayout
{
    [super prepareLayout];
    
    //设置item的size
    self.itemSize = CGSizeMake(NNItemWH, NNItemWH);
    //设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    //设置item在中间
    CGFloat inset = (self.collectionView.frame.size.width - NNItemWH) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
    self.minimumLineSpacing = 100;
    
    //每一个cell(item)都有自己的UICollectionViewLayoutAttributes
    //每一个indexPath都有自己的UICollectionViewLayoutAttributes
    
    //UICollectionViewLayoutAttributes  布局属性
}

/**
 *  只要显示的边界发生改变就会重新布局
 *  内部会重新调用layoutAttributesForElementsInRect：方法获得所有cell的布局属性UICollectionViewLayoutAttributes
 */
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/**
 *  用来设置collecitonView停止滚动那一刻的位置
 *
 *  @param proposedContentOffset 原本scrollview停止滚动应该停止的位置
 *  @param velocity              滚动的速度
 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //1.计算出scrollview停止的那一刻的位置
    CGRect lastRect;
    lastRect.size = self.collectionView.frame.size;
    lastRect.origin = proposedContentOffset;
    
    //计算屏幕最中间x
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    //2.取出这个范围的cell的UICollectionViewLayoutAttributes
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    //3.遍历所有属性
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attributes in array) {
        if (ABS(attributes.center.x - centerX) < ABS(adjustOffsetX)) {
            adjustOffsetX = attributes.center.x - centerX;
        }
    }
    
    return CGPointMake(adjustOffsetX + proposedContentOffset.x, proposedContentOffset.y);
}

/*有效距离:当item的中点x距离屏幕中点x在ActivityDistance(有效距离)内，才会被放大，其他情况都缩小*/
static CGFloat const ActivityDistance = 150;
/*缩放比例:值越大，item就会越大*/
static CGFloat const ScaleRatio = 0.6;

/**
 *  获得所有cell的布局属性 UICollectionViewLayoutAttributes
 */
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //0.计算可见的矩形框
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    
    //1.取出默认的cell的UICollectionViewLayoutAttributes
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    //计算屏幕最中间x
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
//    NSLog(@"begin");
    //2.遍历所有的布局属性
    for (UICollectionViewLayoutAttributes *attributes in array) {
        //如果在屏幕不可见，跳过
        if(!CGRectIntersectsRect(visiableRect, attributes.frame)) continue;
//        NSLog(@"----");
        
        //每一个item的中点x
        CGFloat itemCenterX = attributes.center.x;
        
        //根据屏幕最中间距离计算缩放比例
        CGFloat scale = 1 + ScaleRatio * (1 - ABS(itemCenterX - centerX) / ActivityDistance);
//        attributes.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
//    NSLog(@"end");
    return array;
}


@end
