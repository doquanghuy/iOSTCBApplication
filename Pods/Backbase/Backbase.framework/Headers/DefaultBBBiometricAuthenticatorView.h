//
//  DefaultBBBiometricAuthenticatorView.h
//  Backbase
//
//  Created by Backbase R&D B.V. on 12/02/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Backbase/Backbase.h>

#ifndef DEFAULTBBBIOMETRICAUTHENTICATORVIEW_CLASS
#define DEFAULTBBBIOMETRICAUTHENTICATORVIEW_CLASS

@interface DefaultBBBiometricAuthenticatorView : UIView <BBBiometricAuthenticatorView>
@property (strong, nonatomic, nonnull) NSObject<BBBiometricAuthenticatorContract>* contract;
@end

#endif
