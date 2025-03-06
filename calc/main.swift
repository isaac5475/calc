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
do {
    if args.count == 1 {
        let int = Int(args[0]);
        if int != nil {
            print(int!)
        } else {
            throw ParseError.IllegalArguments;
        }
    } else {
        let op = try parse(args);
        print(try op.compute())
    }
} catch  {
    print("Error")
    exit(1);
}
