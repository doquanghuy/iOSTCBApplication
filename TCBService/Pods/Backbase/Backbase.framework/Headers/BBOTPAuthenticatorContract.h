//
//  BBOTPAuthenticatorContract.h
//  Backbase
//
//  Created by Backbase R&D B.V. on 23/04/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol BBOTPAuthenticatorDelegate;
@protocol BBOTPAuthenticatorDataSource;
@protocol BBDismissableAuthenticator;
@class BBOTPChoice;

#ifndef BBOTPAUTHETICATORCONTRACT_PROTOCOL
#define BBOTPAUTHETICATORCONTRACT_PROTOCOL

NS_ASSUME_NONNULL_BEGIN

/// Conforming objects will be notified about user interactions regarding OTP actions.
@protocol BBOTPAuthenticatorContract <BBAuthenticatorContract, BBDismissableAuthenticator>
/**
 * Notifies the conforming object that the user made a selection of the method to be used to receive the out-of-band OTP
 * @discussion The method is one of the options provided via the
 * BBOTPAuthenticationDataSource.OTPAuthenticatorAvailableMethods method.
 * @param selectedMethod Selected method to receive the OOB OTP.
 */
- (void)userDidSelectMethod:(BBOTPChoice*)selectedMethod;

/**
 * Notifies the conforming object that the user entered the OOB received value.
 * @param OTPValue The value of the OTP received via the selected method.
 */
- (void)userDidEnterValue:(NSString*)OTPValue;

/**
 * Notifies the conforming object that the user cancelled the on-going action.
 * @discussion The authentication could be executing only one action at the time, either it's selecting the method to
 * receive the OOB OTP, or it is waiting for the user to input the value received.
 */
- (void)userDidCancel;

/**
 * Notifies the conforming object that the user has requested the OTP to be resend on the same channel as before.
 */
- (void)userDidRequestResend;
@end

NS_ASSUME_NONNULL_END

#endif
