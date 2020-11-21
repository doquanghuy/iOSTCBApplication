//
//  BBTermsAndConditionsAuthenticatorContract.h
//  Backbase
//
//  Created by Backbase R&D B.V. on 27/11/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Backbase/Backbase.h>
#import "BBDismissableAuthenticator.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef BBTERMSANDCONDITIONSAUTHENTICATORCONTRACT_PROTOCOL
#define BBTERMSANDCONDITIONSAUTHENTICATORCONTRACT_PROTOCOL

@protocol BBTermsAndConditionsAuthenticatorContract <BBAuthenticatorContract, BBDismissableAuthenticator>
- (void)userDidAccept;
- (void)userDidDecline;
- (void)retry;
@end

#endif

NS_ASSUME_NONNULL_END
