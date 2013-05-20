//
//  MarkTheSpotAppDelegate.m
//  MarkTheSpot
//
//  Created by Jon Pedersen on 27/10/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "MarkTheSpotAppDelegate.h"
#import "MarkTheSpotViewController.h"
#import "DirectionsViewController.h"
#import "ConfigViewController.h"

@implementation MarkTheSpotAppDelegate

@synthesize window;
@synthesize locationManager;
@synthesize directionsViewController;
@synthesize markTheSpotViewController;
@synthesize configViewController;
@synthesize latitude;
@synthesize longitude;
@synthesize useUsUnits;
@synthesize useGoogleMaps;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	[self startUpdates];
	NSArray *conf = [NSArray arrayWithContentsOfFile:[self getConfigFilePath]];
//	NSLog([NSString stringWithFormat:@"stored config %@", [[conf objectAtIndex:0] boolValue]]);
	useUsUnits = [[conf objectAtIndex:0] boolValue];
	useGoogleMaps = [[conf objectAtIndex:1] boolValue];
	[self setMarkOrDirectionsViewController];
}

- (void)setMarkOrDirectionsViewController {
	if ([self hasStoredLocation]) {
		[self setDirectionsViewController];
	} else {
		[self setMarkTheSpotViewController];
	}
}

- (void)startUpdates {
	if (nil == locationManager) {
		locationManager = [[CLLocationManager alloc] init];
	}
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	locationManager.distanceFilter = 10; // meters
	[locationManager startUpdatingLocation];
}

