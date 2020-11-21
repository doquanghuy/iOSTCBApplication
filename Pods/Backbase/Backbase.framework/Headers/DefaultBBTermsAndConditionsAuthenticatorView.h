//
//  DefaultBBTermsAndConditionsAuthenticatorView.h
//  Backbase
//
//  Created by Backbase R&D B.V. on 27/11/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Backbase/Backbase.h>
#import "BBTermsAndConditionsAuthenticatorContract.h"
#import "BBTermsAndConditionsAuthenticatorView.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef DEFAULTBBTERMSANDCONDITIONSAUTHENTICATORVIEW_CLASS
#define DEFAULTBBTERMSANDCONDITIONSAUTHENTICATORVIEW_CLASS

@interface DefaultBBTermsAndConditionsAuthenticatorView : UIView <BBTermsAndConditionsAuthenticatorView>
@property (strong, nonatomic) NSObject<BBTermsAndConditionsAuthenticatorContract>* contract;

@end

#endif

NS_ASSUME_NONNULL_END
