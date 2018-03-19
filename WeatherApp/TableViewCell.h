//
//  TableViewCell.h
//  WeatherApp
//
//  Created by  Al Amin on 3/19/18.
//  Copyright © 2018  Al Amin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblDay;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UILabel *lblLowTemp;
@property (weak, nonatomic) IBOutlet UILabel *lblHighTemp;

@end
