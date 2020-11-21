//
//  Created by Backbase R&D B.V. on 16/09/2019.
//

#import "BBProductConverter.h"

/**
 * The default investment account product converter for converting a list of investment accounts into a list of recipient models.
 * By default:
 * - Balance is assigned from current investment value of the product.
 * - Account number is assigned from product number of the product.
 * For customising the implementation details for Investment Account product type, please extend the ProductConverterFactory.
 */
@interface BBInvestmentAccountConverter : NSObject<BBProductConverter>

@end
