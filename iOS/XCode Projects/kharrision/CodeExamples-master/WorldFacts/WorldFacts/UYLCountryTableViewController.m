//
//  UYLCountryTableViewController.m
//  WorldFacts
//
//  Created by Keith Harrison http://useyourloaf.com
//  Copyright (c) 2012 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  Neither the name of Keith Harrison nor the names of its contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDER ''AS IS'' AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 


#import "UYLCountryTableViewController.h"
#import "UYLCountryViewController.h"
#import "Country+Extensions.h"

@interface UYLCountryTableViewController () <NSFetchedResultsControllerDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSNumberFormatter *decimalFormatter;
@property (strong, nonatomic) NSArray *filteredList;
@property (strong, nonatomic) NSFetchRequest *searchFetchRequest;

@property (strong, nonatomic) IBOutlet UITableViewCell *countryCell;
@property (strong, nonatomic) UINib *countryCellNib;

typedef NS_ENUM(NSInteger, UYLWorldFactsSearchScope)
{
    searchScopeCountry = 0,
    searchScopeCapital = 1
};

@end

@implementation UYLCountryTableViewController

static NSString *UYLNibCountryCellIdentifier = @"UYLNibCountryCellIdentifier";
static NSString *UYLCountryCellIdentifier = @"UYLCountryCellIdentifier";
static NSString *UYLSegueShowCountry = @"UYLSegueShowCountry";

#define UYL_COUNTRYCELLTAG_NAME     100
#define UYL_COUNTRYCELLTAG_CAPITAL  200
#define UYL_COUNTRYCELLTAG_POP      300

#pragma mark -
#pragma mark === View Life Cycle Management ===
#pragma mark -

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"World", @"World");

    // When not using storyboards the following two lines load and register the NIB
    // for the country cell.
    
    // UINib *countryNib = [UINib nibWithNibName:@"CountryCell" bundle:nil];
    // [self.tableView registerNib:countryNib forCellReuseIdentifier:UYLCountryCellIdentifier];
}

// viewDidUnload is deprecated in iOS 6
//- (void)viewDidUnload
//{
//    [super viewDidUnload];
//    self.decimalFormatter = nil;
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:UYLSegueShowCountry])
    {
        Country *country = nil;
        if (self.searchDisplayController.isActive)
        {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForCell:sender];
            country = [self.filteredList objectAtIndex:indexPath.row];
        }
        else
        {
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
            country = [self.fetchedResultsController objectAtIndexPath:indexPath];
        }
        UYLCountryViewController *viewController = segue.destinationViewController;
        viewController.country = country;
    }
}

