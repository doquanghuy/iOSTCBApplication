//
//  Created by Backbase R&D B.V. on 19/04/2019.
//

#ifndef BBUserPreferencesItem_h
#define BBUserPreferencesItem_h

#import <CommonUtils/Additions.h>

NS_ASSUME_NONNULL_BEGIN

/// User preference item for an arrangement.
@interface BBUserPreferencesItem : Additions

/// A unique identifier for the Arrangement object that is generated and used Internally in DBS.
/// Max Length: 36
@property (strong, nonatomic, nonnull, readonly) NSString* arrangementId;

/// The name that can be assigned by the customer to label the arrangement.
/// Max Length: 50
@property (strong, nonatomic, nullable, readonly) NSString* alias;

/// User specific visibility for an arrangement. Type: Boolean
@property (strong, nonatomic, nullable, readonly) NSNumber *visible;

/// Indicates whether an arrangement should be set as favorite. Type:  Boolean
@property (strong, nonatomic, nullable, readonly) NSNumber *favorite;

/**
 * Creates a BBUserPreferencesItem.
 * @param arrangementId Internally used unique identification of arrangement.
 * @param alias User specific naming for an arrangement. Max Length: 64.
 * @param visible User specific visibility for an arrangement.
 * @param favorite Indicates whether an arrangement should be set as favorite.
 * @return The initialized BBUserPreferencesItem object.
 */
- (nonnull instancetype)initWithArrangementId:(nonnull NSString *)arrangementId
                                        alias:(nullable NSString *)alias
                                      visible:(nullable NSNumber *)visible
                                     favorite:(nullable NSNumber *)favorite;
@end

NS_ASSUME_NONNULL_END

#endif /* BBUserPreferencesItem_h */
