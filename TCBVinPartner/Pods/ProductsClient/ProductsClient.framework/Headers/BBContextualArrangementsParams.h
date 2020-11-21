//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef BBContextualArrangementsParams_h
#define BBContextualArrangementsParams_h

#import <CommonUtils/CommonUtils.h>

NS_ASSUME_NONNULL_BEGIN

/// Request params class to be used when retrieving arrangments
@interface BBContextualArrangementsParams : Additions

/// Provide the context for retrieving arrangements
@property (strong, nonatomic, readonly) NSString *businessFunction;

/// Provide the resource for retrieving arrangements
@property (strong, nonatomic, readonly) NSString *resourceName;

/// Privilege for the arrangements
@property (strong, nonatomic, readonly) NSString *privilege;

/// Boolean. Retrieve a list of arrangements with the latest balances
@property (nonatomic, strong, nullable, readwrite) NSNumber *withLatestBalances;

/// Boolean. Masked/Unmasked card number
@property (nonatomic, strong, nullable, readwrite) NSNumber *maskIndicator;

/// Boolean. Type of account
@property (nonatomic, strong, nullable, readwrite) NSNumber *debitAccount;

/// Boolean. Type of account
@property (nonatomic, strong, nullable, readwrite) NSNumber *creditAccount;

/// Boolean. Privilege for external transfers
@property (nonatomic, strong, nullable, readwrite) NSNumber *externalTransferAllowed;

/// Product Kind Name
@property (nonatomic, strong, nullable, readwrite) NSString *productKindName;

//A list of legal entities ids to filter by
@property (nonatomic, strong, nullable, readwrite) NSArray<NSString *> *legalEntityIds;

/// String - maxLength: 11
@property (nonatomic, strong, nullable, readwrite) NSString *sourceId;

/// Boolean. Indicates whether an arrangement is favorite for a user or not
@property (nonatomic, strong, nullable, readwrite) NSNumber *favorite;

/// Full text search
@property (nonatomic, strong, nullable, readwrite) NSString *searchTerm;

/// Boolean. Parameter that identifies weather the returned list should be ordered by custom order/grouping
@property (nonatomic, strong, nullable, readwrite) NSNumber *customOrder;

/// Boolean. Parameter that sets favorite arrangements on top when true
@property (nonatomic, strong, nullable, readwrite) NSNumber *favoriteFirst;

/// Page Number. Skip over pages of elements by specifying a start value for the query
@property (nonatomic, strong, nullable, readwrite) NSNumber *from;

/// Record UUID. As an alternative for specifying 'from' this allows to point to the record to start the selection from
@property (nonatomic, strong, nullable, readwrite) NSString *cursor;

/// Limit the number of elements on the response. When used in combination with cursor, the value is allowed to be a negative number to indicate requesting records upwards from the starting point indicated by the cursor
@property (nonatomic, strong, nullable, readwrite) NSNumber *size;

/// Order by field
@property (nonatomic, strong, nullable, readwrite) NSString *orderBy;

/// one of ASC, DESC - default: DESC
@property (nonatomic, strong, nullable, readwrite) NSString *direction;

/**
 * Creates a BBContextualArrangementsParams.
 * @param businessFunction String. Provide the context for retrieving arrangements
 * @param resourceName String. Provide the resource for retrieving arrangements
 * @param privilege String. Privilege for the arrangements
 * @return The initialized BBProductSummaryParams object.
 */
- (instancetype)initWithBusinessFunction:(NSString *)businessFunction
                                resourceName:(NSString *)resourceName
                                privilege:(NSString *)privilege;

@end

NS_ASSUME_NONNULL_END

#endif /* BBContextualArrangementsParams_h */
