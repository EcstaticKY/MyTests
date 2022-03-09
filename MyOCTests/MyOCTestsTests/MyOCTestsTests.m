//
//  MyOCTestsTests.m
//  MyOCTestsTests
//
//  Created by Kanyan Zheng on 2022/2/21.
//

#import <XCTest/XCTest.h>
#import <MyOCTests/MyOCTests.h>

@interface MyOCTestsTests : XCTestCase

@end

@implementation MyOCTestsTests

- (void)test {
    TheCaller *caller = [TheCaller new];
    [caller call];
}
@end
