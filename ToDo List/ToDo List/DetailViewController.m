//
//  ViewController.m
//  ToDo List
//
//  http://devtype.blogspot.com/2016/02/Razrabotka-mobilnogo-prilozheniya-dlya-iPhone.html
//  Copyright © 2016 DEVTYPE. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;

@end


@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.datePicker.minimumDate = [NSDate date];
    [self.datePicker addTarget:self
                        action:@selector(datePickerValueChanged)
              forControlEvents:UIControlEventValueChanged];
    
    [self.buttonSave addTarget:self
                        action:@selector(save)
              forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *handleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
        action:@selector(handleEndEditing)];
    [self.view addGestureRecognizer:handleTap];
}

- (void)datePickerValueChanged
{
    // метод, который будет вызываться при прокручивании UIDatePicker
    
    self.eventDate = self.datePicker.date;
    NSLog(@"date Picker %@", self.eventDate);
}

- (void)handleEndEditing
{
    // свернуть текстовое поле по тапу (касанию) на бэкграунд мобильного приложения
    [self.view endEditing:YES];
    // [self.textField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save {
    NSString *eventInfo = self.textField.text;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm dd.MMMM.yyyy"];
    NSString *eventDate = [formatter stringFromDate:self.eventDate];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:eventInfo, @"eventInfo", eventDate, @"eventDate", nil];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.userInfo = dict;
    notification.timeZone = [NSTimeZone defaultTimeZone];
    notification.fireDate = self.eventDate;
    notification.alertBody = eventInfo;
    notification.applicationIconBadgeNumber = 1;
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField isEqual:self.textField]) {
        [textField resignFirstResponder]; // свернуть текстовое поле
    }
    return YES;
}

@end
