//
//  BBInputRequiredAuthenticatorView.h
//  Backbase
//
//  Created by Ignacio Calderon on 31/12/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Backbase/Backbase.h>

#ifndef BBINPUTREQUIREDAUTHENTICATORVIEW_PROTOCOL
#define BBINPUTREQUIREDAUTHENTICATORVIEW_PROTOCOL

NS_ASSUME_NONNULL_BEGIN

@protocol BBInputRequiredAuthenticatorView <BBAuthenticatorView>
- (void)promptUserForInput:(NSArray<NSString*>*)fields;
@end

NS_ASSUME_NONNULL_END

#endif
