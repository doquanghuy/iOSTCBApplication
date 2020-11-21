// 
//  BBInputRequiredAuthenticatorDataSource.h
//  Backbase
//
//  Created by Backbase B.V. on 31/12/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>

#ifndef BBINPUTREQUIREDAUTHENTICATORDATASOURCE_PROTOCOL
#define BBINPUTREQUIREDAUTHENTICATORDATASOURCE_PROTOCOL

NS_ASSUME_NONNULL_BEGIN

@protocol BBInputRequiredAuthenticatorDataSource <BBAuthenticatorDataSource>
- (NSURL*)actionURL;
- (NSArray<NSString*>*)requiredInputs;
@end

NS_ASSUME_NONNULL_END

#endif
