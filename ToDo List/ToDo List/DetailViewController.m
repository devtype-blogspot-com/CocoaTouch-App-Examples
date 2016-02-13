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
    
    if (self.isDetail) {
        self.textField.text = self.eventInfo;
        self.datePicker.date = self.eventDate;
    } else {
        self.buttonSave.userInteractionEnabled = NO;
        
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
}

- (void)datePickerValueChanged
{
    // метод, который будет вызываться при прокручивании UIDatePicker
    
    self.eventDate = self.datePicker.date;
    NSLog(@"date Picker %@", self.eventDate);
}

- (void)handleEndEditing
{
    if (self.textField.text.length != 0) {
        [self.view endEditing:YES];
        self.buttonSave.userInteractionEnabled = YES;
    } else {
        [self showAlertWithMessage:@"Для сохранения события введите значение в текстовое поле"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save {
    if (self.eventDate) {
        if ([self.eventDate compare:[NSDate date]] == NSOrderedSame) {
            [self showAlertWithMessage:@"Дата будущего события не может совпадать с текущей датой"];
        } else if ([self.eventDate compare:[NSDate date]] == NSOrderedAscending) {
            [self showAlertWithMessage:@"Дата будущего события не может быть ранее текущей даты"];
        } else {
            [self setNotification];
        }
    } else {
        [self showAlertWithMessage:@"Для сохранения события измените значение даты на более позднее"];
    }
}

- (void)setNotification
{
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
        if (textField.text.length != 0) {
            [textField resignFirstResponder]; // свернуть текстовое поле
            self.buttonSave.userInteractionEnabled = YES;
            return YES;
        } else {
            [self showAlertWithMessage:@"Для сохранения события введите значение в текстовое поле"];
        }
    }
    
    return NO;
}

- (void)showAlertWithMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Внимание!"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK"
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * __nonnull action) {}];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
