//
//  Created by Backbase R&D B.V. on 03/09/2018.
//

#ifndef BBInstructionPriority_h
#define BBInstructionPriority_h

#import <Foundation/NSString.h>

/// Specify the priority of execution of the payment order.
typedef NSString *BBInstructionPriority NS_TYPED_ENUM;

extern BBInstructionPriority const kBBInstructionPriorityNorm;
extern BBInstructionPriority const kBBInstructionPriorityHigh;

#endif
