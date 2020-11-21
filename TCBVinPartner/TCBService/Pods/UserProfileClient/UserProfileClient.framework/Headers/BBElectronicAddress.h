//
//  Created by Backbase R&D B.V. on 16/05/2019.
//
#ifndef UserProfileClient_BBElectronicAddress_h
#define UserProfileClient_BBElectronicAddress_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// Electronic Address information of the profile owner.
@interface BBElectronicAddress : Additions

/// Unique key identifying the object.
@property (strong, nonatomic, nonnull, readonly) NSString *key;

/// Key identifying the type of object.
@property (strong, nonatomic, nonnull, readonly) NSString *type;

/// Address.
@property (strong, nonatomic, nonnull, readonly) NSString *address;

/// Flag denoting whether this is the main object.
@property (strong, nonatomic, nullable, readonly) NSNumber* primary;

@end

NS_ASSUME_NONNULL_END

#endif