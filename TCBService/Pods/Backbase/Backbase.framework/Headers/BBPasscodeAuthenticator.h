// 
//  BBPasscodeAuthenticator.h
//  Backbase
//
//  Created by Backbase B.V. on 08/10/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Backbase/Backbase.h>
#import "BBPasscodeAuthenticatorContract.h"

#ifndef BBPASSCODEAUTHENTICATOR_CLASS
#define BBPASSCODEAUTHENTICATOR_CLASS

NS_ASSUME_NONNULL_BEGIN

@interface BBPasscodeAuthenticator : BBFIDOAuthenticator <BBPasscodeAuthenticatorContract>
@end

NS_ASSUME_NONNULL_END

#endif
