//
//  MarkTheSpotViewController.m
//  MarkTheSpot
//
//  Created by Jon Pedersen on 27/10/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "MarkTheSpotViewController.h"

@implementation MarkTheSpotViewController

@synthesize button;
@synthesize delegate;
@synthesize accuracy;

- (void)viewDidLoad {
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mark" ofType:@"png"]];
	UIImage *imagePressed = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mark_pressed" ofType:@"png"]];
	[button setImage:image forState:UIControlStateNormal];
	[button setImage:imagePressed forState:UIControlStateHighlighted];
	[image release];
	[imagePressed release];
    [button setEnabled:NO];
}

- (void)buttonPressed:(id)sender {
//	NSLog(@"buttonPressed called");
	if (delegate.latitude != 0) {
		[delegate saveLocation];
		[delegate setDirectionsViewController];
		[delegate.locationManager startUpdatingLocation];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)setNewAccuracy:(int)newAccuracy {
	if (newAccuracy > 0 && newAccuracy <= 40) {
		accuracy.text = @"";
        [button setEnabled:YES];
	} else if (newAccuracy > 40 && newAccuracy <= 70) {
		accuracy.text = @"Acceptable accuracy";
        [button setEnabled:YES];
	} else {
		accuracy.text = @"Unacceptable accuracy";
        [button setEnabled:NO];
    }
}

- (void)dealloc {
	[delegate release];
	[button release];
	[accuracy release];
    [super dealloc];
}

@end
