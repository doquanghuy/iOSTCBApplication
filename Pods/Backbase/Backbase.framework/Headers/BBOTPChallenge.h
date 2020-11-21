// 
//  BBIdentityChallenge.h
//  Backbase
//
//  Created by Backbase B.V. on 21/05/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>
#import "BBOTPChoice.h"

NS_ASSUME_NONNULL_BEGIN

#ifndef BBOTPCHALLENGE_CLASS
#define BBOTPCHALLENGE_CLASS

@interface BBOTPChallenge : NSObject
@property (strong, nonatomic, nonnull) NSString* challengeType;
@property (strong, nonatomic, nullable) NSString* otpMethod;
@property (strong, nonatomic, nullable) NSString* otpType;
@property (strong, nonatomic, nullable, readonly) NSArray<BBOTPChoice*>* otpChoices;
@end

#endif

NS_ASSUME_NONNULL_END
