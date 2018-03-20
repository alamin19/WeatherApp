//
//  WeatherAppUITests.m
//  WeatherAppUITests
//
//  Created by  Al Amin on 3/19/18.
//  Copyright © 2018  Al Amin. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface WeatherAppUITests : XCTestCase

@property (nonatomic) ViewController *vcToTest;

@end

@interface ViewController (Test)

- (IBAction) setBtnCity:(UIButton *)btnCity;
- (IBAction) setBtnState:(UIButton *)btnState;

@end

@implementation WeatherAppUITests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.vcToTest = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void) testStateSelected
{
    NSString *strState = [self.vcToTest getState];
    XCTAssert(strState.length <= 0,"Please select state");
}

- (void) testCitySelected
{
    NSString *strCity = [self.vcToTest getCity];
    XCTAssert(strCity.length <= 0,"Please select city");
}

@end
