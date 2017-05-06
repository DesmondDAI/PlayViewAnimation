//
//  DraggableCardView.swift
//  ViewAnimation
//
//  Created by DAIXinming on 06/05/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

protocol DraggableCardViewDelegate {
    
    func beganDragging(cardView: DraggableCardView)
    func endedDragging(cardView: DraggableCardView, withVelocity velocity: CGPoint)
}

class DraggableCardView: UIView {

    var delegate: DraggableCardViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Internal Methods
    private func setup() {
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(cardViewDidPan(_:)))
        self.addGestureRecognizer(panRecognizer)
    }
    
    
    // MARK: - Actions
    @objc func cardViewDidPan(_ recognizer: UIPanGestureRecognizer) {
        let point = recognizer.translation(in: self.superview)
    }
}
