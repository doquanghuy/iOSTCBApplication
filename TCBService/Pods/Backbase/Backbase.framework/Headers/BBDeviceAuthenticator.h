// 
//  BBDeviceAuthenticator.h
//  Backbase
//
//  Created by Backbase B.V. on 04/06/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>
#import "BBAuthenticator.h"
#import "BBDeviceAuthenticatorContract.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef BBDEVICEAUTHENTICATOR_CLASS
#define BBDEVICEAUTHENTICATOR_CLASS

@interface BBDeviceAuthenticator : BBAuthenticator <BBDeviceAuthenticatorContract>
@end

#endif

NS_ASSUME_NONNULL_END
