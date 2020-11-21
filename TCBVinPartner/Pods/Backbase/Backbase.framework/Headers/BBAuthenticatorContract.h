// 
//  BBAuthenticatorContract.h
//  Backbase
//
//  Created by Backbase B.V. on 20/02/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>
#import "BBAuthenticatorDataSource.h"
#import "BBAuthenticatorDelegate.h"

#ifndef BBAUTHENTICATORCONTRACT_PROTOCOL
#define BBAUTHENTICATORCONTRACT_PROTOCOL

/// Protocol to define the general behavior available to any kind of authenticator.
@protocol BBAuthenticatorContract <NSObject>

/// Finalizes the authenticator execution and dismiss its view.
- (void)finish;

@end

#endif
