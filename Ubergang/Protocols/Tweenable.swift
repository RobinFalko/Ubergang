//
//  Tweenable.swift
//  Ubergang
//
//  Created by RF on 05/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

public protocol Tweenable {
    var id: String { get }
    
    func start() -> Self
    func stop()
    func pause()
    func resume()
    func kill()
}