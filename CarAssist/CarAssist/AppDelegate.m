//
//  AppDelegate.m
//  CarAssist
//
//  Created by 0witt on 30.11.12.
//  Copyright (c) 2012 Gruppe Fear. All rights reserved.
//

#import "AppDelegate.h"
#import "StartScreenViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.manualViewController = [[ManualCategoryViewController alloc] init];
    self.manualNavigationController = [[UINavigationController alloc] initWithRootViewController:self.manualViewController];
    
    self.warningViewController = [[WarningCategoryViewController alloc] init];
    self.warningNavigationController = [[UINavigationController alloc] initWithRootViewController:self.warningViewController];
    
    self.serviceViewController = [[ServiceCategoryViewController alloc] init];
    self.serviceNavigationController = [[UINavigationController alloc] initWithRootViewController:self.serviceViewController];
    
    self.carFavoriteViewController=  [[CarFavoriteViewController alloc] init];
    self.settingsNavigationController= [[UINavigationController alloc] initWithRootViewController:self.carFavoriteViewController];
    
    
    self.tabBarController = [[UITabBarController alloc] init];

    UITabBarItem* tabBarItem0 = [[UITabBarItem alloc] initWithTitle:@"Bedienung" image:[UIImage imageNamed:@"tabbar_bedienung_small"]  tag:0];
    [self.manualNavigationController setTabBarItem:tabBarItem0];
    self.manualNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    UITabBarItem* tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"Service" image:[UIImage imageNamed:@"tabbar_service_small"]  tag:1];
    [self.serviceNavigationController setTabBarItem:tabBarItem1];
    self.serviceNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    UITabBarItem* tabBarItem2 = [[UITabBarItem alloc] initWithTitle:@"Störungen" image: [UIImage imageNamed:@"tabbar_stoerung_small"]  tag:2];
    [self.warningNavigationController setTabBarItem:tabBarItem2];
    self.warningNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    UITabBarItem* tabBarItem3 = [[UITabBarItem alloc] initWithTitle:@"Fahrzeuge" image:[UIImage imageNamed:@"tabbar_profil_small"] tag:3];
    [self.settingsNavigationController setTabBarItem:tabBarItem3];
    self.settingsNavigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    
    NSArray *viewControllers = [NSArray arrayWithObjects:self.manualNavigationController, self.serviceNavigationController,
                                self.warningNavigationController, self.settingsNavigationController, nil];
    
    self.tabBarController.viewControllers = viewControllers;
    //Die Nächste Zeile sorgt dafür, dass man im Profil startet
    self.tabBarController.selectedViewController=self.settingsNavigationController;
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];

    return YES;
}


@end
