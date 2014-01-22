//
//  TSWViewController.m
//  TextInput
//
//  Created by Shiehlie on 7/24/12.
//  Copyright (c) 2012 com.WiSE. All rights reserved.
//

#import "TWInputVC.h"

@interface TWInputVC () <UITextFieldDelegate, UIAlertViewDelegate, UIActionSheetDelegate, TWInputDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

@end

@implementation TWInputVC
@synthesize inputField = _inputField;
@synthesize delegate = _delegate;
@synthesize saveButton = _saveButton;
@synthesize cancelButton = _cancelButton;

-(void)showActionSheet
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:@"Action"
                                    delegate:self
                                    cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Save"
                                                   otherButtonTitles:nil];

    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        NSLog(@"Save Action");
        [self reportNewText];
        [self resetStates];
    }
     else if (buttonIndex == 1)
     {
        NSLog(@"Cancel action");
     }
}

-(void)showAlert
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Confirmation"
        message:@"Are you sure"
        delegate:self
        cancelButtonTitle:@"No"
        otherButtonTitles:@"Yes", nil];
    
    [alert show];
}

-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ( buttonIndex == 0)
        NSLog(@"No to Cancel");
    else if ( buttonIndex == 1)
    {
        NSLog(@"Yes to Cnacel");
        if ([self.delegate respondsToSelector:@selector(inputViewDidCancel:)])
        {
            [self.delegate inputViewDidCancel:self];
        }
        [self resetStates];
    }
}

-(void)resetStates
{
    [self.inputField resignFirstResponder];
    self.inputField.text = @"";
    self.saveButton.enabled = NO;
    self.cancelButton.enabled = NO;
}

-(void)inputView:(TWInputVC *)inputView
    didEnterText:(NSString *)text
{
    NSLog(@"Delegate => %@ from %@", text, inputView);
}

- (void)reportNewText
{
    [self.delegate inputView:self
                didEnterText:self.inputField.text];
}

- (IBAction)saveButtonTapped:(id)sender
{
    NSLog(@"User Save = %@", self.inputField.text);
    [self reportNewText];
    [self resetStates];
}

- (IBAction)cancelButtonTapped:(id)sender
{
    NSLog(@"User Cancel = %@", self.inputField.text);
    [self showAlert];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.inputField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"User Enter = %@", textField.text);
    [self showActionSheet];
    
    // TW: How to link to Action ???
    //    [self respondToSelector:@selector(saveButtonTappped:)];
    return YES;
}

-(void)validateButton:(NSString*)name
        forText:(NSString*)text
{
    BOOL hasText = ([text length] >0);
    if ( [name compare:@"save"] == NSOrderedSame )
        self.saveButton.enabled = hasText;
    else if ( [name compare:@"cancel"] == NSOrderedSame)
        self.cancelButton.enabled = hasText;
 }

-(BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    [self validateButton:@"save" forText:newString];
    [self validateButton:@"cancel" forText:newString];
    
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    // make myself a delegate to textField
    self.inputField.delegate = self;
    // self.delegate = self;
    
    self.saveButton.enabled = NO;
    self.cancelButton.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
