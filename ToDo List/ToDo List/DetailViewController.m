//
//  ViewController.m
//  ToDo List
//
//  http://devtype.blogspot.com/2016/02/Razrabotka-mobilnogo-prilozheniya-dlya-iPhone.html
//  Copyright © 2016 DEVTYPE. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *buttonSave;

@end


@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.buttonSave addTarget:self
                        action:@selector(save)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save {
    NSLog(@"save");
}

@end
