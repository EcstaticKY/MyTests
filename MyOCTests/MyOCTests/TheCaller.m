//
//  TheCaller.m
//  MyOCTests
//
//  Created by Kanyan Zheng on 2022/2/21.
//

#import "TheCaller.h"
#import <MyTests/MyTests.h>

@interface ConcreteClient : NSObject<JustClient>

@end

@implementation ConcreteClient

- (void)just {
    NSLog(@"just");
}

@end

@implementation TheCaller

- (void)call {
    id<JustClient> client = [ConcreteClient new];
    JustLoader *loader = [JustLoaderComposer composedWithClient:client];
    [loader justLoad];
}
@end
