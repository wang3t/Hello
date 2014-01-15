//
//  TWViewController.m
//  Hello
//

#import "TWViewController.h"

@interface TWViewController ()
@property (weak, nonatomic) IBOutlet UILabel *hello;

@end

@implementation TWViewController
- (IBAction)sayHello:(id)sender
{
    self.hello.text = [NSString stringWithFormat:@"%@", [[[NSDate alloc]init]description]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
