//
//  ViewController.m
//  AiXinDemo
//
//  Created by shaofa on 14-2-17.
//  Copyright (c) 2014年 shaofa. All rights reserved.
//

#import "ViewController.h"
#import "TableView.h"
#import "ITTSegement.h"
#import "ITTModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet TableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        int num1 = rand()%100 * i;
        int num2 = 100 - rand()%5 * i;
        int num3 = rand()%50;
        ITTModel *model = [[ITTModel alloc] init];
        model.number1 = num1;
        model.number2 = num2;
        model.number3 = num3;
        [data addObject:model];
    }
    
    self.tableView.data = data;
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    NSArray *items = @[@"金额", @"利率", @"期限"];
    ITTSegement *segment = [[ITTSegement alloc] initWithItems:items];
    segment.frame = CGRectMake(0, 0, 320, 40);
    segment.selectedIndex = 0;
    [segment addTarget:self action:@selector(sgAction:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:segment];
}

-(void)sgAction:(ITTSegement *)sg
{
    NSLog(@"%d %d", sg.selectedIndex, sg.currentState);
    
    NSArray *data = self.tableView.data;
    
    for (ITTModel *model in data) {
        if (sg.currentState == UPStates) {
            model.isUp = YES;
        } else {
            model.isUp = NO;
        }
    }
    
    if (sg.selectedIndex == 0) {
        data = [data sortedArrayUsingSelector:@selector(compareNum1:)];
    } else if (sg.selectedIndex == 1) {
        data = [data sortedArrayUsingSelector:@selector(compareNum2:)];
    } else {
        data = [data sortedArrayUsingSelector:@selector(compareNum3:)];
    }
    
    self.tableView.data = data;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
