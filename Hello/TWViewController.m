//
//  TWViewController.m
//  Hello
//

#import "TWViewController.h"
#import "TWTimer.h"
#import "TWInputVC.h"

@interface TWViewController () <TWInputDelegate>
@property (weak, nonatomic) IBOutlet UILabel *hello;
@property (weak, nonatomic) IBOutlet UIImageView *bgScn;
@property (weak, nonatomic) IBOutlet UILabel *event;
@property (strong, nonatomic) TWTimer* appTimer;

@end

@implementation TWViewController
@synthesize hello = _hello;
@synthesize bgScn = _bgScn;
@synthesize event = _event;
@synthesize appTimer = _appTimer;

// TWInputDelegate
-(void)inputViewDidCancel:(TWInputVC *)inputView
{
    NSLog(@"Presented VC %@",  [[self presentedViewController] class]);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)inputView:(TWInputVC*)inputView
     didEnterText:(NSString *)text
{
    self.event.text = [NSString stringWithFormat:@"enter %@ at %f sec",text,[self.appTimer getDeltaTime]];
    NSLog(@"User Enter %@", text);
    [self inputViewDidCancel:inputView];
}

// swipe segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TWInputVC *inputVC = [segue destinationViewController];
    inputVC.delegate = self;
    NSLog(@"Segue %@ from %@ to %@", segue, [sender class], [inputVC description]);
}

- (IBAction)sayHello:(id)sender
{
    self.hello.text = [NSString stringWithFormat:@"%@", [self.appTimer description]];
    self.event.text = [NSString stringWithFormat:@"Button at %f sec",[self.appTimer getDeltaTime]];
}

-(void)tapRecognized:(UIGestureRecognizer*)recognizer
{
    self.event.text = [NSString stringWithFormat:@"tap at %f sec",[self.appTimer getDeltaTime]];
    NSLog(@"=> tapRecognized ");
}

-(void)tap2Recognized:(UIGestureRecognizer*)recognizer
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.event.alpha = 0;
                         self.bgScn.alpha = 0;
                         self.event.transform = CGAffineTransformMakeScale(1.0, 0.1);}
                     completion:^(BOOL finished) {
                         self.event.text = [NSString stringWithFormat:@"tap2 at %f sec",[self.appTimer getDeltaTime]];
                         self.event.alpha = 1;
                         self.bgScn.alpha = 1;
                         self.event.transform = CGAffineTransformIdentity;}];
    NSLog(@"=> tap2Recognized");
}

-(void)swipeGestureRecognized:(UIGestureRecognizer*)recognizer
{
    self.event.text = [NSString stringWithFormat:@"swipe at %f sec",[self.appTimer getDeltaTime]];
    NSLog(@"=> swipeGestureRecognized");
}

-(void)pinchRecognized:(UIGestureRecognizer*)recognizer
{
    self.event.text = [NSString stringWithFormat:@"ping at %f sec",[self.appTimer getDeltaTime]];
    NSLog(@"=> pinchRecognized");
}

-(void)rotateRecognized:(UIGestureRecognizer*)recognizer
{
    self.event.text = [NSString stringWithFormat:@"rotate at %f sec",[self.appTimer getDeltaTime]];

    NSLog(@"=> rotateRecognized");
}

//
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appTimer = [TWTimer sharedTimer:nil];
	// Do any additional setup after loading the view, typically from a nib.

    // Rotate + pinch
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateRecognized:)];
    [self.view addGestureRecognizer:rotate];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchRecognized:)];
    [self.view addGestureRecognizer:pinch];

    // Swipe
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(swipeGestureRecognized:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    //singleTap + doubleTap
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(tap2Recognized:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(tapRecognized:)];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    [self.view addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
