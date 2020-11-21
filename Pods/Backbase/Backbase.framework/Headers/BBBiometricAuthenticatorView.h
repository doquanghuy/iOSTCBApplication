//
//  BBBiometricAuthenticatorView.h
//  Backbase
//
//  Created by Backbase R&D B.V. on 12/02/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Backbase/Backbase.h>

#ifndef BBBIOMETRICAUTHENTICATORVIEW_PROTOCOL
#define BBBIOMETRICAUTHENTICATORVIEW_PROTOCOL

/// Conforming objects will be notified about actions that require user's interaction
@protocol BBBiometricAuthenticatorView <BBAuthenticatorView>

/// Conforming object will be notified to prompt the user for permission to use biometrics as a mean of authentication.
- (void)promptForBiometricUsage;

/// Conforming object will be notified to prompt the user to authenticate using the biometric sensor.
- (void)promptForBiometricAuthentication;
@end

#endif
