//
//  ViewController.swift
//  CD, CB, CL
//
//  Created by Solomon Chai on 2021-09-04.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var centralButton: UIButton!
    
    @IBOutlet weak var peripheralButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        centralButton.imageView?.alpha = 0.1
        centralButton.titleLabel?.font = UIFont(name: "Helvetica", size: 28.0)
        
        peripheralButton.imageView?.alpha = 0.1
        peripheralButton.titleLabel?.font = UIFont(name: "Helvetica", size: 28.0)
        
        if let name = UserDefaults.standard.object(forKey: "peripheralName") as? String {
            navigationItem.title = "Welcome back \(name)"
        }
    }


    @IBAction func openCentralView(_ sender: UIButton) {
        
    }
    
    
    @IBAction func openPeripheralView(_ sender: UIButton) {
        
    }
}

