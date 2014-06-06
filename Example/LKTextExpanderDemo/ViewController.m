//
//  ViewController.m
//  LKTextExpanderDemo
//
//  Created by Hiroshi Hashiguchi on 2014/06/05.
//  Copyright (c) 2014年 lakesoft. All rights reserved.
//

#import "ViewController.h"
#import "LKTextExpander.h"

@interface ViewController () <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) SMTEDelegateController* textExpander;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [LKTextExpander.sharedInstance setTextView:self.textView nextDelegate:self];
    
    [self.textView becomeFirstResponder];
}
- (IBAction)getSnippets:(id)sender {
    [LKTextExpander.sharedInstance getSnippetsWithScheme:@"LKTextExpanderDemo-get-snippets-xc"];
}
- (IBAction)changedEnabled:(UISwitch*)sender {
    LKTextExpander.expansionEnabled = sender.on;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    return YES;
}


@end