- (void)refreshLocation {
	[locationManager stopUpdatingLocation];
	[locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
//	NSLog(@"got new location: latitude: %f longitude: %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
	self.latitude = newLocation.coordinate.latitude;
	self.longitude = newLocation.coordinate.longitude;
    int accuracy = [newLocation horizontalAccuracy];
	if ([self hasStoredLocation]) {
		NSArray *storedCoords = [NSArray arrayWithContentsOfFile:[self getLocationFilePath]];
		CLLocation *storedLocation = [[CLLocation alloc] initWithLatitude:[[storedCoords objectAtIndex:0] floatValue] longitude:[[storedCoords objectAtIndex:1] floatValue]];
		int distanceInMeters = [newLocation distanceFromLocation:storedLocation];
//		NSLog(@"distance: %i", distanceInMeters);
		[directionsViewController setDistance:distanceInMeters];
		[directionsViewController setNewAccuracy:accuracy];
	} else {
//		NSLog([NSString stringWithFormat:@"accuracy %i", accuracy]);
		[markTheSpotViewController setNewAccuracy:accuracy];
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString (@"Error getting location", nil) message:NSLocalizedString (@"Please check location settings", nil)
												   delegate:self cancelButtonTitle:NSLocalizedString (@"OK", nil) otherButtonTitles: nil];
	[alert show];
	[alert release];
}

- (void)saveLocation {
//	NSLog(@"saveLocation called - latitude: %f longitude: %f", self.latitude, self.longitude);
	NSArray *arr = [NSArray arrayWithObjects:[NSNumber numberWithDouble:self.latitude], [NSNumber numberWithDouble:self.longitude], nil];
	[arr writeToFile:[self getLocationFilePath] atomically:TRUE];
}

- (NSString*)getConfigFilePath {
	return [[self getDocumentsPath] stringByAppendingPathComponent:@"conf.xml"];
}

- (NSString*)getLocationFilePath {
	return [[self getDocumentsPath] stringByAppendingPathComponent:@"loc.xml"];
}

- (NSString*)getDirectionsWarningFilePath {
	return [[self getDocumentsPath] stringByAppendingPathComponent:@"warn.xml"];
}
		 
- (NSString*)getDocumentsPath {
	NSArray *searchPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	return [searchPaths objectAtIndex: 0];
}
		 
- (void)showDirections {
//	NSLog(@"showDirections called");
	if ([self hasStoredLocation]) {
		NSArray *storedLocation = [NSArray arrayWithContentsOfFile:[self getLocationFilePath]];
//		NSLog(@"storedLocation: latitude: %f, longitude %f",[[storedLocation objectAtIndex:0] floatValue], [[storedLocation objectAtIndex:1] floatValue]);
		NSString *currentLocation = [NSString stringWithFormat: @"%+.6f,%+.6f", self.latitude, self.longitude];
		NSString *mark = [NSString stringWithFormat: @"%+.6f,%+.6f", [[storedLocation objectAtIndex:0] floatValue], [[storedLocation objectAtIndex:1] floatValue]];

        NSString *url = @"";
        if (useGoogleMaps) {
            url = [NSString stringWithFormat: @"http://maps.google.com/?saddr=%@&daddr=%@", currentLocation, mark];
        } else {
            url = [NSString stringWithFormat: @"http://maps.apple.com/?saddr=%@&daddr=%@", currentLocation, mark];
        }
//		NSLog(@"calling maps with url: %@", url);
		[[UIApplication sharedApplication] openURL: [NSURL URLWithString: url]];
	}
}
		
- (BOOL)hasStoredLocation {
	NSArray *storedLocation = [NSArray arrayWithContentsOfFile:[self getLocationFilePath]];
	return storedLocation && [[storedLocation objectAtIndex:0] floatValue] != 0;
}

- (BOOL)hasLocation {
	return latitude != 0;
}

- (BOOL)showDirectionsWarning {
	NSArray *arr = [NSArray arrayWithContentsOfFile:[self getDirectionsWarningFilePath]];
	if (arr == nil) {
		NSString *warningCounterString = @"2";
		arr = [NSArray arrayWithObjects:warningCounterString, nil];
		[arr writeToFile:[self getDirectionsWarningFilePath] atomically:TRUE];
	}
	int warningCounter = [[arr objectAtIndex:0] intValue];
	if (warningCounter > 0) {
		warningCounter--;
		NSString *warningCounterString = [NSString stringWithFormat:@"%i",warningCounter];
		arr = [NSArray arrayWithObjects:warningCounterString, nil];
		[arr writeToFile:[self getDirectionsWarningFilePath] atomically:TRUE];
		return YES;
	} else {
		return NO;
	}
}

- (void)setMarkTheSpotViewController {
	MarkTheSpotViewController *viewController;
	viewController = [[MarkTheSpotViewController alloc]
					initWithNibName:@"MarkTheSpotViewController"
					bundle:nil];
	viewController.delegate = self;
	markTheSpotViewController = viewController;
	[self setViewController:viewController];
}

- (void)setDirectionsViewController {
	DirectionsViewController *viewController;
	viewController = [[DirectionsViewController alloc]
					  initWithNibName:@"DirectionsViewController"
					  bundle:nil];
	viewController.delegate = self;
	directionsViewController = viewController;
	[self setViewController:viewController];
}

- (void)setConfigViewController {
	ConfigViewController *viewController;
	viewController = [[ConfigViewController alloc]
					  initWithNibName:@"ConfigViewController"
					  bundle:nil];
	viewController.delegate = self;
	configViewController = viewController;
	[self setViewController:viewController];
}

- (void)setViewController:(UIViewController*)viewController {
	[UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.75];     /* Sub. duration here */
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:window cache:YES];
	if ([[window subviews] count] > 0) {
		[[[window subviews] objectAtIndex:0] removeFromSuperview];
	}
    [window addSubview:viewController.view];
    [UIView commitAnimations];
    [window makeKeyAndVisible];
}

- (void)storeConfigurations {
//	NSLog(@"storing config feet: %@, google maps: %@", (useUsUnits ? @"YES" : @"NO"), (useGoogleMaps ? @"YES" : @"NO"));
	NSArray *arr = [NSArray arrayWithObjects:(useUsUnits ? @"YES" : @"NO"), (useGoogleMaps ? @"YES" : @"NO"), nil];
	[arr writeToFile:[self getConfigFilePath] atomically:TRUE];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self storeConfigurations];
}

- (void)dealloc {
	[locationManager release];
	[markTheSpotViewController release];
	[directionsViewController release];
	[configViewController release];
    [window release];
    [super dealloc];
}


@end
