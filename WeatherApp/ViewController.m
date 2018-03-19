//
//  ViewController.m
//  WeatherApp
//
//  Created by  Al Amin on 3/19/18.
//  Copyright © 2018 Al Amin. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "DescriptionVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _selectedState = 0;
    
    [self setupLocationManager];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"description"]) {
        
        NSIndexPath *selectedRow = [[self tblView] indexPathForSelectedRow];
        DescriptionVC *vc = [segue destinationViewController];
        
        NSDictionary *weatherDic = [self.forecastArray objectAtIndex:selectedRow.row];
        
        // lookup the weekday in JSON file, and show in UILabel with tag number
        NSDictionary *weatherDate = [weatherDic objectForKey:@"date"];
        NSString *weekday = [weatherDate objectForKey:@"weekday"];
        vc.strDay = weekday;
        
        // lookup the high temp in JSON file, and show in UILabel with tag number
        NSDictionary *weatherHigh = [weatherDic objectForKey:@"high"];
        NSString *high = [weatherHigh objectForKey:@"fahrenheit"];
        vc.strHigh = high;
        
        // lookup the low temp in JSON file, and show in UILabel with tag number
        NSDictionary *weatherLow = [weatherDic objectForKey:@"low"];
        NSString *low = [weatherLow objectForKey:@"fahrenheit"];
        vc.strLow = low;
        
        NSDictionary *weatherDesc = [self.descArray objectAtIndex:selectedRow.row];
        NSString *strDesc = [weatherDesc objectForKey:@"fcttext_metric"];
        vc.strDesc = strDesc;
    }
    
}

#pragma mark - Setup Location Manager -

- (void) setupLocationManager {
    // Set up the location Manager
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0; // meters
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        self.longitudeStr = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        self.latitudeStr = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        //NSLog(@"%@", self.longitudeStr);
//        NSString *apiKeyStr = @"bcb59c17e32647d4";
//        NSString *urlRequestTemple = @"http://api.wunderground.com/api/bcb59c17e32647d4/forecast10day/q/CA/San_Francisco.json";
//        [self fetchTenDayJSONfromInternet: [NSString stringWithFormat:urlRequestTemple, apiKeyStr, @"forecast10day", self.latitudeStr, self.longitudeStr]];
        
    } else {
        
    }
}

-(void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    CLAuthorizationStatus currentStatus = [CLLocationManager authorizationStatus];
    if ((currentStatus != kCLAuthorizationStatusAuthorizedWhenInUse) && (currentStatus != kCLAuthorizationStatusAuthorizedAlways) && currentStatus == kCLAuthorizationStatusDenied) {
        
    }
}

#pragma mark - Custom Methods -

- (void)fetchTenDayJSONfromInternet: (NSString *)urlStr  {
    // Url fetch data
    NSURL *url = [NSURL URLWithString:urlStr];
    //NSLog(@"\nURL: %@", urlStr);
    
    
    // Grand Central Dispatch
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *tenDay = [NSData dataWithContentsOfURL:url options:kNilOptions error:nil];
        NSDictionary *mainDic = [NSJSONSerialization JSONObjectWithData:tenDay options:NSJSONReadingAllowFragments error:nil];
        
        NSDictionary *responseDic = [mainDic objectForKey:@"response"];
        if([responseDic objectForKey:@"error"]) {
            return;
        }
        NSDictionary *forecastDic = [mainDic objectForKey:@"forecast"];
        
        NSDictionary *txtForecastDic = [forecastDic objectForKey:@"txt_forecast"];
        self.descArray = [txtForecastDic objectForKey:@"forecastday"];
        
        NSDictionary *simpleForecastDic = [forecastDic objectForKey:@"simpleforecast"];
        self.forecastArray = [simpleForecastDic objectForKey:@"forecastday"];
        dispatch_async(dispatch_get_main_queue(), ^{
            // show today forecast data
            self.tblView.dataSource = self;
            self.tblView.delegate = self;
            [self.tblView reloadData];
        });
    });
}

#pragma mark - Action Methods -

- (IBAction)btnStateClicked:(UIButton *)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"State" message:@"Select state" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"MD" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.strState = @"MD";
        self.selectedState = 1;
        [self.btnState setTitle:@"MD" forState: UIControlStateNormal];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"MO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.strState = @"MO";
        self.selectedState = 2;
        [self.btnState setTitle:@"MO" forState: UIControlStateNormal];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"TX" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.strState = @"TX";
        self.selectedState = 3;
        [self.btnState setTitle:@"TX" forState: UIControlStateNormal];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // OK button tapped.
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
    
    self.selectedCity = 0;
    [self.btnCity setTitle:@"Select City" forState: UIControlStateNormal];
    [self presentViewController:actionSheet animated:YES completion:nil];
}

