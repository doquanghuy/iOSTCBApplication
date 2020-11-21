//
//  Created by Backbase R&D B.V. on 04/09/2018.
//

#ifndef BBAction_h
#define BBAction_h

#import <Foundation/NSString.h>

/// An array of actions that could be performed on a payment order. Actions that can be done are dependant on the payment itself.
typedef NSString *BBAction NS_TYPED_ENUM;

extern BBAction const kBBActionApprove;
extern BBAction const kBBActionReject;
extern BBAction const kBBActionCancel;
extern BBAction const kBBActionDelete;

#endif
