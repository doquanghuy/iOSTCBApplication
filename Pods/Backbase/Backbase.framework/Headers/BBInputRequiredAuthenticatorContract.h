//
//  BBInputRequiredAuthenticatorContract.h
//  Backbase
//
//  Created by Ignacio Calderon on 31/12/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Backbase/Backbase.h>

#ifndef BBINPUTREQUIREDAUTHENTICATORCONTRACT_PROTOCOL
#define BBINPUTREQUIREDAUTHENTICATORCONTRACT_PROTOCOL

NS_ASSUME_NONNULL_BEGIN

@protocol BBInputRequiredAuthenticatorContract <BBAuthenticatorContract, BBDismissableAuthenticator>
- (void)submit:(NSDictionary<NSString*, NSString*>*)fields;
- (void)cancel;
@end

NS_ASSUME_NONNULL_END

#endif
