//
//  GlobalVariables.h
//  iBeacon_Retail
//
//  Created by shruthi on 12/03/15.
//  Copyright (c) 2015 TAVANT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreLocationMapViewController.h"

typedef enum {
    
    ENTRYBEACON,
    MENSECTIONBEACON,
    WOMENSECTIONBEACON,
    KIDSECTIONBEACON,
    MAINENTRANCEBEACON
    
    
    
} RegionIdentifier;

@interface GlobalVariables : NSObject

@property(nonatomic,assign) BOOL hasUserEnteredTheStore;
@property(nonatomic,assign) BOOL hasUserGotWOmenSectionOffers;
@property(nonatomic,assign) BOOL hasUserGotMenSectionOffers;
@property(nonatomic,assign) BOOL hasUserGotKidSectionOffers;
@property(nonatomic,assign) BOOL hasUsercrossedEntrance;
@property(nonatomic,assign) BOOL hasUserEntredEntryBeacon;
@property(nonatomic,assign) BOOL isUserOnTheMapScreen;
@property(nonatomic,strong) NSMutableArray *offersDataArray;
@property(nonatomic,strong) NSMutableArray *productDataArray;
@property(nonatomic,strong)StoreLocationMapViewController *storeLocationController;
//@property(nonatomic,assign) BOOL hasALreadyLoggedIn;

+( GlobalVariables *) getInstance;
- (void)showOfferPopUpWithTitle:(NSString *)inTitle andMessage:(NSString *)inMessage;
+(NSString *)returnTitleForRegion:(RegionIdentifier)inRegion;

@end