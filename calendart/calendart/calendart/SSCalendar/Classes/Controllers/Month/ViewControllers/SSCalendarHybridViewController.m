//
//  SSCalendarHybridViewController.m
//  calendart
//
//  Created by Good on 28/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

#import "SSCalendarHybridViewController.h"
#import "SSCalendarHybridDataSource.h"

#import "SSYearNode.h"
#import "SSMonthNode.h"
#import "SSCalendarMonthlyHeaderView.h"
#import "SSConstants.h"
#import "SSCalendarDayCell.h"
#import "SSDataController.h"

@interface SSCalendarHybridViewController ()
@property (nonatomic, strong) SSDataController *dataController;

@end

@implementation SSCalendarHybridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = [[SSCalendarHybridDataSource alloc] initWithView:_yearView];
    _yearView.dataSource = _dataSource;
    _yearView.delegate = self;
    
    _dataSource.years = _years;
    
    [self refresh];
    _yearView.delegate = self;
    
    //_dataSource.years = _years;
    
    [self refresh];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refresh
{
    SSCalendarCountCache *calendarCounts = _dataController.calendarCountCache;
    if (calendarCounts != nil)
    {
        [_dataController updateCalendarYears];
        [_yearView reloadData];
    }
}

- (id)initWithEvents:(NSArray *)events
{
    NSBundle *bundle = [SSCalendarUtils calendarBundle];
    if (self = [super initWithNibName:@"SSCalendarAnnualViewController" bundle:bundle]) {
        self.dataController = [[SSDataController alloc] init];
        [_dataController setEvents:events];
        self.years = _dataController.calendarYears;
        
    }
    return self;
}


@end
