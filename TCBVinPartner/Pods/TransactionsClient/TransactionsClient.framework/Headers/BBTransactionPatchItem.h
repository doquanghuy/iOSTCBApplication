//
//  Created by Backbase R&D B.V. on 02/11/2018.
//

#import <CommonUtils/CommonUtils.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBTransactionPatchItem : Additions

/// Unique identification for the transaction as used in the external system.
@property (strong, nonatomic, readonly) NSString *identifier;

/// Unique identification for the arrangement of the transaction.
@property (strong, nonatomic, readonly) NSString *arrangementId;

/// Transaction category.
@property (strong, nonatomic, nullable, readonly) NSString *category;

/// Notes.
@property (strong, nonatomic, nullable, readonly) NSString *notes;

/**
 * Create an BBTransactionPatchItem object for a PATCH request.
 * @param identifier Unique identification for the transaction as used in the external system.
 * @param arrangementId Unique identification for the arrangement of the transaction.
 * @param category Transaction category.
 * @param notes Notes.
 * @return The initialized BBTransactionPatchItem object.
 */
- (nonnull instancetype)initWithIdentifier:(NSString *)identifier
                             arrangementId:(NSString *)arrangementId
                                  category:(nullable NSString *)category
                                     notes:(nullable NSString *)notes;

@end

NS_ASSUME_NONNULL_END
