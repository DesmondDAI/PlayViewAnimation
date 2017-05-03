//
//  InteractiveAnimationViewController.swift
//  ViewAnimation
//
//  Created by DAIXinming on 03/05/2017.
//  Copyright © 2017 Xinming DAI. All rights reserved.
//

import UIKit

class InteractiveAnimationViewController: UIViewController {

    @IBOutlet weak var animateView: UIView!
    @IBOutlet weak var startBtn: UIButton!
    
    lazy var animator: UIViewPropertyAnimator = {
        let cubicParams = UICubicTimingParameters(controlPoint1: CGPoint(x: 0, y: 0.5), controlPoint2: CGPoint(x: 1.0, y: 0.5))
        let animator = UIViewPropertyAnimator(duration: 1.0, timingParameters: cubicParams)
        animator.isInterruptible = true
        return animator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBtn.addTarget(self, action: #selector(startBtnDidClick(_:)), for: .touchUpInside)
        animator.addAnimations {
            [unowned self] in
            self.animateView.backgroundColor = .yellow
        }
    }
    
    
    // MARK: - Actions
    @objc func startBtnDidClick(_ sender: UIButton?) {
        switch animator.state {
        case .active:
            animator.isReversed = true
            
        case .inactive:
            animator.addAnimations {
                [unowned self] in
                self.animateView.backgroundColor = .yellow
            }
            animator.addCompletion {
                (position) in
                switch position {
                case .start:
                    print("position: start")
                    
                case .current:
                    print("position: current")
                    
                case .end:
                    print("position: end")
                    self.animateView.backgroundColor = .red
                }
            }
            animator.startAnimation()
            
        default:
            break
        }
    }
}
