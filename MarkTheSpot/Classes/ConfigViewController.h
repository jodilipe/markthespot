//
//  ConfigViewController.h
//  MarkTheSpot
//
//  Created by Jon Pedersen on 07/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarkTheSpotAppDelegate.h"


@interface ConfigViewController : UIViewController {
	IBOutlet UISwitch *usSwitch;
	IBOutlet UISwitch *googleMapsSwitch;
	IBOutlet UIButton *doneButton;
	MarkTheSpotAppDelegate *delegate;
}

@property (nonatomic, retain) UISwitch *usSwitch;
@property (nonatomic, retain) UISwitch *googleMapsSwitch;
@property (nonatomic, retain) UIButton *doneButton;
@property (nonatomic, retain) MarkTheSpotAppDelegate *delegate;

- (void)doneButtonPressed:(id)sender;

@end
