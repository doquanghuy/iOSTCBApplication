//
//  BBOTPAuthenticatorView.h
//  Backbase
//
//  Created by Backbase R&D B.V. on 23/04/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Backbase/Backbase.h>

#ifndef BBOTPAUTHENTICATORVIEW_PROTOCOL
#define BBOTPAUTHENTICATORVIEW_PROTOCOL

NS_ASSUME_NONNULL_BEGIN

/// Conforming objects will be notified about actions that require user's interaction
@protocol BBOTPAuthenticatorView <BBAuthenticatorView>

/**
 * Notifies the conforming object that the view should prompt a way to select a method amongst the given ones.
 * @param availableMethods The list of method's names that are allowed to be send an OOB OTP.
 */
- (void)promptForOTPMethod:(NSArray<BBOTPChoice*>*)availableMethods;

/**
 * Notifies the conforming object that the view should prompt a way to input the OTP received in the OOB channel.
 */
- (void)promptForOTPValue;
@end

NS_ASSUME_NONNULL_END

#endif
