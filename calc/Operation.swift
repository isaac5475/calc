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
    case MULT
    case DIV
    case MOD
}

enum ArithmeticError : Error {
    case DivisionBy0
    case NonPositiveMod
}

class Operation {
    let operand1 : Operation?
    let operand2 : Operation?
    let operationType : OpType
    let value : Int?
    
    init(operand1: Operation, operand2: Operation, operationType: OpType) {
        self.operand1 = operand1;
        self.operand2 = operand2;
        self.operationType = operationType;
        value = nil;
    };
    init(constant: Int) {
        value = constant;
        operand1 = nil;
        operand2 = nil;
        self.operationType = OpType.CONST
    }
    func compute() throws -> Int {
        let val1: Int;
        let val2: Int;
        do {
            val1 = try operand1?.compute() ?? 0;
            val2 = try operand2?.compute() ?? 0;
        } catch ArithmeticError.DivisionBy0 {
            throw ArithmeticError.DivisionBy0;
        } catch ArithmeticError.NonPositiveMod {
            throw ArithmeticError.NonPositiveMod
        }
        
        switch operationType {
        case .ADD:
            return val1 + val2;
        case .SUBTR:
            return val1 - val2;
        case .MULT:
            return val1 * val2;
        case .DIV:
            if val2 == 0 {
                throw ArithmeticError.DivisionBy0;
            }
            return val1 / val2;
        case .MOD:
            if val2 <= 0 {
                throw ArithmeticError.NonPositiveMod;
            }
            return val1 % val2;
        case .CONST:
            return value ?? 0;

        }
    }
}
