// 
//  BBInputRequiredAuthenticatorDelegate.h
//  Backbase
//
//  Created by Backbase B.V. on 31/12/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>

#ifndef BBINPUTREQUIREDAUTHENTICATORDELEGATE_PROTOCOL
#define BBINPUTREQUIREDAUTHENTICATORDELEGATE_PROTOCOL

NS_ASSUME_NONNULL_BEGIN

@protocol BBInputRequiredAuthenticatorDelegate <BBAuthenticatorDelegate>

- (void)inputRequiredDidSucceed:(NSHTTPURLResponse*)response data:(NSData*)data;

- (void)inputRequiredDidFailWithError:(NSError*)error NS_SWIFT_NAME(inputRequiredDidFail(with:));

@end

NS_ASSUME_NONNULL_END

#endif
