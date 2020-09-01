//
//  ViewController.swift
//  drink
//
//  Created by fun on 2020/8/19.
//

import UIKit

class ViewController: UIViewController{
    
    
    
    
    
    

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet var containers: [UIView]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        segment.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 25) ], for: .normal)  //設定segmentControl大小
    }
            
   

    @IBAction func changeController(_ sender: UISegmentedControl) {
        for container in containers {
            container.isHidden = true
        }
        containers[sender.selectedSegmentIndex].isHidden = false
        
        
    }
    
}


