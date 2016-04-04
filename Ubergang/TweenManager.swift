//
//  TweenManager.swift
//  Tween
//
//  Created by RF on 10/01/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

import Foundation

public class TweenManager {
    private static let instance = TweenManager()
    
    private var mapTable = NSMapTable(keyOptions: .StrongMemory, valueOptions: .WeakMemory)
    
    public class func registerTween(tween: Tweenable) {
        instance.mapTable.setObject(tween as? AnyObject, forKey: tween.id)
    }
    
    public class func unregisterTween(tween: Tweenable) {
        
        instance.mapTable.setObject(nil, forKey: tween.id)
    }
    
    public class func all( execute: (Tweenable) -> Void ) {
        let enumerator = instance.mapTable.objectEnumerator()
        while let any: AnyObject = enumerator?.nextObject() {
            if let tweenable = any as? Tweenable {
                execute(tweenable)
            }
        }
    }
    
    public class func tweenById(id: String) -> Tweenable? {
        return instance.mapTable.objectForKey(id) as? Tweenable
    }
}
