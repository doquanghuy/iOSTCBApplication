//
//  Created by Backbase R&D B.V. on 16/09/2019.
//

#import "BBProductConverter.h"

/**
 * The default term deposit product converter for converting a list of term deposits into a list of recipient models.
 * By default:
 * - Balance is assigned from principal amount of the product.
 * - Account number is assigned from IBAN number of the product.
 * For customising the implementation details for Term Deposit product type, please extend the ProductConverterFactory.
 */
@interface BBTermDepositConverter : NSObject<BBProductConverter>

@end
