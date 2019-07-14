//
//  TweenDirection.swift
//  Ubergang
//
//  Created by Robin Frielingsdorf on 10/04/16.
//  Copyright © 2016 Robin Falko. All rights reserved.
//

// Picture: Timeline containing 3 tweens
/*
 forward -->
 t0: |-----------------------|
 t1:      |----------------------|
 t2: |--------|
 */

/*
 <-- reverse
 t0: |-----------------------|
 t1:      |----------------------|
 t2: |--------|
 */

/*
 <-- backward
 t0:     |-----------------------|
 t1: |----------------------|
 t2:                    |--------|
 */

public enum TweenDirection {
    case forward //play the tween from 0 to 1
    case reverse //play the tween from 1 to 0 without adjustments
    case backward //play the tween from 1 to 0, inverse easings, and tween start times
}


