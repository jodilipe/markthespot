//
//  DirectionsViewController.h
//  MarkTheSpot
//
//  Created by Jon Pedersen on 27/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarkTheSpotAppDelegate.h"


@interface DirectionsViewController : UIViewController < UIAlertViewDelegate,UIActionSheetDelegate> {
	IBOutlet UIButton *button;
	IBOutlet UIButton *smallButton;
	IBOutlet UIButton *configButton;
	IBOutlet UILabel *distanceToMark;
	IBOutlet UILabel *accuracy;
	MarkTheSpotAppDelegate *delegate;
}

@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UIButton *smallButton;
@property (nonatomic, retain) UIButton *configButton;
@property (nonatomic, retain) UILabel *distanceToMark;
@property (nonatomic, retain) UILabel *accuracy;
@property (nonatomic, retain) MarkTheSpotAppDelegate *delegate;

- (void)viewDidLoad;
- (void)buttonPressed:(id)sender;
- (void)smallButtonPressed:(id)sender;
- (void)configButtonPressed:(id)sender;
- (void)setDistance:(int)newDistance;
- (void)setNewMark;
- (void)setNewAccuracy:(int)newAccuracy;

@end
