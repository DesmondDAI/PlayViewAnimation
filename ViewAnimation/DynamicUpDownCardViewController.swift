//
//  DynamicUpDownCardViewController.swift
//  ViewAnimation
//
//  Created by DAIXinming on 06/05/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

enum CardViewState {
    case closed
    case open
}

/**
 * MEMO: Cannot make UIKit Dynamics work with Auto Layout:
 * when I set constraints for cardView and perform pan gesture, the cardView can flash back to where it is according to constraints
 */
class DynamicUpDownCardViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    
    lazy var dynamicAnimator: UIDynamicAnimator = UIDynamicAnimator.init(referenceView: self.view)
    var cardViewBehavior: CardBehavior<UIDynamicItem>?
    var cardViewState: CardViewState = .closed
    
    override func viewDidLoad() {
        super.viewDidLoad()

        customCardView()
        self.dynamicAnimator.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("did layout subviews")
    }

    
    // MARK: - Internal Methods
    private func customCardView() {
        cardView.layer.cornerRadius = 12.0
//        let tapOnCardView = UITapGestureRecognizer(target: self, action: #selector(cardViewDidTap(_:)))
//        tapOnCardView.numberOfTapsRequired = 1
//        cardView.addGestureRecognizer(tapOnCardView)
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(cardViewDidPan(_:)))
        cardView.addGestureRecognizer(panRecognizer)
    }
    
    private func beginDraggingCardView() {
        self.dynamicAnimator.removeAllBehaviors()
    }
    
    private func endedDraggingCardViewWithVelocity(_ velocity: CGPoint) {
        self.cardViewState = velocity.y >= 0 ? .closed : .open
        animateCardViewWithInitialVelocity(velocity)
    }
    
    private func animateCardViewWithInitialVelocity(_ initialVelocity: CGPoint) {
        if self.cardViewBehavior == nil {
            self.cardViewBehavior = CardBehavior.init(item: cardView)
        }
        
        let rootViewSize = view.bounds.size
        self.cardViewBehavior!.targetPoint = self.cardViewState == .closed ? CGPoint(x: rootViewSize.width / 2, y: rootViewSize.height * 1.2) : CGPoint(x: rootViewSize.width / 2, y: rootViewSize.height * 0.8)
        if !__CGPointEqualToPoint(initialVelocity, CGPoint(x: 0, y: 0)) {
            self.cardViewBehavior!.velocity = initialVelocity
        }
        self.dynamicAnimator.addBehavior(self.cardViewBehavior!)
    }
    
    
    // MARK: - Actions
    @objc func cardViewDidTap(_ sender: UITapGestureRecognizer) {
        
    }
    
    @objc func cardViewDidPan(_ recognizer: UIPanGestureRecognizer) {
        // Note that this is the total translation instead of delta changes
        let point = recognizer.translation(in: cardView.superview)
//        cardViewTopToBottomConstraint.constant = cardViewTopToBottomConstraint.constant - point.y
        cardView.center.y = cardView.center.y + point.y
        recognizer.setTranslation(CGPoint(x: 0, y: 0), in: cardView.superview)
        
        if recognizer.state == .ended {
            var velocity = recognizer.velocity(in: cardView.superview)
            velocity.x = 0
            self.endedDraggingCardViewWithVelocity(velocity)
        } else if recognizer.state == .began {
            self.beginDraggingCardView()
        }
    }
}


extension DynamicUpDownCardViewController: UIDynamicAnimatorDelegate {
    
    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
        print("animator did pause")
    }
    
    func dynamicAnimatorWillResume(_ animator: UIDynamicAnimator) {
        print("animator will resume")
    }
}
