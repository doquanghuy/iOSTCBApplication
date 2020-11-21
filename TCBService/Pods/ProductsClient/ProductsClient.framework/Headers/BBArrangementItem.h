//
//  Created by Backbase R&D B.V. on 08/05/2019.
//

#ifndef ProductsClient_BBArrangementItem_h
#define ProductsClient_BBArrangementItem_h

#import <CommonUtils/CommonUtils.h>
#import "BBArrangementBaseItem.h"
#import "BBStateItem.h"

/// This class is a response class for arrangement item.
@interface BBArrangementItem : BBArrangementBaseItem

/// A unique identifier for the Arrangement object that is generated and used Internally in DBS.
/// Max Length: 36
@property (strong, nonatomic, nonnull, readonly) NSString* identifier;

/// Reference to the legal entity that is the owner of the arrangement.
/// Min Items: 1
/// Max Length of each item: 36
@property (strong, nonatomic, nonnull, readonly) NSArray<NSString*>* legalEntityIds;

/// A unique identifier for the product that the arrangement applies to.
/// Max Length: 50
@property (strong, nonatomic, nonnull, readonly) NSString* externalProductId;

/// The product kind name.
/// Max Length: 50
@property (strong, nonatomic, nullable, readonly) NSString* productKindName;

/// The product type name.
/// Max Length: 50
@property (strong, nonatomic, nullable, readonly) NSString* productTypeName;

/// User defined preferences for a specific arrangement. Note: each user might have different preferences
@property (strong, nonatomic, nullable, readonly) BBUserPreferencesItem* userPreferences;

/// Product of the arrangement
@property (strong, nonatomic, nullable, readonly) BBProductItem* product;

/// State of the product.
@property (strong, nonatomic, nullable, readonly) BBStateItem *state;

/// Indicate if the account has parent child relationship with another account
@property (strong, nonatomic, nullable, readonly) NSString* parentId;

@end

#endif /* ProductsClient_BBArrangementItem_h */
