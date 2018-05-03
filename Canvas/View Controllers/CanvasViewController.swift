//
//  CanvasViewController.swift
//  Canvas
//
//  Created by user132893 on 5/3/18.
//  Copyright © 2018 user132893. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {

    @IBOutlet weak var trayView: UIView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.trayDownOffset = 160
        self.trayUp = self.trayView.center
        self.trayDown = CGPoint(x: self.trayView.center.x, y: self.trayView.center.y + self.trayDownOffset)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began{
            self.trayOriginalCenter = self.trayView.center
        }
        else if sender.state == .changed{
            self.trayView.center = CGPoint(x: self.trayOriginalCenter.x, y: self.trayOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended{
            var velocity = sender.velocity(in: view)
            
            if velocity.y > 0
            {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                }, completion: nil)
            }
            else
            {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayUp
                }, completion: nil)
                
            }
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        if sender.state == .began{
            var imageView = sender.view as! UIImageView
            self.newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(self.newlyCreatedFace)
            self.newlyCreatedFace.center = imageView.center
            self.newlyCreatedFace.center.y += self.trayView.frame.origin.y
            self.newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            self.newlyCreatedFace.isUserInteractionEnabled = true
            
            var panGesture = UIPanGestureRecognizer(target: self, action: #selector(panNewFace(panGesture:)))
            self.newlyCreatedFace.addGestureRecognizer(panGesture)
            
        }
        else if sender.state == .changed{
            self.newlyCreatedFace.center = CGPoint(x: self.newlyCreatedFaceOriginalCenter.x + translation.x, y: self.newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended{
            
        }
    }
    
    @objc func panNewFace(panGesture: UIPanGestureRecognizer){
        let translation = panGesture.translation(in: view)
        
        if panGesture.state == .began{
            self.newlyCreatedFace = panGesture.view as! UIImageView
            self.newlyCreatedFaceOriginalCenter = self.newlyCreatedFace.center
        }
        else if panGesture.state == .changed{
            self.newlyCreatedFace.center = CGPoint(x: self.newlyCreatedFaceOriginalCenter.x + translation.x, y: self.newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if panGesture.state == .ended{
            
        }
    }
}
