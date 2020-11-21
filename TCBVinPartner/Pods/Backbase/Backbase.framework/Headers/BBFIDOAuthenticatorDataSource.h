// 
//  BBFIDOAuthenticatorDataSource.h
//  Backbase
//
//  Created by Backbase B.V. on 24/04/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>
#import "BBAuthenticatorDataSource.h"
@class FIDOUAFRequestEntry;
@class FIDOChallengeParams;

#ifndef BBFIDOAUTHENTICATORDATASOURCE_CLASS
#define BBFIDOAUTHENTICATORDATASOURCE_CLASS

NS_ASSUME_NONNULL_BEGIN

/// FIDO Authenticator modes
typedef NS_ENUM(NSInteger, FIDOAuthenticatorMode) {
    /// The authenticator is on registration mode
    FIDOAuthenticatorModeRegistration = 0,
    /// The authenticator is on authentication mode
    FIDOAuthenticatorModeAuthentication,
    /// Other modes specific per authenticator
    FIDOAuthenticatorModeOther
};

/// Conforming objects will provide data related to the FIDO authenticators
@protocol BBFIDOAuthenticatorDataSource <BBAuthenticatorDataSource>
/// Provides the FIDO registration request
- (NSString*)appID;

/// Provides the FIDO challenge parameters
- (FIDOChallengeParams*)policyChallengeParameters;

/// Provides the Authenticator mode to run
- (FIDOAuthenticatorMode)authenticatorMode;

/// Provides the username
- (NSString*)username;

@optional
/// Provides the registration token
- (NSString* _Nullable)registrationToken;

/// Provides the last FIDO response
- (NSDictionary* _Nullable)FIDOResponse;
@end

NS_ASSUME_NONNULL_END

#endif
