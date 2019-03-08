//
//  NSNotification+Extension.swift
//  Tweeter
//
//  Created by MACOS on 3/6/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import UIKit

struct KeyboardAnimationInfo {
    var constraint: CGFloat = 0
    var duration: TimeInterval = 0
    var option = UIView.KeyframeAnimationOptions.allowUserInteraction
}

extension NSNotification {
    func getKeyboardInfo() -> KeyboardAnimationInfo? {
        guard let userInfo = self.userInfo else {
            return nil
        }
        
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        let endFrameY = endFrame?.origin.y ?? 0
        let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
        let animationCurve = UIView.KeyframeAnimationOptions(rawValue: animationCurveRaw)
        var yConstraint: CGFloat
        
        if endFrameY >= UIScreen.main.bounds.size.height {
            yConstraint = 0
        } else {
            let bottomSafeArea = UIApplication.shared.bottomSafeAreaInsets
            yConstraint = (endFrame?.size.height ?? 0.0) - bottomSafeArea
        }
        
        return KeyboardAnimationInfo(constraint: yConstraint, duration: duration, option: animationCurve)
    }
}
