//
//  FPBattleShip.swift
//  FunctionalProgramming
//
//  Created by R_flava_Man on 16/1/21.
//  Copyright © 2016年 R_style_Man. All rights reserved.
//

import UIKit

class FPBattleShip: NSObject {
    typealias Position = CGPoint
    typealias Distance = CGFloat
    
    let minimumDistance :Distance = 2.0
    
    //我方战舰在原点
    func inRange1(target: Position, range: Distance) -> Bool {
        return sqrt(target.x * target.x + target.y + target.y) <= range
    }
    
    //我方战舰不在原点
    func inRange2(target: Position, ownPosition: Position, range: Distance) -> Bool {
        let dx = ownPosition.x - target.x;
        let dy = ownPosition.y - target.y;
        let targetDistance = sqrt(dx*dx + dy*dy)
        return targetDistance <= range
    }
    
    func inRange3(target: Position, ownPosition: Position, range: Distance) -> Bool {
        let dx = ownPosition.x - target.x;
        let dy = ownPosition.y - target.y;
        let targetDistance = sqrt(dx*dx + dy*dy)
        return targetDistance <= range && targetDistance >= minimumDistance
    }
    
    func inRange4(tagert: Position, ownPosition:Position, friendly: Position, range: Distance) -> Bool {
        let dx = ownPosition.x - tagert.x
        let dy = ownPosition.y - tagert.y
        let targetDistance = sqrt(dx*dx + dy*dy)
        let friendlyDx = friendly.x - tagert.x
        let friendlyDy = friendly.y - tagert.y
        let friendlyDistance = sqrt(friendlyDx*friendlyDx + friendlyDy*friendlyDy)
        
        return targetDistance <= range && targetDistance >= minimumDistance && friendlyDistance >= minimumDistance
    }
    
    //MARK: First-ClassFunctions
    func pointInRange(point: Position) -> Bool {
        // Implement method here
        if point.x < 10 && point.y < 10 {
            return true
        } else {
            return false
        }
    }
    
    typealias Region = Position -> Bool
    
    func circle(radius: Distance) -> Region {
        return { point in
            sqrt(point.x*point.x + point.y*point.y) <= radius
        }
    }
    
    func circlr2(radius: Distance, center: Position) -> Region {
        return { point in
            let shiftedPoint = Position(x: point.x - center.x, y: point.y - center.y)
            return sqrt(shiftedPoint.x*shiftedPoint.x + shiftedPoint.y*shiftedPoint.y) <= radius
        }
    }
    
    
}
