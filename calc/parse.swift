//
//  parse.swift
//  calc
//
//  Created by Murat Zaydullin on 6/3/2025.
//  Copyright © 2025 UTS. All rights reserved.
//
enum ParseError : Error {
    case IllegalArguments
}
func parse(_ args: [String]) throws -> Operation {
    if !isValidInput(args) {
        throw ParseError.IllegalArguments;
    }
    var argsM = args;
    var result =  Operation(constant: Int(argsM.popLast() ?? "0")!);
    
    while !argsM.isEmpty {
        let operationType = switch argsM.popLast() ?? "" {
        case "+":
            OpType.ADD
        case "-":
            OpType.SUBTR
        default:
            OpType.CONST
        }
        if operationType == OpType.CONST {
            throw ParseError.IllegalArguments
        }
        let val = Int(argsM.popLast()!)!
        result = Operation(operand1: Operation(constant: val), operand2: result, operationType: operationType)
    }
    return result;
}

func isValidInput(_ args: [String]) -> Bool {
    if args.isEmpty || args.count < 3 {
        return false;
    }
    let operators = [
        "+",
        "-",
        "x",
        "/",
        "%"
    ];
    var isNextOperator = false    // alternates between digits and operators
    for token in args {
        if isNextOperator {
            if !operators.contains(token) {
                return false;
            }
        } else {
            if Double(token) == nil {
                return false;
            }
        }
        isNextOperator = !isNextOperator;
    }
    return true;
}
