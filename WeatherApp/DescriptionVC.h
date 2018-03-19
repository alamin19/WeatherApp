//
//  DescriptionVC.h
//  WeatherApp
//
//  Created by Saddam Al Amin on 3/19/18.
//  Copyright © 2018 Saddam Al Amin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DescriptionVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblDay;
@property (weak, nonatomic) IBOutlet UILabel *lblHighTemp;
@property (weak, nonatomic) IBOutlet UILabel *lblLowTemp;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;

@property (strong, nonatomic) NSString *strDay;
@property (strong, nonatomic) NSString *strHigh;
@property (strong, nonatomic) NSString *strLow;
@property (strong, nonatomic) NSString *strDesc;

@end
