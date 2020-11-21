// 
//  DefaultBBPasscodeAuthenticatorView.h
//  Backbase
//
//  Created by Backbase B.V. on 08/10/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <UIKit/UIKit.h>
#import <Backbase/Backbase.h>

#ifndef DEFAULTBBPASSCODEAUTHENTICATORVIEW_CLASS
#define DEFAULTBBPASSCODEAUTHENTICATORVIEW_CLASS

NS_ASSUME_NONNULL_BEGIN

@interface DefaultBBPasscodeAuthenticatorView : UIView <BBPasscodeAuthenticatorView>
@property (strong, nonatomic, nonnull) NSObject<BBPasscodeAuthenticatorContract>* contract;
@end

NS_ASSUME_NONNULL_END

#endif
