// 
//  BBTermsAndConditionsChallenge.h
//  Backbase
//
//  Created by Backbase B.V. on 27/11/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef BBTERMSANDCONDITIONSCHALLENGE_CLASS
#define BBTERMSANDCONDITIONSCHALLENGE_CLASS

@interface BBTermsAndConditionsChallenge : NSObject
@property (strong, nonatomic, nonnull) NSString* URI;
@property (strong, nonatomic, nonnull) NSString* HTTPMethod;
@end

#endif

NS_ASSUME_NONNULL_END
