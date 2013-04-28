//
//  ACDesignsViewController.m
//  Anthony
//
//  Created by Anthony Castelli on 4/27/13.
//  Copyright (c) 2013 Emerys. All rights reserved.
//

#import "ACDesignsViewController.h"
#import "ACDesignsCell.h"

@interface ACDesignsViewController ()
- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay;
- (void)configureCell:(ACDesignsCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation ACDesignsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    
}

#pragma mark - Animations

- (void)animateView:(UIView *)view toPoint:(CGPoint)point withDelay:(NSTimeInterval)delay {
    [self performBlock:^{
        NSString *keyPath = @"position.x";
        id toValue = [NSNumber numberWithFloat:point.x];
        ACBounceAnimation *bounce = [ACBounceAnimation animationWithKeyPath:keyPath];
        bounce.fromValue = [NSNumber numberWithFloat:view.center.x];
        bounce.toValue = toValue;
        bounce.duration = 0.6f;
        bounce.numberOfBounces = 4;
        bounce.shouldOvershoot = YES;
        
        [view.layer addAnimation:bounce forKey:@"bounce"];
        [view.layer setValue:toValue forKeyPath:keyPath];
    } afterDelay:delay];
}

#pragma mark - CollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.designs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ACDesignsCell *cell = (ACDesignsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Design" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(ACDesignsCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
