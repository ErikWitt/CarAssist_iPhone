//
//  WarningViewController.m
//  CarAssist
//
//  Created by 0witt on 30.11.12.
//  Copyright (c) 2012 Gruppe Fear. All rights reserved.
//

#import "WarningCategoryViewController.h"
#import "WarningLightCollectionViewController.h"
#import "AuthorizedRepairCategoryViewController.h"
#import <MapKit/MapKit.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "RoadsideAssistanceViewController.h"
#import "CallAlertView.h"

#import "Utils.h"
#import "Profile.h"
#import "CallAlertView.h"




@interface WarningCategoryViewController () <UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate>

@end

@implementation WarningCategoryViewController


- (void)viewDidLoad
{
 
    [super viewDidLoad];
    self.title = @"Störungen";
    
    // Hintergrundgrafik einbinden
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[Utils imageWithImage:[UIImage imageNamed:@"background_stoerung_hell"] scaledToSize:[[UIScreen mainScreen] bounds].size]];
    
    //TableView
    self.warningCatergoryTableView.separatorColor = [UIColor blackColor];
    
    // Anmeldung als Beobachter, wenn der Standard-Wagen geändert wurde
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(defaultCarChanged:) name:@"defaultCarChanged" object:nil];
}
-(void)dealloc
{
    // Abmeldung am NotificationCenter, wenn das Objekt selbst gelöscht wird
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// Nachricht defaultCarChanged behandeln
-(void)defaultCarChanged:(NSNotification *)notification
{
    [self.navigationController popToViewController:self animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"standard"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"standard"];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.backgroundColor = [UIColor clearColor];
    }
    
    UIImage* warningLightCategoryImage = [UIImage  imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"warnleuchte_58x58" ofType:@"png"]];
    UIImage* breakdownServiceCategoryImage = [UIImage  imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pannenhilfe_58x58" ofType:@"png"]];
    UIImage* authorizedRepairCategoryImage = [UIImage  imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"werkstatt_58x58" ofType:@"png"]];
    UIImage* personalInformationCategoryImage = [UIImage  imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"einstellungen_58x58" ofType:@"png"]];

    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Warnleuchten";
            [cell.imageView setImage:warningLightCategoryImage];
            break;
        case 1:
            cell.textLabel.text = @"Pannenhilfe kontaktieren";
            [cell.imageView setImage:breakdownServiceCategoryImage];
            break;
        case 2:
            cell.textLabel.text = @"Vertragswerkstätten";
            [cell.imageView setImage:authorizedRepairCategoryImage];
            break;
        case 3:
            cell.textLabel.text = @"Persönliche Informationen";
            [cell.imageView setImage:personalInformationCategoryImage];
            break;
        default:
            cell.textLabel.text = @"Einer zu viel :P";
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        WarningLightCollectionViewController* viewController = [[WarningLightCollectionViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if(indexPath.row == 1)
    {
        CallAlertView *alert = [[CallAlertView alloc] initCall:self.navigationController andMessage: nil];
                                [alert show];
    }
    if(indexPath.row == 2)
    {
        AuthorizedRepairCategoryViewController* viewController = [[AuthorizedRepairCategoryViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if(indexPath.row == 3)
    {
        RoadsideAssistanceViewController* viewController = [[RoadsideAssistanceViewController alloc] init];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}


@end
