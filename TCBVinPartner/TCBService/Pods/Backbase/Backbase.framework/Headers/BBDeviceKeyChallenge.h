// 
//  BBDeviceKeyChallenge.h
//  Backbase
//
//  Created by Backbase B.V. on 06/06/2019.
//  Copyright © 2019 Backbase B.V. All rights reserved.
//
 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#ifndef BBDEVICEKEYCHALLENGE_CLASS
#define BBDEVICEKEYCHALLENGE_CLASS

@interface BBDeviceKeyChallenge : NSObject
@property (strong, nonatomic, nonnull) NSString* challengeType;
@property (strong, nonatomic, nonnull) NSString* nonce;
@property (strong, nonatomic, nonnull) NSString* deviceId;
@end

#endif

NS_ASSUME_NONNULL_END
