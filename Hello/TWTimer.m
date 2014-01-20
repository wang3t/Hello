#import "TWTimer.h"

static TWTimer *_shareTimer = nil;
@interface TWTimer ()
@property (strong, nonatomic, readwrite) NSDate *initialTime;

@end

@implementation TWTimer
@synthesize name = _name;
@synthesize initialTime = _initialTime;

+ (id)sharedTimer:(NSString*)aName
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{_shareTimer = [[self alloc]initWithName:aName];});
    return _shareTimer;
}

- (id)initWithName:(NSString*)aName
{
    self = [super init];
    if (self)
    {
        _initialTime = [[NSDate alloc]init];
        _name = aName;
    }
    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"%@-%@ starts at %@",
                    NSStringFromClass([self class]), 
                    self.name, self.initialTime];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _initialTime = [[NSDate alloc] init];
    }
    return self;
}

- (NSTimeInterval)getDeltaTime 
{
    NSDate *now = [[NSDate alloc] init];
    NSTimeInterval elapsedTime = [now timeIntervalSinceDate:self.initialTime];
    return elapsedTime;
}

@end
