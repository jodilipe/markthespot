//
//  DirectionsViewController.m
//  MarkTheSpot
//
//  Created by Jon Pedersen on 27/10/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "DirectionsViewController.h"


@implementation DirectionsViewController

@synthesize button;
@synthesize smallButton;
@synthesize configButton;
@synthesize delegate;
@synthesize distanceToMark;

- (void)viewDidLoad {
	NSLog(@"DirectionsViewController.viewDidLoad");
	UIImage *image = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"directions" ofType:@"png"]];
	UIImage *imagePressed = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"directions_pressed" ofType:@"png"]];
	[button setImage:image forState:UIControlStateNormal];
	[button setImage:imagePressed forState:UIControlStateHighlighted];
	UIImage *smallImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mark_small" ofType:@"png"]];
	UIImage *smallImagePressed = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"mark_small_pressed" ofType:@"png"]];
	[smallButton setImage:smallImage forState:UIControlStateNormal];
	[smallButton setImage:smallImagePressed forState:UIControlStateHighlighted];
	UIImage *configImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"config" ofType:@"png"]];
	UIImage *configImagePressed = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"config_pressed" ofType:@"png"]];
	[configButton setImage:configImage forState:UIControlStateNormal];
	[configButton setImage:configImagePressed forState:UIControlStateHighlighted];
	[self setDistance:0];
	[image release];
	[imagePressed release];
	[smallImage release];
	[smallImagePressed release];
	[configImage release];
	[configImagePressed release];
}

- (void)smallButtonPressed:(id)sender {
	if ([delegate showDirectionsWarning]) {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Store new Mark?" message:@"Current Mark will be erased."
													   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
		[alert show];
		[alert release];
	} else {
		[self setNewMark];
	}
}

- (void)setNewMark {
	delegate.latitude = 0.0;
	delegate.longitude = 0.0;
	[delegate saveLocation];
	[delegate setMarkTheSpotViewController];
	[delegate.locationManager startUpdatingLocation];
}

- (void)buttonPressed:(id)sender {
	if ([delegate hasLocation]) {
		[delegate showDirections];
	}
}

- (void)configButtonPressed:(id)sender {
	NSLog(@"configButtonPressed");
	[delegate setConfigViewController];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[self setNewMark];
	}
}

- (void)setDistance:(int)newDistance {
	NSString *dist = [NSString stringWithFormat:@"0 %@", (delegate.useUsUnits ? @"ft" : @"m")];
	if (newDistance > 0) {
		if (delegate.useUsUnits) {
			float feet = ((float)newDistance / 0.3048);
			if (feet >= 5280) {
				dist = [NSString stringWithFormat:@"%.1f mi", (feet / (float)5280)];
			} else {
				dist = [NSString stringWithFormat:@"%i ft", (int)feet];
			}
		} else {
			float meters = (float)newDistance;
			if (meters >= 1000) {
				dist = [NSString stringWithFormat:@"%.1f km", (meters / (float)1000)];
			} else {
				dist = [NSString stringWithFormat:@"%i m", (int)meters];
			}
		}
	}	
	distanceToMark.text = [NSString stringWithFormat:@"Distance: %@", dist];
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
	[delegate release];
	[button release];
	[smallButton release];
	[configButton release];
	[distanceToMark release];
    [super dealloc];
}


@end
