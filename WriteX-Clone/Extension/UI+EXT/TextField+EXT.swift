//
//  TextField+Publisher.swift
//  WriteX
//
//  Created by Ahmed Fathy on 03/03/2022.
//

import UIKit


extension UITextField {

    
    func shakeField(){
        let animatoin                   = CAKeyframeAnimation(keyPath: "position.x")
        animatoin.values                = [0,10,-10,10,0]
        animatoin.keyTimes              = [0,0.08,0.25,0.415,0.5]
        animatoin.duration              = 0.5
        animatoin.fillMode              = .forwards
        animatoin.isRemovedOnCompletion = false
        animatoin.isAdditive            = true
        DispatchQueue.main.async { self.layer.add(animatoin, forKey: nil) }
    }
    
}
