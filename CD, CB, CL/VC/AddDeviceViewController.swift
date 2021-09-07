//
//  AddDeviceViewController.swift
//  AddDeviceViewController
//
//  Created by Solomon Chai on 2021-09-06.
//

import UIKit
import CoreBluetooth

let serviceUUID = CBUUID(string: "WhereAreYou")

protocol AddDeviceDelegate {
    func successfullyAddedDevice(deviceType: String, uuid: String)
}

class AddDeviceViewController: UIViewController {

    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var deviceImageView: UIImageView!
    
    @IBOutlet weak var negativeButton: UIButton!
    
    @IBOutlet weak var positiveButton: UIButton!
    
    var centralManager: CBCentralManager!
    var delegate: AddDeviceDelegate?
    var owner: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        centralManager = CBCentralManager(delegate: self, queue: nil)
        
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

extension AddDeviceViewController:CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
          case .unknown:
            print("central.state is .unknown")
          case .resetting:
            print("central.state is .resetting")
          case .unsupported:
            print("central.state is .unsupported")
          case .unauthorized:
            print("central.state is .unauthorized")
          case .poweredOff:
            print("central.state is .poweredOff")
          case .poweredOn:
            print("central.state is .poweredOn")
            statusLabel.text = "Searching..."
            central.scanForPeripherals(withServices: [serviceUUID])
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let pName = peripheral.name, pName.contains((owner?.name)!) {
            print(advertisementData)
            
        }
    }
    
    
}

