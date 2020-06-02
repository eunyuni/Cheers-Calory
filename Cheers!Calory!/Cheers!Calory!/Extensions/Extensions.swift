//
//  Extensions.swift
//  Cheers!Calory!
//
//  Created by MyMac on 2020/06/02.
//  Copyright © 2020 sandMan. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    // rootView 교체 할 때 애니메이션 넣는 기능
    func switchRootViewController(_ viewController: UIViewController,  animated: Bool, duration: TimeInterval, options: UIView.AnimationOptions, completion: (() -> Void)?) {
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
}
