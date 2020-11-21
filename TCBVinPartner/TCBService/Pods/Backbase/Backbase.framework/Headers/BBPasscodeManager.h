// 
//  BBPasscodeManager.h
//  Backbase
//
//  Created by Backbase B.V. on 29/10/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>
#import "BBIdentityAuthClient.h"
#import "BBPasscodeChangeDelegate.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef BBPASSCODEMANAGER_CLASS
#define BBPASSCODEMANAGER_CLASS

@interface BBPasscodeManager : NSObject
/// Convenience method to start the process of changing a Identity passcode for the given username.
/// @param username User to change the passcode
/// @param authClient A BBIdentityAuthClient instance to be used to trigger the process
/// @param delegate Delegate to notify when the operation completes.
+ (void)changePasscode:(NSString*)username
            authClient:(BBIdentityAuthClient*)authClient
              delegate:(NSObject<BBPasscodeChangeDelegate>*)delegate;
@end

#endif

NS_ASSUME_NONNULL_END
