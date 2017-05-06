//
//  CardBehavior.swift
//  ViewAnimation
//
//  Created by DAIXinming on 06/05/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

class CardBehavior<T: UIDynamicItem>: UIDynamicBehavior {

    var targetPoint: CGPoint = CGPoint(x: 0, y: 0) {
        willSet {
            self.attachmentBehavior?.anchorPoint = newValue
        }
    }
    var velocity: CGPoint = CGPoint(x: 0, y: 0) {
        willSet {
            let cucrrentVelocity = self.itemBehavior.linearVelocity(for: self.item)
            let velocityDelta = CGPoint(x: newValue.x - cucrrentVelocity.x, y: newValue.y - cucrrentVelocity.y)
            self.itemBehavior.addLinearVelocity(velocityDelta, for: self.item)
        }
    }
    var attachmentBehavior: UIAttachmentBehavior!
    var itemBehavior: UIDynamicItemBehavior!
    var item: T
    
    init(item: T) {
        self.item = item
        super.init()
        self.setup()
    }
    
    func setup() {
        let attachmentBehavior = UIAttachmentBehavior.init(item: self.item, attachedToAnchor: CGPoint(x: 0, y: 0))
        attachmentBehavior.frequency = 3.5
        attachmentBehavior.damping = 0.4
        attachmentBehavior.length = 0
        self.addChildBehavior(attachmentBehavior)
        self.attachmentBehavior = attachmentBehavior
        
        let itemBehavior = UIDynamicItemBehavior.init(items: [self.item])
        itemBehavior.density = 100
        itemBehavior.resistance = 10
        self.addChildBehavior(itemBehavior)
        self.itemBehavior = itemBehavior
    }
}
