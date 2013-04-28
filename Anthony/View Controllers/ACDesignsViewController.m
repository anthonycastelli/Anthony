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
    UIImage *vegimite = [UIImage imageNamed:@"designs_vegemite"];
    UIImage *luminous  = [UIImage imageNamed:@"designs_luminous"];
    UIImage *cumulus = [UIImage imageNamed:@"designs_cumulus"];
    UIImage *macbookpro = [UIImage imageNamed:@"designs_macbook_pro"];
    UIImage *mail = [UIImage imageNamed:@"designs_mail"];
    UIImage *music = [UIImage imageNamed:@"designs_music_icon"];
    NSArray *items = @[vegimite, luminous, cumulus, macbookpro, mail, music];
    self.designs = [[NSMutableArray alloc] initWithArray:items];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)back:(id)sender {
    for (int i = 0; i < self.designs.count; i++) {
        ACDesignsCell *cellOne = (ACDesignsCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cellOne bounceView:cellOne.border InToPoint:CGPointMake(300, 75) withDelay:0.0];
        [cellOne bounceView:cellOne.design InToPoint:CGPointMake(300, 75) withDelay:0.01];
    }
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
    ACDesignsCell *cell = (ACDesignsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"DesignsCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(ACDesignsCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    [cell.design setImage:self.designs[indexPath.row]];
    
    [cell bounceView:cell.border InToPoint:CGPointMake(100, 75) withDelay:0.4];
    [cell bounceView:cell.design InToPoint:CGPointMake(100, 75) withDelay:0.5];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
