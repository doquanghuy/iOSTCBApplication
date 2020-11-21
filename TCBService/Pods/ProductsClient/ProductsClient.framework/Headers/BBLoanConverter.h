//
//  Created by Backbase R&D B.V. on 16/09/2019.
//

#import "BBProductConverter.h"

/**
 * The default loan product converter for converting a list of loans into a list of recipient models.
 * By default:
 * - Balance is assigned from product booked balance of the product.
 * - Account number is assigned from product number of the product.
 * For customising the implementation details for Loan product type, please extend the ProductConverterFactory.
 */
@interface BBLoanConverter : NSObject<BBProductConverter>

@end
