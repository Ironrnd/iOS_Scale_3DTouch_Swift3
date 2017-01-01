//
//  ViewController.swift
//  Scale
//
//  Created by Andrew Belozerov on 25.10.16.
//  Copyright © 2016 Andrew Iron. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    @IBOutlet weak var scaleView: ScaleView!
  
    @IBOutlet weak var forceLabel: UILabel!
    
    @IBOutlet weak var grammLabel: UILabel!
    
    var isPlaySound = true
    
    var isUpdate = true {
        didSet {
            if isUpdate == false {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.isUpdate = oldValue
                }
            }
        }
    }
    
    let cicrcleView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forceLabel.text = "0% force"
        grammLabel.text = "0 грамм"
        
        cicrcleView.layer.cornerRadius = 40
        cicrcleView.alpha = 0.6
        cicrcleView.backgroundColor = UIColor.red

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            cicrcleView.center = touch.location(in: view) // 1
            view.addSubview(cicrcleView) // 2
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            cicrcleView.center = touch.location(in: view)
            
            if #available(iOS 9.0, *) {
                if traitCollection.forceTouchCapability == UIForceTouchCapability.available {
                    if touch.force >= touch.maximumPossibleForce {
                        forceLabel.text = "100%+ force"
                        grammLabel.text = "385 грамм"
                        if isPlaySound {
                            AudioServicesPlaySystemSound(1519)
                            isPlaySound = false
                        }
                    } else {
                        
                        let force = (touch.force / touch.maximumPossibleForce) * 100
                        let grams = force * 385 / 100
                        let roundGrams = Int(grams)
                        
                        isPlaySound = true
                        if isUpdate {
                            forceLabel.text = "\(Int(force))% force"
                            grammLabel.text = "\(roundGrams) грамм"
                            isUpdate = false
                        }
                        
                        cicrcleView.transform = CGAffineTransform.init(scaleX: CGFloat(1 + (grams / 5) / 20), y: CGFloat(1 + (grams / 5) / 20))
                        
                    }
                }
            }
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        forceLabel.text = "0% force"
        grammLabel.text = "0 грамм"
        
        cicrcleView.removeFromSuperview()
        cicrcleView.transform = .identity
    }
    

}

