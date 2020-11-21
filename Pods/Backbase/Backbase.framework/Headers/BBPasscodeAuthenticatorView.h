// 
//  BBPasscodeAuthenticatorView.h
//  Backbase
//
//  Created by Backbase B.V. on 08/10/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>
#import <Backbase/Backbase.h>

#ifndef BBPASSCODEAUTHENTICATORVIEW_PROTOCOL
#define BBPASSCODEAUTHENTICATORVIEW_PROTOCOL

NS_ASSUME_NONNULL_BEGIN

/// Conforming objects will be notified about actions that require user's interaction
@protocol BBPasscodeAuthenticatorView <BBAuthenticatorView>

/// Conforming object will be notified to prompt the user to select a passcode.
-(void) promptForPasscodeSelection;

/// Conforming object will be notified to prompt the user to authenticate using the passcode previously set.
-(void) promptForPasscode;

/// Conforming object will be notified to prompt the user for a passcode change, usually by confiming first and updating
/// after.
- (void)promptForPasscodeChange;
@end

NS_ASSUME_NONNULL_END

#endif
