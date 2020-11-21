//
//  Created by Backbase R&D B.V. on 1/20/20.
//

#ifndef BBTransactionLocation_h
#define BBTransactionLocation_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// Response class that contains the representation of a location for transaction item.
@interface BBTransactionLocation : Additions

/// Location id
@property (nonatomic, readonly) NSInteger identifier;

/// Latitude of the transaction coordinate
@property (strong, nonatomic, readonly, nullable) NSNumber *latitude;

/// Longitude of the transaction coordinate
@property (strong, nonatomic, readonly, nullable) NSNumber *longitude;

/// Address information of the location.
@property (strong, nonatomic, readonly, nullable) NSString *address;

/// Using of default init is forbiden
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

#endif
