// 
//  BBIdentityAuthenticatorsProvider.h
//  Backbase
//
//  Created by Backbase B.V. on 07/11/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>
@class BBFIDOAuthenticator;
@class BBOTPAuthenticator;
@class BBDeviceAuthenticator;

NS_ASSUME_NONNULL_BEGIN

#ifndef BBIDENTITYAUTHENTICATORSPROVIDER_PROTOCOL
#define BBIDENTITYAUTHENTICATORSPROVIDER_PROTOCOL

@protocol BBIdentityAuthenticatorsProvider <NSObject>

/**
 * @return a list of FIDO compatible authenticators.
 */
- (NSArray<BBFIDOAuthenticator*>*)FIDOAuthenticators;

/**
 * Returns the FIDO authenticator that matches the given AAID.
 * @param aaid Desired AAID to find
 * @return the authenticator if matched, nil otherwise.
 */
- (BBFIDOAuthenticator* _Nullable)findFIDOAuthenticatorByAAID:(NSString*)aaid;

/**
 * @return the otp authenticator, or null if it is not supported.
 */
- (BBOTPAuthenticator* _Nullable)OTPAuthenticator;

/**
 * @return the {@link BBDeviceAuthenticator}, or null if it is not registered.
 */
- (BBDeviceAuthenticator* _Nullable)deviceAuthenticator;
@end

#endif

NS_ASSUME_NONNULL_END
