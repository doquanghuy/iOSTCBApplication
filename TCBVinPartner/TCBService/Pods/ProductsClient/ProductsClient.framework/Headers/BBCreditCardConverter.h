//
//  Created by Backbase R&D B.V. on 16/09/2019.
//

#import "BBProductConverter.h"

/**
 * The default credit card product converter for converting a list of credit cards into a list of recipient models.
 * By default:
 * - Balance is assigned from product booked balance.
 * - Account number is assigned from product number.
 * For customising the implementation details for Credit Card product type, please extend the ProductConverterFactory.
 */
@interface BBCreditCardConverter : NSObject<BBProductConverter>

@end
