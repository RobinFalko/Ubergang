//
//  Tweenable.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 05/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

public protocol Tweenable {
    var id: String { get }
    var duration: Double { get set }
    var progress: Double { get set }
    
    func start() -> Self
    func stop()
    func pause()
    func resume()
    func kill()
}