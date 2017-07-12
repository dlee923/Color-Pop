//
//  ColorGridVC.swift
//  Color Pop
//
//  Created by Daniel Lee on 4/20/17.
//  Copyright © 2017 DLEE. All rights reserved.
//

import UIKit

class ColorGridVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        
        blockWidth = self.view.frame.width / blocksPerRow
        guard let _blockWidth = blockWidth else { return }
        
        numberOfRows = self.view.frame.height / _blockWidth
        guard let _numberOfRows = numberOfRows else { return }
        
        
        for y in 0...Int(_numberOfRows) {
            for x in 0..<Int(blocksPerRow) {
                let colorBlock = UIView()
                colorBlock.frame = CGRect(x: CGFloat(x) * _blockWidth, y: CGFloat(y) * _blockWidth, width: _blockWidth, height: _blockWidth)
                colorBlock.layer.borderWidth = 1
                colorBlock.layer.borderColor = UIColor.black.cgColor
                colorBlock.backgroundColor = customColor()
                self.view.addSubview(colorBlock)
                let key = "\(x)|\(y)"
                views[key] = colorBlock
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handleGesture)))
    }
    
    var selectedCell: UIView?
    let blocksPerRow: CGFloat = 15
    var numberOfRows: CGFloat?
    var blockWidth: CGFloat?
    var views = [String: UIView]()
    
    func handleGesture(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: self.view)
        
        guard let _blockWidth = blockWidth else { return }
        let x = Int(location.x / _blockWidth)
        let y = Int(location.y / _blockWidth)
        
        print("\(x),\(y)")
        
        let key = "\(x)|\(y)"
        let touchedCell = views[key]
        
        if selectedCell != touchedCell {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.bringSubview(toFront: touchedCell!)
                touchedCell?.layer.transform = CATransform3DMakeScale(3, 3, 3)
                
            }, completion: nil)
        }
        
        selectedCell = touchedCell
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: { 
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
    }

    fileprivate func customColor() -> UIColor {
        let randomRed = arc4random_uniform(255)
        let randomGreen = arc4random_uniform(255)
        let randomBlue = drand48()
        //can use drand48 instead
//        print("red: \(randomRed)")
//        print("green: \(randomGreen)")
//        print("blue: \(randomBlue)")
        return UIColor(red: CGFloat(randomRed)/255, green: CGFloat(randomGreen)/255, blue: CGFloat(randomBlue), alpha: 1)
    }



}