- (void)didReceiveMemoryWarning
{
    self.searchFetchRequest = nil;
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark === Accessors ===
#pragma mark -

- (UINib *)countryCellNib
{
    if (!_countryCellNib)
    {
        _countryCellNib = [UINib nibWithNibName:@"CountryCell" bundle:nil];
    }
    return _countryCellNib;
}

- (NSNumberFormatter *)decimalFormatter
{
    if (!_decimalFormatter)
    {
        _decimalFormatter = [[NSNumberFormatter alloc] init];
        [_decimalFormatter setNumberStyle:NSNumberFormatterDecimalStyle];        
    }
    return _decimalFormatter;
}

- (NSFetchRequest *)searchFetchRequest
{
    if (_searchFetchRequest != nil)
    {
        return _searchFetchRequest;
    }
    
    _searchFetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:self.managedObjectContext];
    [_searchFetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [_searchFetchRequest setSortDescriptors:sortDescriptors];
    
    return _searchFetchRequest;
}

#pragma mark -
#pragma mark === UITableViewDataSource Delegate Methods ===
#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        return [[self.fetchedResultsController sections] count];
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    }
    else
    {
        return [self.filteredList count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Note that here we are not using the tableView parameter to retrieve a new table view cell. Instead
    // we always use self.tableView. This is necessary as our custom table view cell defined in the
    // storyboard and is not registered with the search results table view but only with the original
    // table.
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:UYLCountryCellIdentifier];

    // *******************************************************************************
    // If you are targetting iOS 5 there is a serious bug here with VoiceOver active!!
    // *******************************************************************************

    // A bug in iOS 5 causes the above call to not return with a new cell when VoiceOver is active.
    // We therefore fallback to the old mechanism of manually loading the cell from the NIB file.

    // Unfortunately this has two side effects. Firstly we need to manually perform the segue
    // when the row is selected. To ensure we only do that for the cells loaded manually we
    // need to use a different reuseIdentifer.
    
    // More seriously since the reuse mechanism does not work when VoiceOver is active
    // new cells are allocated each time the table is reloaded or scrolled and never reused.

    if (cell == nil)
    {
        // The following call should return cells for reuse but when VoiceOver is active
        // it always returns nil
        
        cell = [self.tableView dequeueReusableCellWithIdentifier:UYLNibCountryCellIdentifier];
        
        if (cell == nil)
        {
            [self.countryCellNib instantiateWithOwner:self options:nil];
            cell = self.countryCell;
            self.countryCell = nil;
        }
    }

    Country *country = nil;
    if (tableView == self.tableView)
    {
        country = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }
    else
    {
        country = [self.filteredList objectAtIndex:indexPath.row];
    }
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:UYL_COUNTRYCELLTAG_NAME];
    nameLabel.text = country.name;

    UILabel *capLabel = (UILabel *)[cell viewWithTag:UYL_COUNTRYCELLTAG_CAPITAL];
    capLabel.text = country.capital;

    UILabel *popLabel = (UILabel *)[cell viewWithTag:UYL_COUNTRYCELLTAG_POP];
    NSString *population = [self.decimalFormatter stringFromNumber:country.population];
    popLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Pop: %@", @"Pop:"), population];   
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView)
    {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo name];
    }
    else
    {
        return nil;
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView)
    {
        NSMutableArray *index = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
        NSArray *initials = [self.fetchedResultsController sectionIndexTitles];
        [index addObjectsFromArray:initials];
        return index;
    }
    else
    {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    if (tableView == self.tableView)
    {
        if (index > 0)
        {
            // The index is offset by one to allow for the extra search icon inserted at the front
            // of the index
            
            return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index-1];
        }
        else
        {
            // The first entry in the index is for the search icon so we return section not found
            // and force the table to scroll to the top.
            
            self.tableView.contentOffset = CGPointZero;
            return NSNotFound;
        }
    }
    else
    {
        return 0;
    }
}

#pragma mark -
#pragma mark === UITableViewDelegate ===
#pragma mark -

// The following method is implemented as a workaround for the iOS 5 bug when dequeuing
// cells with VoiceOver active. When the cell is not loaded from the storyboard
// we need to manually perform the segue.

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.reuseIdentifier isEqualToString:UYLNibCountryCellIdentifier])
    {
        [self performSegueWithIdentifier:UYLSegueShowCountry sender:cell];
    }
}

#pragma mark -
#pragma mark === Fetched Results Controller ===
#pragma mark -

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil)
    {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                          managedObjectContext:self.managedObjectContext 
                                                                            sectionNameKeyPath:@"sectionTitle"
                                                                                     cacheName:@"Country"];
    frc.delegate = self;
    self.fetchedResultsController = frc;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error])
    {
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	}
    
    return _fetchedResultsController;
}    

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark === UISearchDisplayDelegate ===
#pragma mark -

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    UYLWorldFactsSearchScope scopeKey = controller.searchBar.selectedScopeButtonIndex;
    [self searchForText:searchString scope:scopeKey];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    NSString *searchString = controller.searchBar.text;
    [self searchForText:searchString scope:searchOption];
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    tableView.rowHeight = 64;
}

- (void)searchForText:(NSString *)searchText scope:(UYLWorldFactsSearchScope)scopeOption
{
    if (self.managedObjectContext)
    {
        NSString *predicateFormat = @"%K BEGINSWITH[cd] %@";
        NSString *searchAttribute = @"name";
        
        if (scopeOption == searchScopeCapital)
        {
            searchAttribute = @"capital";
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateFormat, searchAttribute, searchText];
        [self.searchFetchRequest setPredicate:predicate];
        
        NSError *error = nil;
        self.filteredList = [self.managedObjectContext executeFetchRequest:self.searchFetchRequest error:&error];
        if (error)
        {
            NSLog(@"searchFetchRequest failed: %@",[error localizedDescription]);
        }
    }
}

@end