- (IBAction)btnCityClicked:(UIButton *)sender {
    
    if (self.selectedState == 0) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Weather App"
                                                                       message:@"Please select state first"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        
        if (self.selectedState == 1) {
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"City" message:@"Select city" preferredStyle:UIAlertControllerStyleActionSheet];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Silver Spring" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.strCity = @"Silver Spring";
                self.selectedCity = 1;
                [self.btnCity setTitle:@"Silver Spring" forState: UIControlStateNormal];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Greenbelt" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.strCity = @"Greenbelt";
                self.selectedCity = 2;
                [self.btnCity setTitle:@"Greenbelt" forState: UIControlStateNormal];
                
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Annapolis" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.strCity = @"Annapolis";
                self.selectedCity = 3;
                [self.btnCity setTitle:@"Annapolis" forState: UIControlStateNormal];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                // OK button tapped.
                
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            }]];
            
            [self presentViewController:actionSheet animated:YES completion:nil];
        } else if (self.selectedState == 2) {
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"City" message:@"Select city" preferredStyle:UIAlertControllerStyleActionSheet];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Jefferson City" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.strCity = @"Jefferson City";
                self.selectedCity = 4;
                [self.btnCity setTitle:@"Jefferson City" forState: UIControlStateNormal];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Saint Louis" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.strCity = @"Saint Louis";
                self.selectedCity = 5;
                [self.btnCity setTitle:@"Saint Louis" forState: UIControlStateNormal];
                
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cape Girardeau" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.strCity = @"Cape Girardeau";
                self.selectedCity = 6;
                [self.btnCity setTitle:@"Cape Girardeau" forState: UIControlStateNormal];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                // OK button tapped.
                
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            }]];
            
            [self presentViewController:actionSheet animated:YES completion:nil];
        } else {
            UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"City" message:@"Select city" preferredStyle:UIAlertControllerStyleActionSheet];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Dallas" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.strCity = @"Dallas";
                self.selectedCity = 7;
                [self.btnCity setTitle:@"Dallas" forState: UIControlStateNormal];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Houston" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.strCity = @"Houston";
                self.selectedCity = 8;
                [self.btnCity setTitle:@"Houston" forState: UIControlStateNormal];
                
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Austin" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                self.strCity = @"Austin";
                self.selectedCity = 9;
                [self.btnCity setTitle:@"Austin" forState: UIControlStateNormal];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                // OK button tapped.
                
                [self dismissViewControllerAnimated:YES completion:^{
                }];
            }]];
            
            [self presentViewController:actionSheet animated:YES completion:nil];
        }
    }
}

- (IBAction)btnSubmitClicked:(UIButton *)sender {
    
    
    if (_selectedState == 0 || _selectedCity == 0) {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Weather App"
                                                                       message:@"Please select start and city both"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    } else {
        
        NSString *apiKeyStr = @"bcb59c17e32647d4";
        NSString *urlRequestTemple = [NSString stringWithFormat:@"http://api.wunderground.com/api/bcb59c17e32647d4/forecast10day/q/%@/%@.json",self.strState,self.strCity];
        urlRequestTemple = [urlRequestTemple stringByReplacingOccurrencesOfString:@" " withString:@"_"];
        NSLog(@"%@",urlRequestTemple);
        [self fetchTenDayJSONfromInternet: [NSString stringWithFormat:urlRequestTemple, apiKeyStr, @"forecast10day", self.latitudeStr, self.longitudeStr]];
    }
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // first forecast is Today, the tableView contains next 9 days
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = (TableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TableViewCell"];
    
    // Configure the daily forecast
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TableViewCell"];
    }
    
    // start from next one (first one is today forecast)
    long index = indexPath.row;
    // Display the weather info on the table view cell
    NSDictionary *weatherDic = [self.forecastArray objectAtIndex:index];
    
    
    // lookup the weekday in JSON file, and show in UILabel with tag number
    NSDictionary *weatherDate = [weatherDic objectForKey:@"date"];
    NSString *weekday = [weatherDate objectForKey:@"weekday"];
    cell.lblDay.text = weekday;
    
    // lookup the high temp in JSON file, and show in UILabel with tag number
    NSDictionary *weatherHigh = [weatherDic objectForKey:@"high"];
    NSString *high = [weatherHigh objectForKey:@"fahrenheit"];
    cell.lblHighTemp.text = high;
    
    // lookup the low temp in JSON file, and show in UILabel with tag number
    NSDictionary *weatherLow = [weatherDic objectForKey:@"low"];
    NSString *low = [weatherLow objectForKey:@"fahrenheit"];
    cell.lblLowTemp.text = low;
    
    NSDictionary *weatherDesc = [self.descArray objectAtIndex:index];
    NSString *strDesc = [weatherDesc objectForKey:@"fcttext_metric"];
    cell.lblDesc.text = strDesc;
    
    // lookup the icon and choose the Weather icon in UIImageView
//    NSString *weatherIcon = [weatherDic objectForKey:@"icon"];
//    UIImageView *dailyWeather = (UIImageView *)[cell viewWithTag:201];
//    dailyWeather.image = [UIImage imageNamed:weatherIcon];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"description" sender:self];
}



@end
