//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef ProductsClient_BBBaseProduct_h
#define ProductsClient_BBBaseProduct_h

#import <CommonUtils/CommonUtils.h>
#import <ProductsClient/BBStateItem.h>

NS_ASSUME_NONNULL_BEGIN

/// Parent of each product.
@interface BBBaseProduct : Additions

/// Reference to the product of which the arrangement is an instantiation.
@property (strong, nonatomic, readonly, nullable) NSString *identifier;

/// Name of the product
@property (strong, nonatomic, readonly, nullable) NSString *name;

/// Defines if transfer to another party is allowed. Type: Boolean
@property (strong, nonatomic, readonly, nullable) NSNumber *externalTransferAllowed;

/// Defines if cross currency transfer is allowed. Type: Boolean
@property (assign, nonatomic, readonly) BOOL crossCurrencyAllowed;

/// The label/name that is used for the respective product kind
@property (strong, nonatomic, readonly, nullable) NSString *productKindName;

/// The label/name that is used to label a specific product type
@property (strong, nonatomic, readonly, nullable) NSString *productTypeName;

/// The name that can be assigned by the customer to label the arrangement.
@property (strong, nonatomic, readonly, nullable) NSString *bankAlias;

/// Indicate if the account is regular or external.
@property (strong, nonatomic, readonly, nullable) NSString *sourceId;

/// Opening date for the account.
@property (strong, nonatomic, readonly, nullable) NSString *accountOpeningDate;

/// Last date of parameter update for the arrangement.
@property (strong, nonatomic, readonly, nullable) NSString *lastUpdateDate;

/// User defined preferences for a specific arrangement. Note: each user might have different preferences.
@property (strong, nonatomic, readonly, nullable) BBUserPreferencesItem *userPreferences;

/// State of the product.
@property (strong, nonatomic, readonly, nullable) BBStateItem *state;

/// Reference to the parent of the arrangement.
@property (strong, nonatomic, readonly, nullable) NSString *parentId;


/// This property is required to convert to Actual class type when using `mapToProduct: error:`
@property (strong, nonatomic, readonly) NSString *className;

/**
 * Convenience method that converts accountOpeningDate property into the given or default date-time format.
 * @param dateFormat date-time format to parse the accountOpeningDate object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for accountOpeningDate.
 */
-(nullable NSDate*)accountOpeningDate:(nullable NSString*)dateFormat;

/**
 * Convenience method that converts lastUpdateDate property into the given or default date-time format.
 * @param dateFormat date-time format  to parse the lastUpdateDate object into.
 * Default value: `yyyy-MM-dd'T'HH:mm:ss.SSSXXX`.
 * Assign dateFormat once the DBS changes this default format to another date-time format.
 * @return parsed date object for lastUpdateDate.
 */
-(nullable NSDate*)lastUpdateDate:(nullable NSString*)dateFormat;

#pragma Mark: Convenience Method

/// A convenience method to map json dictionary to child products like BBCurrentAccount, BBSavingsAccount etc.
/// @param jsonObject json object that has `class` key so it can convert to child product.
/// @param error error object if something goes wrong
+(nullable instancetype)mapToProduct:(NSDictionary *)jsonObject error:(NSError *__autoreleasing *)error;

@end

NS_ASSUME_NONNULL_END

#endif /* ProductsClient_BBBaseProduct_h */
