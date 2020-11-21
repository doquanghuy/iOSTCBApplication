//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef BBProductKindItem_h
#define BBProductKindItem_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// Product kind item for an arrangement.
@interface BBProductKindItem : Additions

/// Unique external identifier for the product kind
@property (strong, nonatomic, readonly) NSString *externalKindId;

/// Unique product kind name
@property (strong, nonatomic, readonly) NSString *kindName;

/// Unique product kind uri
@property (strong, nonatomic, readonly) NSString *kindUri;

/**
 * Creates a BBProductKindItem.
 * @param externalKindId Unique external identifier for the product kind
 * @param kindName Unique product kind name
 * @param kindUri Unique product kind uri
 * @return The initialized BBProductKindItem object.
 */
- (nonnull instancetype)initWithExternalKindId:(nonnull NSString *)externalKindId
                                      kindName:(nonnull NSString *)kindName
                                       kindUri:(nonnull NSString *)kindUri;

@end

NS_ASSUME_NONNULL_END

#endif /* BBProductKindItem_h */
