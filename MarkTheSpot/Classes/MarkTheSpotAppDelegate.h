//
//  MarkTheSpotAppDelegate.h
//  MarkTheSpot
//
//  Created by Jon Pedersen on 27/10/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLError.h>
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@class DirectionsViewController;
@class MarkTheSpotViewController;
@class ConfigViewController;

@interface MarkTheSpotAppDelegate : NSObject <UIApplicationDelegate, CLLocationManagerDelegate> {
    UIWindow *window;
	DirectionsViewController *directionsViewController;
	MarkTheSpotViewController *markTheSpotViewController;
	ConfigViewController *configViewController;
	CLLocationManager *locationManager;
	float latitude;
	float longitude;
	BOOL useUsUnits;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) DirectionsViewController *directionsViewController;
@property (nonatomic, retain) MarkTheSpotViewController *markTheSpotViewController;
@property (nonatomic, retain) ConfigViewController *configViewController;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property float latitude;
@property float longitude;
@property BOOL useUsUnits;

- (void)startUpdates;
- (void)refreshLocation;
- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation;
- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error;
- (void)saveLocation;
- (NSString*)getConfigFilePath;
- (NSString*)getLocationFilePath;
- (NSString*)getDirectionsWarningFilePath;
- (NSString*)getDocumentsPath;
- (void)showDirections;
- (void)setMarkTheSpotViewController;
- (void)setDirectionsViewController;
- (void)setConfigViewController;
- (void)setMarkOrDirectionsViewController;
- (void)setViewController:(UIViewController*)viewController;
- (BOOL)hasStoredLocation;
- (BOOL)hasLocation;
- (BOOL)showDirectionsWarning;

@end

