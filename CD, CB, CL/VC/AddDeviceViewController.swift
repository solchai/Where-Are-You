//
//  AddDeviceViewController.swift
//  AddDeviceViewController
//
//  Created by Solomon Chai on 2021-09-06.
//

import UIKit

protocol AddDeviceDelegate {
    func successfullyAddedDevice(deviceType: String, uuid: String)
}

class AddDeviceViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var deviceImageView: UIImageView!
    
    @IBOutlet weak var negativeButton: UIButton!
    
    @IBOutlet weak var positiveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        deviceImageView.image = UIImage(named: "iAmHere")
        
        negativeButton.setTitle("Cancel", for: .normal)
        negativeButton.tintColor = .white
        negativeButton.backgroundColor = .red
        negativeButton.layer.masksToBounds = true
        negativeButton.layer.cornerRadius = 5
        
        positiveButton.setTitle("Add", for: .normal)
        positiveButton.tintColor = .white
        positiveButton.backgroundColor = .green
        positiveButton.setTitleColor(.gray, for: .disabled)
        positiveButton.layer.masksToBounds = true
        positiveButton.layer.cornerRadius = 5
        positiveButton.isEnabled = false
    }
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

}
