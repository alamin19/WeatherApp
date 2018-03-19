//
//  AppDelegate.h
//  WeatherApp
//
//  Created by  Al Amin on 3/19/18.
//  Copyright © 2018  Al Amin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

