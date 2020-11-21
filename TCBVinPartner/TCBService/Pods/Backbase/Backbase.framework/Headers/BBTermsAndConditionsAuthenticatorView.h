//
//  BBTermsAndConditionsAuthenticatorView.h
//  Backbase
//
//  Created by Backbase R&D B.V. on 27/11/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Backbase/Backbase.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef BBTERMSANDCONDITIONSAUTHENTICATORVIEW_PROTOCOL
#define BBTERMSANDCONDITIONSAUTHENTICATORVIEW_PROTOCOL

@protocol BBTermsAndConditionsAuthenticatorView <BBAuthenticatorView>

- (void)termsAndConditionsDidFailWithError:(NSError*)error NS_SWIFT_NAME(termsAndConditionsDidFail(with:));
- (void)termsAndConditionsDidLoad:(NSString*)termsAndConditionsText;

@end

#endif

NS_ASSUME_NONNULL_END
