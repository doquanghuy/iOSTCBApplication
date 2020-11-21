//
//  Created by Backbase R&D B.V. on 16/09/2019.
//

#import "BBProductConverter.h"

/**
 * The default saving account product converter for converting a list of saving accounts into a list of recipient models.
 * By default:
 * - Balance is assigned from product booked balance of the product.
 * - Account number is assigned from IBAN number of the product.
 * For customising the implementation details for Savings Account product type, please extend the ProductConverterFactory.
 */
@interface BBSavingsAccountConverter : NSObject<BBProductConverter>

@end

