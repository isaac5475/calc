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
    let lastNumber = Int(argsM.popLast() ?? "0");
    if lastNumber == nil {
        throw ParseError.IllegalArguments;
    }
    var result =  Operation(constant: lastNumber!);

    while !argsM.isEmpty {
        let operationType = parseOperator(argsM.popLast()!.first!);
        if operationType == OpType.CONST {
            throw ParseError.IllegalArguments
        }
        let val = Int(argsM.popLast()!)
        if val == nil {
            throw ParseError.IllegalArguments;
        }
        result = Operation(operand1: Operation(constant: val!), operand2: result, operationType: operationType)
    }
    return result;
}

func parseOperator(_ char: Character) -> OpType {
    return switch char {
    case "+":
        OpType.ADD
    case "-":
        OpType.SUBTR
    case "/":
        OpType.DIV
    case "x":
        OpType.MULT
    case "%":
        OpType.MOD
    default:
        OpType.CONST
    }
}

func reducePriorityOperators(_ args: [String]) throws -> [String] {
    var argsM = args;
    do {
        var i = 0;
        let priorityOperators = ["x", "/", "%"];
        while i <= argsM.count {
            if priorityOperators.contains(argsM[i]) {    //  if this token is *, / or %, previous and successing are integers
                let op = parseOperator(argsM[i].first!);
                if op == OpType.CONST {
                    throw ParseError.IllegalArguments;
                }
                let leftOperand = Int(argsM[i - 1]);
                let rightOperand = Int(argsM[i + 1]);
                if leftOperand == nil || rightOperand == nil {
                    throw ParseError.IllegalArguments;
                }
                let reduced = try Operation(operand1: Operation.init(constant: leftOperand!), operand2: Operation(constant: rightOperand!), operationType: op).compute();
                argsM.replaceSubrange(i - 1...i + 2, with: [String(reduced)])
                i -= 1; //  3 elements reduced to 1
            }
            i += 1;
        }
    } catch ArithmeticError.DivisionBy0 {
        throw ArithmeticError.DivisionBy0;
    } catch ArithmeticError.NonPositiveMod {
        throw ArithmeticError.NonPositiveMod
    }
    return argsM;
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
