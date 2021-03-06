//
//  CarListSelectorViewController.m
//  CarAssist
//
//  Created by 0witt on 07.12.12.
//  Copyright (c) 2012 Gruppe Fear. All rights reserved.
//

#import "CarListSelectorViewController.h"
#import "Profile.h"
#import "Utils.h"

@interface CarListSelectorViewController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (nonatomic) Car* selectedCar;

@end

@implementation CarListSelectorViewController

- (id)initWithDelegate:(NSObject<CarListSelectorDelegate>*) delegate 
{
    self = [super init];
    if (self) {

        self.carListService = [CarListService getCarListService];
        self.delegate = delegate;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Fahrzeuge";
    
     
    
    // Hintergrundgrafik einbinden
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[Utils imageWithImage:[UIImage imageNamed:@"background_gelb"] scaledToSize:[[UIScreen mainScreen] bounds].size]];
    
    //TableView
    self.carSelectionTableView.separatorColor = [UIColor blackColor];
    
    // TapRecognizer, der bei jedem Tab auf unsere View (ausserhalb des Keyboards) das Keyboard schließt.
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapAnywhere:)];
    NSNotificationCenter* nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(keyboardWillShow:) name:
     UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(keyboardWillHide:) name:
     UIKeyboardWillHideNotification object:nil];
    
    
    
    if (![Profile getProfile].car) {
        [[[self.tabBarController.tabBar items] objectAtIndex: 0] setEnabled: NO];
        [[[self.tabBarController.tabBar items] objectAtIndex: 1] setEnabled: NO];
        [[[self.tabBarController.tabBar items] objectAtIndex: 2] setEnabled: NO];
        [[[self.tabBarController.tabBar items] objectAtIndex: 3] setEnabled: NO];
    }
}

-(void) keyboardWillShow:(NSNotification*) note
{
    [self.view addGestureRecognizer:self.tapRecognizer];
}

-(void) keyboardWillHide:(NSNotification*) note
{
    [self.view removeGestureRecognizer:self.tapRecognizer];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.carListService.cars allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString* producer = [[self.carListService.cars allKeys] objectAtIndex:section];
    NSArray* modelsFromProducer = [self.carListService.cars objectForKey:producer];
    return modelsFromProducer.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"standard"];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"standard"];
    }
        
    NSString* producer = [[self.carListService.cars allKeys] objectAtIndex:indexPath.section];
    NSArray* modelsFromProducer = [self.carListService.cars objectForKey:producer];
    Car* currentModel = [modelsFromProducer objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = currentModel.model;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
        
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSArray *keys = [self.carListService.cars allKeys];
    NSString *key = [keys objectAtIndex:section];
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 22)];
    //!todo hier noch schöneren Hintergrund einbauen
    sectionView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:sectionView.frame];
    label.textColor = [UIColor blackColor];
    label.backgroundColor = [UIColor clearColor];
    label.text = key;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:18];
    
    sectionView.backgroundColor = [[UIColor alloc] initWithPatternImage:[Utils imageWithImage:[UIImage imageNamed:@"section_gelb"] scaledToSize: sectionView.frame.size]];
    
    [sectionView addSubview:label];
    return sectionView;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString* producer = [[self.carListService.cars allKeys] objectAtIndex:indexPath.section];
    NSArray* modelsFromProducer = [self.carListService.cars objectForKey:producer];
    Car* currentModel = [modelsFromProducer objectAtIndex:indexPath.row];
    self.selectedCar = currentModel;
    if (self.selectedCar) {
        if ([[Profile getProfile].carList containsObject:self.selectedCar])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Auto schon vorhanden!" message:@"Das gewählte Auto ist bereits vorhanden, wählen Sie ein anderes." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            [self.delegate carHasBeenSelected:self.selectedCar];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Kein Auto gewählt!" message:@"Bitte wählen Sie ein Auto aus." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }

}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self.carListService reduceCarsWithSearchText: searchText];
    [self.carSelectionTableView reloadData];
}

/**
 * Schließt das Keyboard, wenn Suchen gedrückt wird.
 */
- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.carSearchBar resignFirstResponder];
}

/**
 * Schließt das Keyboard.
 */
-(void)didTapAnywhere: (UITapGestureRecognizer*) recognizer {
    [self.carSearchBar resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[[self.tabBarController.tabBar items] objectAtIndex: 0] setEnabled: YES];
    [[[self.tabBarController.tabBar items] objectAtIndex: 1] setEnabled: YES];
    [[[self.tabBarController.tabBar items] objectAtIndex: 2] setEnabled: YES];
    [[[self.tabBarController.tabBar items] objectAtIndex: 3] setEnabled: YES];

}



@end
