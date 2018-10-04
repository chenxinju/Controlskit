//
//  CalendarPickerViewController.m
//  CSCalendarPicker
//
//  Created by 徐呈赛 on 16/5/5.
//  Copyright © 2016年 XuChengSai. All rights reserved.
//

#import "CalendarPickerViewController.h"
#import "CSCalendarPicker.h"

@interface CalendarPickerViewController ()<CSCalendarPickerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *startTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;

@property (nonatomic,strong) CSCalendarPicker *calendarPicker;

@end

@implementation CalendarPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _calendarPicker = [CSCalendarPicker calendarPicker];
    _calendarPicker.delegate = self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
     [self.calendarPicker show];
}

- (IBAction)appearBtnClick:(UIButton *)sender {
    
    [self.calendarPicker show];
}

-(void)calendarPicker:(CSCalendarPicker *)calendarPicker didSelectStartingDate:(NSDate *)startingDate endDate:(NSDate *)endDate
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    //开始时间
    //self.startTime.text = [fmt stringFromDate:startingDate];
    //结束时间
   // self.endTime.text = [fmt stringFromDate:endDate];
    
    NSLog(@"\n开始时间=%@\n结束时间=%@",[fmt stringFromDate:startingDate],[fmt stringFromDate:endDate]);
}
@end
