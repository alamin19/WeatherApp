//
//  DescriptionVC.m
//  WeatherApp
//
//  Created by Saddam Al Amin on 3/19/18.
//  Copyright © 2018 Saddam Al Amin. All rights reserved.
//

#import "DescriptionVC.h"

@interface DescriptionVC ()

@end

@implementation DescriptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:TRUE];
    
    self.lblDay.text = self.strDay;
    self.lblHighTemp.text = self.strHigh;
    self.lblLowTemp.text = self.strLow;
    self.lblDescription.text = self.strDesc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnBackClicked:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:TRUE];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
