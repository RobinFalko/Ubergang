//
//  UTweenLoggable.swift
//  Ubergang
//
//  Created by RF on 18/07/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

public protocol UTweenLoggable {
    func verbose(_ msg: String, function: String, file: String, line: Int)
    func debug(_ msg: String, function: String, file: String, line: Int)
    func info(_ msg: String, function: String, file: String, line: Int)
    func warning(_ msg: String, function: String, file: String, line: Int)
    func error(_ msg: String, function: String, file: String, line: Int)
}


extension UTweenLoggable {
    func verbose(_ msg: String, function: String = #function, file: String = #file, line: Int = #line) {
        print("[\(file) - \(function)->\(line)]:\(msg)")
    }
    
    func debug(_ msg: String, function: String = #function, file: String = #file, line: Int = #line) {
        print("[\(file) - \(function)->\(line)]:\(msg)")
    }
    
    func info(_ msg: String, function: String = #function, file: String = #file, line: Int = #line) {
        print("[\(file) - \(function)->\(line)]:\(msg)")
    }
    
    func warning(_ msg: String, function: String = #function, file: String = #file, line: Int = #line) {
        print("[\(file) - \(function)->\(line)]:\(msg)")
    }
    
    func error(_ msg: String, function: String = #function, file: String = #file, line: Int = #line) {
        print("[\(file) - \(function)->\(line)]:\(msg)")
    }
}


class UTweenLogger: UTweenLoggable {}
