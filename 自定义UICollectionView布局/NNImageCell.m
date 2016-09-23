//
//  NNImageCell.m
//  自定义UICollectionView布局
//
//  Created by xiangtai on 15/6/24.
//  Copyright (c) 2015年 何凯楠. All rights reserved.
//

#import "NNImageCell.h"

@interface NNImageCell()

@property (weak, nonatomic) IBOutlet UIImageView *Icon;

@end

@implementation NNImageCell

- (void)awakeFromNib {
    self.Icon.layer.cornerRadius = 3;
    self.Icon.layer.borderColor = [UIColor whiteColor].CGColor;
    self.Icon.layer.borderWidth = 3;
    self.Icon.layer.masksToBounds = YES;
}

-(void)setImage:(NSString *)image
{
    _image = [image copy];
    self.Icon.image = [UIImage imageNamed:image];
}

@end
