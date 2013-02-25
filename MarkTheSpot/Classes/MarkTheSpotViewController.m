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
}

- (void)buttonPressed:(id)sender {
	NSLog(@"buttonPressed called");
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
//	NSString *usString = @"0 yd";
//	NSString *euString = @"0 m";
//	if (newAccuracy > 0) {
//		float yards = ((float)newAccuracy * 1.0936133);
//		usString = [NSString stringWithFormat:@"%i yd", (int)yards];
//		float meters = (float)newAccuracy;
//		euString = [NSString stringWithFormat:@"%i m", (int)meters];
//	}
//	accuracy.text = [NSString stringWithFormat:@"%@ / %@", euString, usString];

	if (newAccuracy > 0 && newAccuracy <= 40) {
		accuracy.text = @"Good accuracy";
	} else if (newAccuracy > 40 && newAccuracy <= 70) {
		accuracy.text = @"Acceptable accuracy";
	} else {
		accuracy.text = @"Bad accuracy";
	}
}

- (void)dealloc {
	[delegate release];
	[button release];
	[accuracy release];
    [super dealloc];
}

@end
