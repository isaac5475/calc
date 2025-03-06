//
//  Operation.swift
//  calc
//
//  Created by Murat Zaydullin on 6/3/2025.
//  Copyright © 2025 UTS. All rights reserved.
//

enum OpType {
    case ADD
    case SUBTR
    case CONST
}

class Operation {
    let operand1 : Operation?
    let operand2 : Operation?
    let operationType : OpType
    let value : Double?
    
    init(operand1: Operation, operand2: Operation, operationType: OpType) {
        self.operand1 = operand1;
        self.operand2 = operand2;
        self.operationType = operationType;
        value = nil;
    };
    init(constant: Double) {
        value = constant;
        operand1 = nil;
        operand2 = nil;
        self.operationType = OpType.CONST
    }
    func compute() -> Double {
        switch operationType {
        case .ADD:
            let val1 = operand1?.compute() ?? 0;
            let val2 = operand2?.compute() ?? 0;
            return val1 + val2;
        case .SUBTR:
            let val1 = operand1?.compute() ?? 0;
            let val2 = operand2?.compute() ?? 0;
            return val1 - val2;
        case .CONST:
            return value ?? 0;

        }
    }
}
