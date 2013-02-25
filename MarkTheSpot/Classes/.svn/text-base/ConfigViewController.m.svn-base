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
@synthesize doneButton;
@synthesize delegate;

/*
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/


- (void)viewDidLoad {
    [super viewDidLoad];
	usSwitch.on = delegate.useUsUnits;
}

- (void)doneButtonPressed:(id)sender {
	if (usSwitch.on) {
		delegate.useUsUnits = YES;
	} else {
		delegate.useUsUnits = NO;
	}
	[delegate setMarkOrDirectionsViewController];
	[delegate refreshLocation];
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
