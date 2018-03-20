//
//  ViewController.h
//  WeatherApp
//
//  Created by  Al Amin on 3/19/18.
//  Copyright © 2018  Al Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UIButton *btnState;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@property NSInteger selectedState;
@property NSInteger selectedCity;

@property (weak, nonatomic) NSString *strState;
@property (weak, nonatomic) NSString *strCity;

@property (weak, nonatomic) NSString *latitudeStr;
@property (weak, nonatomic) NSString *longitudeStr;
@property (strong, nonatomic) NSMutableArray *forecastArray;
@property (strong, nonatomic) NSMutableArray *descArray;

- (NSString *) getState;
- (NSString *) getCity;

@end

