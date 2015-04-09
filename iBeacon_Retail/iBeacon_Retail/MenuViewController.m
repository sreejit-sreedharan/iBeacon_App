//
//  MenuViewController.m
//  iBeacon_Retail
//
//  Created by tavant_sreejit on 3/3/15.
//  Copyright (c) 2015 TAVANT. All rights reserved.
//

#import "MenuViewController.h"
#import "ESTBeaconManager.h"
#import "ESTConfig.h"
#import "ESTBeaconManager.h"
#import "ESTBeaconRegion.h"
#import "ESTIndoorLocationManager.h"
#import "ESTConfig.h"
#import "ESTLocationBuilder.h"

typedef enum : NSUInteger {
    products=0,
    offers,
    cart,
    map,
    logout
} menuItems;



@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.menuItems = [NSArray arrayWithObjects:@"Products",@"Offers",@"Cart",@"Store Map",@"Logout", nil];
    self.menuImageItems = [NSArray arrayWithObjects:@"product.png",@"offer.png",@"Cart.png",@"Map.png",@"Logout.png", nil];
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    NSIndexPath *indexPath = [self.tableview indexPathForSelectedRow];
    [self.tableview selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
 //   [self setBlurredBackground];
    
}

-(void)viewDidLayoutSubviews {
    [self setBlurredBackground];
}

-(void)setBlurredBackground{
    
    
    [self.backgroundView setImage:[UIImage imageNamed:@"bg_blur.png"]];
    [_backgroundView setContentMode:UIViewContentModeLeft];
    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.backgroundView.bounds;
    effectView.alpha=1.0;
     [self.backgroundView addSubview:effectView];
    self.userIcon.layer.cornerRadius=self.userIcon.frame.size.width/2;
    self.userIcon.clipsToBounds=YES;
    self.userIcon.layer.borderWidth = 1.0f;
    self.userIcon.layer.borderColor = [UIColor whiteColor].CGColor;

}

#pragma mark - For Status Bar
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuItems count];
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.backgroundColor = [UIColor clearColor];

    UIView *backgroundView = [[UIView alloc] initWithFrame:cell.selectedBackgroundView.frame];
    [backgroundView setBackgroundColor:[UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.3]];
    [cell setSelectedBackgroundView:backgroundView];

    [cell.textLabel setText:[self.menuItems objectAtIndex:indexPath.row]];
    cell.textLabel.textColor=[UIColor whiteColor];
    cell.imageView.image=[UIImage imageNamed:[self.menuImageItems objectAtIndex:indexPath.row]];
//    if(indexPath.row == 0){
//        [cell setSelected:YES];
//    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.delegate menuItemSelected:indexPath.row];
    UIViewController* vc;
    UIAlertView *alert;
    switch(indexPath.row)
    {
        case products:
            vc = (ProductViewController*)[[ProductViewController alloc] initWithNibName:@"ProductViewController" bundle:nil];
            break;
        case offers:
            vc = (OffersViewController*)[[OffersViewController alloc] initWithNibName:@"OffersViewController" bundle:nil];
            break;
        case cart:
            vc = (CartViewController*)[[CartViewController alloc] initWithNibName:@"CartViewController" bundle:nil];
            break;
        case map:
            vc = [self loadStoreMap:(StoreLocationMapViewController*)vc];
            break;
        case logout:
            alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                            message:@"Are you sure you want logout."
                                                           delegate:self
                                                  cancelButtonTitle:@"No"
                                                  otherButtonTitles:@"Yes", nil];
            [alert show];
            break;
        default:
            break;
    }
    if(indexPath.row != logout){        
        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:vc withSlideOutAnimation:NO andCompletion:nil];
    }
}

#pragma mark WARNING------THERE IS A MEMORY LEAK HERE THAT NEEDS TO BE FIXED!!!!
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    __block UIViewController* vc;
    __block UIStoryboard *storyboard;
    __block AppDelegate *testAppDelegate;
    
    if([title isEqualToString:@"Yes"])
    {
        [[SlideNavigationController sharedInstance] closeMenuWithCompletion:^(){
            SlideNavigationController *slideMenuSetToNull = [SlideNavigationController sharedInstance];
            slideMenuSetToNull = nil;
            storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            vc = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            testAppDelegate = [UIApplication sharedApplication].delegate;
            testAppDelegate.window.rootViewController = vc;
        }];
        
    }
    else if([title isEqualToString:@"No"])
    {
        [[SlideNavigationController sharedInstance] closeMenuWithCompletion:nil];
    }
}

-(StoreLocationMapViewController*)loadStoreMap:(StoreLocationMapViewController*) vc{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"location" ofType:@"json"];
    NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    ESTLocation *location = [ESTLocationBuilder parseFromJSON:content];
    vc = [[StoreLocationMapViewController alloc] initWithLocation:location];
    GlobalVariables *globalVar = [GlobalVariables getInstance];
    globalVar.storeLocationController = vc;
    return vc;
}

@end
