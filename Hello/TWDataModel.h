//
//  TWDataModel.h
//  Data model

#import <Foundation/Foundation.h>

@interface TWDataModel : NSObject
@property (strong, nonatomic)NSMutableArray *userInput;

- (NSString *)randomInput;

// TW
- (NSInteger)numberOfInput;
- (NSString *)inputAtIndex:(NSInteger)index;
- (void)removeInputAtIndex:(NSInteger)index;
- (NSInteger)addInput:(NSString *)text atIndex:(NSInteger)index;
- (NSInteger)addInput:(NSString *)text;
- (NSInteger)numberOfLog;
- (NSInteger)addLog:(NSString *)text;
- (NSString *)logAtIndex:(NSInteger)index;
+ (id)sharedModel;

@end
