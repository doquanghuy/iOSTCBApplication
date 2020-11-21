//
//  Created by Backbase R&D B.V. on 03/05/2019.
//

#ifndef BBProductItem_h
#define BBProductItem_h

#import <CommonUtils/CommonUtils.h>

@class BBProductKindItem;

/// Product item for an arrangement.
@interface BBProductItem : Additions

/// A unique identifier for the product that the arrangement applies to.
@property (strong, nonatomic, readonly, nullable) NSString *externalId;

/// The ID that is used by the Bank to identify the specific Product type - External reference to the product Type.
@property (strong, nonatomic, readonly, nullable) NSString *externalTypeId;

/// The label/name that is used to label a specific product type.
@property (strong, nonatomic, readonly, nullable) NSString *typeName;

/// Product Kind.
@property (strong, nonatomic, readonly, nullable) BBProductKindItem *productKind;

/**
 * Creates a BBProductItem.
 * @param externalId A unique identifier for the product that the arrangement applies to.
 * @param externalTypeId The ID that is used by the Bank to identify the specific Product type - External reference to the product Type.
 * @param typeName The label/name that is used to label a specific product type.
 * @param productKind Product Kind.
 * @return The initialized BBProductItem object.
 */
- (nonnull instancetype)initWithExternalId:(nullable NSString *)externalId
                            externalTypeId:(nullable NSString *)externalTypeId
                                  typeName:(nullable NSString *)typeName
                               productKind:(nullable BBProductKindItem*)productKind;

@end

#endif
