//
//  BBForgottenCredentialsDelegate.h
//  Backbase
//
//  Created by Backbase B.V. on 31/12/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef BBFORGORUSERNAMEDELEGATE_PROTOCOL
#define BBFORGORUSERNAMEDELEGATE_PROTOCOL

NS_ASSUME_NONNULL_BEGIN

/// Protocol to inform about the result of the retrieval operation
@protocol BBForgottenCredentialsDelegate <NSObject>

/// Notifies the conforming object that the username retrieval was successful and return the data that was received by
/// the service.
/// @param data Payload received from the retrieval serviced. Normally should contain a message or instructions to
/// procceed further.
- (void)forgotUsernameDidSucceed:(NSData*)data;

/// Notifies the conforming object that the username retrieval failed with an specific error.
/// @param error Error that caused the failure.
- (void)forgotUsernameDidFailWithError:(NSError* _Nonnull)error;
@end

NS_ASSUME_NONNULL_END

#endif
