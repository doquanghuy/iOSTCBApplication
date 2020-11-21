//
//  DefaultBBOTPAuthenticatorView.h
//  Backbase
//
//  Created by Backbase R&D B.V. on 23/04/2019.
//  Copyright © 2019 Backbase R&D B.V. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Backbase/Backbase.h>
#import "BBOTPAuthenticatorContract.h"
#import "BBOTPAuthenticatorView.h"

#ifndef DEFAULTBBOTPAUTHENTICATORVIEW_CLASS
#define DEFAULTBBOTPAUTHENTICATORVIEW_CLASS

@interface DefaultBBOTPAuthenticatorView : UIView <BBOTPAuthenticatorView>
@property (strong, nonatomic) NSObject<BBOTPAuthenticatorContract>* contract;
@end

#endif
