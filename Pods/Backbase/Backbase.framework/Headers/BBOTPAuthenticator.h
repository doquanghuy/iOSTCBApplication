//
//  BBOTPAuthenticator.h
//  Backbase
//
//  Created by Backbase R&D B.V. on 23/04/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Backbase/Backbase.h>
#import "BBOTPAuthenticatorContract.h"

#ifndef BBOTPAUTHENTICATOR_CLASS
#define BBOTPAUTHENTICATOR_CLASS

/// Core implementation of an out-of-band OTP authenticator.
@interface BBOTPAuthenticator : BBAuthenticator <BBOTPAuthenticatorContract>
@end

#endif
