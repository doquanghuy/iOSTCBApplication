//
//  BBInputRequiredAuthenticatorWidget.h
//  Backbase
//
//  Created by Ignacio Calderon on 31/12/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Backbase/Backbase.h>
#import "BBInputRequiredAuthenticatorContract.h"

#ifndef BBINPUTREQUIREDAUTHENTICATOR_CLASS
#define BBINPUTREQUIREDAUTHENTICATOR_CLASS

NS_ASSUME_NONNULL_BEGIN

@interface BBInputRequiredAuthenticator : BBAuthenticator <BBInputRequiredAuthenticatorContract>

@end

NS_ASSUME_NONNULL_END

#endif
