//
//  Created by Backbase R&D B.V. on 16/09/2019.
//

#import "BBProductConverter.h"

/**
 * The default current account product converter for converting a list of current accounts into a list of recipient models.
 * By default:
 * - Balance is assigned from product booked balance.
 * - Account number is assigned from IBAN number.
 * For customising the implementation details for Current Account product type, please extend the ProductConverterFactory.
 */
@interface BBCurrentAccountConverter : NSObject<BBProductConverter>

@end
