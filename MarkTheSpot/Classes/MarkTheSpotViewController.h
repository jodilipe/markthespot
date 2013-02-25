//
//  MarkTheSpotViewController.h
//  MarkTheSpot
//
//  Created by Jon Pedersen on 27/10/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarkTheSpotAppDelegate.h"

@interface MarkTheSpotViewController : UIViewController {
	IBOutlet UIButton *button;
	IBOutlet UILabel *accuracy;
	MarkTheSpotAppDelegate *delegate;
}

@property (nonatomic, retain) UIButton *button;
@property (nonatomic, retain) UILabel *accuracy;
@property (nonatomic, retain) MarkTheSpotAppDelegate *delegate;

- (void)viewDidLoad;
- (void)buttonPressed:(id)sender;
- (void)setNewAccuracy:(int)newAccuracy;

@end

