//
//  AuthorizedRepairService.m
//  CarAssist
//
//  Created by Dennis on 21.12.12.
//  Copyright (c) 2012 Gruppe Fear. All rights reserved.
//

#import "AuthorizedRepairService.h"
#import "AuthorizedRepair.h"

@implementation AuthorizedRepairService
-(SearchableService*) initWithCar:(Car *) car
{
    self = [super initWithCar:car];
    if(self)
    {
        switch (car.unid)
        {
            case 1:
                [self initServiceWithExampleDataBmwZ4];
                [self initDictionary];
                break;
            case 2:
                [self initServiceWithExampleDataVWGolfIV];
                [self initDictionary];
                break;
            default:
                @throw [NSException exceptionWithName:@"NotImplementedException" reason:@"no service data for selected car" userInfo:nil];
                break;
        }
    }
    return self;
}



- (void) initServiceWithExampleDataVWGolfIV
{
    NSMutableArray* allItems = [NSMutableArray array];
    
    AuthorizedRepair *garage = [[AuthorizedRepair alloc] initWithName:@"Filiale Eimsbüttel" Category:@"Hamburg" andLocation: CLLocationCoordinate2DMake(53.5694437, 9.9590983)];
    
    garage.street = @"Fruchtallee 29";
    garage.postalcode = @"20259";
    garage.city = @"Hamburg";
    garage.phone = @"040 / 43 172 - 0";
    
    [allItems addObject:garage];
    
    garage = [[AuthorizedRepair alloc] initWithName:@"Filiale Winterhude" Category:@"Hamburg" andLocation:
              CLLocationCoordinate2DMake(53.58939, 10.02297)];

    garage.street = @"Wiesendamm 120";
    garage.postalcode = @"22303";
    garage.city = @"Hamburg";
    garage.phone = @"040 / 270 798 - 0";
    
    [allItems addObject:garage];


    garage = [[AuthorizedRepair alloc] initWithName:@"Filiale Ahrensburg" Category:@"Schleswig-Holstein" andLocation:
              CLLocationCoordinate2DMake(53.58939, 10.02297)];
    
    garage.street = @"Hamburger Straße 40";
    garage.postalcode = @"22926";
    garage.city = @"Ahrensburg";
    garage.phone = @"041 02 / 51 54 - 0";
    
    [allItems addObject:garage];

    garage = [[AuthorizedRepair alloc] initWithName:@"Filiale Harburg" Category:@"Hamburg" andLocation:
              CLLocationCoordinate2DMake(53.46243, 10.01227)];
    
    garage.street = @"Großmoorbogen 1a";
    garage.postalcode = @"21079";
    garage.city = @"Harburg";
    garage.phone = @"040 / 766 07 - 0";
    
    [allItems addObject:garage];
    
    
    self.allItems = allItems;
    self.reducedItems = allItems;
}

- (void) initServiceWithExampleDataBmwZ4
{
    NSMutableArray* allItems = [NSMutableArray array];
    
    AuthorizedRepair *garage = [[AuthorizedRepair alloc] initWithName:@"Hauptniederlassung" Category:@"Hamburg" andLocation:
                        CLLocationCoordinate2DMake(53.60009f, 9.97196f)];
    garage.street = @"Offakamp 10-20";
    garage.postalcode = @"22529";
    garage.city = @"Hamburg";
    garage.phone = @"040 / 55301-10";
    
    [allItems addObject:garage];

    garage = [[AuthorizedRepair alloc] initWithName:@"Niederlassung Wansdsbek" Category:@"Hamburg" andLocation:
                                CLLocationCoordinate2DMake(53.58695f, 10.09423f)];
    garage.street = @"Friedrich-Ebert-Damm 120";
    garage.postalcode = @"22047";
    garage.city = @"Hamburg";
    garage.phone = @"040 / 55301-30";
    
    [allItems addObject:garage];
    
    self.allItems = allItems;
    self.reducedItems = allItems;
}

@end