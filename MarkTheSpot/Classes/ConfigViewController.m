//
//  ConfigViewController.m
//  MarkTheSpot
//
//  Created by Jon Pedersen on 07/11/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "ConfigViewController.h"


@implementation ConfigViewController

@synthesize usSwitch;
@synthesize googleMapsSwitch;
@synthesize doneButton;
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
	usSwitch.on = delegate.useUsUnits;
	googleMapsSwitch.on = delegate.useGoogleMaps;
}

- (void)doneButtonPressed:(id)sender {
	if (usSwitch.on) {
		delegate.useUsUnits = YES;
	} else {
		delegate.useUsUnits = NO;
	}
	if (googleMapsSwitch.on) {
		delegate.useGoogleMaps = YES;
	} else {
		delegate.useGoogleMaps = NO;
	}
	[delegate setMarkOrDirectionsViewController];
	[delegate refreshLocation];
    [delegate storeConfigurations];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)dealloc {
	[usSwitch dealloc];
	[doneButton dealloc];
	[delegate release];
    [super dealloc];
}


@end
