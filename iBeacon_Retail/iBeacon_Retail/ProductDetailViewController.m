//
//  ProductDetailViewController.m
//  iBeacon_Retail
//
//  Created by tavant_sreejit on 3/31/15.
//  Copyright (c) 2015 TAVANT. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.containerView.frame = CGRectMake(0, self.containerView.frame.origin.y, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//    [self.recommendationCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"RecommendationCell"];
    UINib *cellNib = [UINib nibWithNibName:@"ProductRecommendationCollectionViewCell" bundle:nil];
    [self.recommendationCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"RecommendationCell"];
    self.recommendationDataArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"3",@"3",@"3", nil];
    self.scrollview.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.contentView.frame.size.height);
    self.imageScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.imageScrollViewContentView.frame.size.height);
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.recommendationDataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductRecommendationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RecommendationCell" forIndexPath:indexPath];
    cell.backgroundView.backgroundColor = [UIColor redColor];
    return  cell;
}


@end
