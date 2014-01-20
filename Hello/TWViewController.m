//
//  TWViewController.m
//  Hello
//

#import "TWViewController.h"
#import "TWTimer.h"

@interface TWViewController ()
@property (weak, nonatomic) IBOutlet UILabel *hello;
@property (weak, nonatomic) IBOutlet UIImageView *bgScn;
@property (weak, nonatomic) IBOutlet UILabel *event;
@property (strong, nonatomic) TWTimer* appTimer;

@end

@implementation TWViewController
- (IBAction)sayHello:(id)sender
{
    self.hello.text = [NSString stringWithFormat:@"%@", [[[NSDate alloc]init]description]];
}

-(void)tapRecognized:(UIGestureRecognizer*)recognizer
{
    self.event.text = [NSString stringWithFormat:@"tap at %f sec",[self.appTimer getDeltaTime]];
    NSLog(@"tapRecognized => %@", [recognizer description]);
}

-(void)tap2Recognized:(UIGestureRecognizer*)recognizer
{
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.event.alpha = 0;
                         self.bgScn.alpha = 0;
                         self.event.transform = CGAffineTransformMakeScale(0.1, 0.1);}
                     completion:^(BOOL finished) {
                         self.event.text = [NSString stringWithFormat:@"tap2 at %f sec",[self.appTimer getDeltaTime]];
                         self.event.alpha = 1;
                         self.bgScn.alpha = 1;
                         self.event.transform = CGAffineTransformIdentity;}];
    NSLog(@"tap2Recognized => %@", [recognizer description]);
}

-(void)swipeGestureRecognized:(UIGestureRecognizer*)recognizer
{
    self.event.text = [NSString stringWithFormat:@"swipe at %f sec",[self.appTimer getDeltaTime]];
    NSLog(@"swipeGestureRecognized => %@", [recognizer description]);
}

-(void)pinchRecognized:(UIGestureRecognizer*)recognizer
{
    self.event.text = [NSString stringWithFormat:@"ping at %f sec",[self.appTimer getDeltaTime]];
    NSLog(@"pinchRecognized => %@", [recognizer description]);
}

-(void)rotateRecognized:(UIGestureRecognizer*)recognizer
{
    self.event.text = [NSString stringWithFormat:@"rotate at %f sec",[self.appTimer getDeltaTime]];

    NSLog(@"rotateRecognized => %@", [recognizer description]);
}

//
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appTimer = [TWTimer sharedTimer:nil];
	// Do any additional setup after loading the view, typically from a nib.

    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotateRecognized:)];
    [self.view addGestureRecognizer:rotate];
    
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchRecognized:)];
    [self.view addGestureRecognizer:pinch];
    
    // Gesture
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]
                                         initWithTarget:self
                                         action:@selector(swipeGestureRecognized:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    //TSW singleTap + doubleTap
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
