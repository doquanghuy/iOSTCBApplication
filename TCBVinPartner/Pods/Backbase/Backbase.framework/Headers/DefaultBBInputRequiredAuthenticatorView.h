//
//  DefaultBBInputRequiredAuthenticatorWidgetView.h
//  Backbase
//
//  Created by Ignacio Calderon on 31/12/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Backbase/Backbase.h>
#import "BBInputRequiredAuthenticatorContract.h"
#import "BBInputRequiredAuthenticatorView.h"

#ifndef DEFAULTBBINPUTREQUIREDAUTHENTICATORVIEW_CLASS
#define DEFAULTBBINPUTREQUIREDAUTHENTICATORVIEW_CLASS

NS_ASSUME_NONNULL_BEGIN

@interface DefaultBBInputRequiredAuthenticatorView : UIView <BBInputRequiredAuthenticatorView>
@property (strong, nonatomic) NSObject<BBInputRequiredAuthenticatorContract>* contract;
@end

NS_ASSUME_NONNULL_END

#endif
