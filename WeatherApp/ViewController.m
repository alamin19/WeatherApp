//
//  ViewController.m
//  WeatherApp
//
//  Created by  Al Amin on 3/19/18.
//  Copyright © 2018 Al Amin. All rights reserved.
//

#import "ViewController.h"



@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btnState;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property NSInteger selectedState;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _selectedState = 0;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods -

- (IBAction)btnStateClicked:(UIButton *)sender {
    
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"State" message:@"Select state" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"MD" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.selectedState = 1;
        [self.btnState setTitle:@"MD" forState: UIControlStateNormal];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"MO" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.selectedState = 2;
        [self.btnState setTitle:@"MO" forState: UIControlStateNormal];
        
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"TX" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        self.selectedState = 3;
        [self.btnState setTitle:@"TX" forState: UIControlStateNormal];
    }]];
    
    [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
        // OK button tapped.
        
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }]];
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
                
                [self.btnCity setTitle:@"Silver Spring" forState: UIControlStateNormal];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Greenbelt" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [self.btnCity setTitle:@"Greenbelt" forState: UIControlStateNormal];
                
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Annapolis" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
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
                
                [self.btnCity setTitle:@"Jefferson City" forState: UIControlStateNormal];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Saint Louis" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [self.btnCity setTitle:@"Saint Louis" forState: UIControlStateNormal];
                
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Cape Girardeau" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
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
                
                [self.btnCity setTitle:@"Dalls" forState: UIControlStateNormal];
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Huston" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
                [self.btnCity setTitle:@"Huston" forState: UIControlStateNormal];
                
            }]];
            
            [actionSheet addAction:[UIAlertAction actionWithTitle:@"Austin" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
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
    
}






@end
