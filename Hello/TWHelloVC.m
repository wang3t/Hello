//
//  TWViewController.m
//  Hello
//

#import "TWHelloVC.h"
#import "TWTimer.h"
#import "TWInputVC.h"
#import "TWTableVC.h"
#import "TWDataModel.h"

@interface TWHelloVC () <TWInputDelegate>
@property (weak, nonatomic) IBOutlet UILabel *hello;
@property (weak, nonatomic) IBOutlet UIImageView *bgScn;
@property (weak, nonatomic) IBOutlet UILabel *event;
@property (strong, nonatomic) TWTimer* appTimer;
@property (strong, nonatomic) TWDataModel* appModel;
@end

@implementation TWHelloVC
@synthesize hello = _hello;
@synthesize bgScn = _bgScn;
@synthesize event = _event;
@synthesize appTimer = _appTimer;
@synthesize appModel = _appModel;

// TWInputDelegate
-(void)inputViewDidCancel:(TWInputVC *)inputView
{
    NSLog(@"Presented VC %@",  [[self presentedViewController] class]);
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)inputView:(TWInputVC*)inputView
     didEnterText:(NSString *)text
{
    NSLog(@"User Enter %@", text);
    self.event.text = [NSString stringWithFormat:@"enter %@ at %f sec",text,[self.appTimer getDeltaTime]];
    [self.appModel addLog:self.event.text];

    [self inputViewDidCancel:inputView];
}

// swipe segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"showTableVC"] )
    {
        TWTableVC *tableVC = [segue destinationViewController];
        NSLog(@"showTableVC-Segue %@ from %@ to %@", segue, [sender class], [tableVC description]);
        [tableVC setSource:(id)self.appModel];
    }
    else if ( [segue.identifier isEqualToString:@"showInputVC"] )
    {
        TWInputVC *inputVC = [segue destinationViewController];
        inputVC.delegate = self;
        NSLog(@"showInputVC-Segue %@ from %@ to %@", segue, [sender class], [inputVC description]);
    }
    else
    {
        NSLog(@"Generic Segue %@ from %@ ", segue, [sender class]);
    }
}

- (IBAction)sayHello:(id)sender
{
    NSLog(@"=> Button Click");
    self.event.text = [NSString stringWithFormat:@"Button at %f sec",[self.appTimer getDeltaTime]];
    [self.appModel addLog:self.event.text];
}

-(void)tapRecognized:(UIGestureRecognizer*)recognizer
{
    NSLog(@"=> tapRecognized ");
    self.event.text = [NSString stringWithFormat:@"tap at %f sec",[self.appTimer getDeltaTime]];
    [self.appModel addLog:self.event.text];
}

-(void)tap2Recognized:(UIGestureRecognizer*)recognizer
{
    NSLog(@"=> tap2Recognized");
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
    
    [self.appModel addLog:self.event.text];
}

-(void)swipeGestureRecognized:(UIGestureRecognizer*)recognizer
{
    NSLog(@"=> swipeGestureRecognized");
    self.event.text = [NSString stringWithFormat:@"swipe at %f sec",[self.appTimer getDeltaTime]];
    [self.appModel addLog:self.event.text];
}

-(void)pinchRecognized:(UIGestureRecognizer*)recognizer
{
    NSLog(@"=> pinchRecognized");
    self.event.text = [NSString stringWithFormat:@"pinch at %f sec",[self.appTimer getDeltaTime]];
    [self.appModel addLog:self.event.text];
}

-(void)rotateRecognized:(UIGestureRecognizer*)recognizer
{
    NSLog(@"=> rotateRecognized");
    self.event.text = [NSString stringWithFormat:@"rotate at %f sec",[self.appTimer getDeltaTime]];

    [self.appModel addLog:self.event.text];
}

//
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.appTimer = [TWTimer sharedTimer:nil];
    // self.appModel = [[TWDataModel alloc]init];
    self.appModel = [TWDataModel sharedModel];

    self.hello.text = [NSString stringWithFormat:@"%@, by TW", self.appTimer.name];
    self.event.text = [NSString stringWithFormat:@"%@", [self.appTimer description]];
    [self.appModel addLog:self.event.text];
    
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
