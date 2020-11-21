// 
//  BBDeviceAuthenticatorDataSource.h
//  Backbase
//
//  Created by Backbase B.V. on 05/06/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>
#import "BBAuthenticatorDataSource.h"

#ifndef BBDEVICEAUTHENTICATORDATASOURCE_PROTOCOL
#define BBDEVICEAUTHENTICATORDATASOURCE_PROTOCOL

NS_ASSUME_NONNULL_BEGIN

@protocol BBDeviceAuthenticatorDataSource <BBAuthenticatorDataSource>
- (NSString* _Nullable)challengeToSign;
- (NSString* _Nullable)deviceId;
@end

NS_ASSUME_NONNULL_END

#endif
