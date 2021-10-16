//
//  SquareBehavior.swift
//  BongoBongo
//
//  Created by Wesley Marra on 14/10/21.
//

import UIKit

class SquareBehavior: UIDynamicBehavior {
    
    private var gravity: UIGravityBehavior
    private var collision: UICollisionBehavior
    private var itemBehavior: UIDynamicItemBehavior
    
    override init() {
        gravity = UIGravityBehavior()
        collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        itemBehavior = UIDynamicItemBehavior()
        itemBehavior.elasticity = 0.7
        
        super.init()
        
        addChildBehavior(gravity)
        addChildBehavior(collision)
        addChildBehavior(itemBehavior)
    }
    
    public func addItem(_ item: UIDynamicItem) {
        gravity.addItem(item)
        collision.addItem(item)
        itemBehavior.addItem(item)
    }
    
    public func removeItem(_ item: UIDynamicItem) {
        gravity.removeItem(item)
        collision.removeItem(item)
        itemBehavior.removeItem(item)
    }
}
