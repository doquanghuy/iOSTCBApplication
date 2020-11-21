// 
//  DeviceAuthClient.h
//  Backbase
//
//  Created by Backbase B.V. on 08/05/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef DEVICEAUTHCLIENT_PROTOCOL
#define DEVICEAUTHCLIENT_PROTOCOL

/**
 * Device AuthClient allows to interact with servers that can perform passwordless authentications with a registered
 * device.
 */
@protocol DeviceAuthClient <NSObject>

/**
 * Checks if the device has successfully undergo the registration process.
 * @return YES if the devide has been successfully registered, NO otherwise.
 */
- (BOOL)isDeviceRegistered;

/**
 * Authenticates using information related to the registered device, including but not limited to: biometrics, passcode
 * voice recognition, etc.
 * @param username Username to be used during the authentication
 * @param delegate Delegate to inform about the authentication process.
 */
- (void)authenticateRegisteredDeviceWithUsername:(NSString* _Nonnull)username
                                        delegate:(NSObject<PasswordAuthClientDelegate>* _Nonnull)delegate;

/**
 * Resets the Auth client to a <i>first</i> login mode.
 * @discussion After executing the user will be unable to authenticate using the previously approved
 * authenticators and will be force to enroll again.
 */
- (void)reset;
@end

#endif

NS_ASSUME_NONNULL_END
