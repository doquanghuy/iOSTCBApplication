// 
//  BBForgottenCredentialsManager.h
//  Backbase
//
//  Created by Backbase B.V. on 31/12/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//

#import <Backbase/Backbase.h>
#import "BBForgottenCredentialsDelegate.h"

#ifndef BBFORGOTTENCREDENTIALSMANAGER_CLASS
#define BBFORGOTTENCREDENTIALSMANAGER_CLASS

NS_ASSUME_NONNULL_BEGIN

/// Convenience class for all operations related to forgotten credentials, like username, password.
@interface BBForgottenCredentialsManager : NSObject

/// Convenience method to start the process to retrieve the forgotten username. The result of the operation will be
/// delivered in the delegate's methods.
/// @param delegate Delegate instance to return the result of the operation.
+ (void)retrieveForgottenUsername:(NSObject<BBForgottenCredentialsDelegate>*)delegate;
@end

NS_ASSUME_NONNULL_END

#endif
