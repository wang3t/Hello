//
//  TWDataModel.m
//  Data model

#import "TWDataModel.h"

static TWDataModel *_sharedModel = nil;
NSString *const TWUsrData = @"TWUsrData";
NSString *const TWsysData = @"TWsysData";

@interface TWDataModel ()
@property (strong, nonatomic) NSMutableArray *sysData;
@end

@implementation TWDataModel
@synthesize userInput = _userInput;
@synthesize sysData = _sysData;

+ (id)sharedModel
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ _sharedModel = [[self alloc]init];});
    return _sharedModel;
}

-(NSMutableArray *)sysData
{
    if ( _sysData == nil)
    {
        NSArray *storedLog = [[NSUserDefaults standardUserDefaults] objectForKey:TWsysData];
        if (storedLog)
            _sysData = [storedLog mutableCopy];
        else
            _sysData = [[NSMutableArray alloc] initWithObjects:nil];;
    }
    return _sysData;
}

- (NSMutableArray *)userInput
{
    if (!_userInput)
    {
        NSArray *storedAnswers = [[NSUserDefaults standardUserDefaults] objectForKey:TWUsrData];
        if (storedAnswers)
            _userInput = [storedAnswers mutableCopy];
        else
            _userInput = [[NSMutableArray alloc] initWithObjects:nil];
    }
    return _userInput;
}

- (NSString *)randomInput;
{
    if ([self numberOfInput])
        return [self.userInput objectAtIndex:(rand() % [self numberOfInput])];
    else
        return @"Nothing in input !";
}

- (NSInteger)numberOfInput
{
    return [self.userInput count];
}

- (NSString *)inputAtIndex:(NSInteger)index
{
    return [self.userInput objectAtIndex:index];
}

- (void)removeInputAtIndex:(NSInteger)index
{
    if ( index < [self.userInput count] )
    {
        NSLog(@"Deleting %@ from input[%d]", [self inputAtIndex:index], [self numberOfInput]);
        [self.userInput removeObjectAtIndex:index];
        [self save];
    }
}

-(void)save
{
    [[NSUserDefaults standardUserDefaults] setObject:self.userInput forKey:TWUsrData];
    [[NSUserDefaults standardUserDefaults] setObject:self.sysData forKey:TWsysData];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)addInput:(NSString *)text
{
    [self.userInput addObject:text];
    NSLog(@"Adding %@ and array size =%d", text, [self numberOfInput]);
    [self save];
    return [self numberOfInput];
}

- (NSInteger)addInput:(NSString *)text atIndex:(NSInteger)index
{
    if (index > [self numberOfInput] )
    {
        NSLog(@"Make index=%d to fit", (unsigned)index );
        index = [self numberOfInput];
    }
    [self.userInput insertObject:text atIndex:index ];
    NSLog(@"Adding %@ at index=%u", text, index);

    [self save];
    return [self numberOfInput];
}
- (NSInteger)numberOfLog
{
    return [self.sysData count];
}

- (NSInteger)addLog:(NSString *)text
{
    [self.sysData addObject:text];
    NSLog(@"Adding %@ and array size =%d", text, [self numberOfLog]);
    [self save];
    return [self numberOfLog];
}

- (NSString *)logAtIndex:(NSInteger)index
{
    return [self.sysData objectAtIndex:index];
}

#pragma mark - init for Notification

-(id)init
{
    if ( self = [super init] )
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                selector:@selector(appDidEnterBG)
                                name:UIApplicationDidEnterBackgroundNotification
                                object:[UIApplication sharedApplication] ];
    }
    return self;
}

- (void)appDidEnterBG
{
    NSLog(@"Entering BG");
    [self save];
}

-(void) dealloc
{
    NSLog(@"Bye @dealloc %@", [self class]);
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
