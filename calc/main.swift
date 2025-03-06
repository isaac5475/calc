//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program
let const5 = Operation(constant: 5);
let const10 = Operation(constant: 10);

let add = Operation(operand1: const5, operand2: const10, operationType: OpType.ADD)
print("10+5=", add.compute())
