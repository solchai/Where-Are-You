//
//  PeripheralViewController.swift
//  PeripheralViewController
//
//  Created by Solomon Chai on 2021-09-06.
//

import UIKit
import CoreBluetooth
import CoreLocation

let longCharUUID = CBUUID(string: "longChar")
let latCharUUID = CBUUID(string: "latChar")
let foundYaUUID = CBUUID(string: "foundChar")

class PeripheralViewController: UIViewController {

    @IBOutlet weak var peripheralButton: UIButton!
    var peripheralManager: CBPeripheralManager?
    var service: CBMutableService?
    
    let locationManager = CLLocationManager()
    var location: CLLocation?
    var longChar: CBMutableCharacteristic?
    var latChar: CBMutableCharacteristic?
    var foundChar: CBMutableCharacteristic?
    
    var peripheralName: String? {
        get {
            if let name = UserDefaults.standard.object(forKey: "peripheralName") as? String {
                return name
            }
            
            return nil
        }
        
        set {
            updateButtonStatus()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
        updateButtonStatus()
    }
    
    @IBAction func peripheralButtonClicked(_ sender: UIButton) {
        if peripheralName != nil {
            // get user's permission for location usage
            let authorizationStatus = CLLocationManager.authorizationStatus
            if authorizationStatus == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
                return
            } else if authorizationStatus == .denied {
                return
            } else if CLLocationManager.locationServicesEnabled() {
                
            }
        } else {
            retrieveName()
        }
    }
    
    private func updateButtonStatus() {
        if peripheralName != nil {
            peripheralButton.backgroundColor = .green
            peripheralButton.setTitle("Be seen!", for: .normal)
            peripheralButton.tintColor = .white
        } else {
            peripheralButton.backgroundColor = .yellow
            peripheralButton.setTitle("Register device", for: .normal)
            peripheralButton.tintColor = .black
        }
    }
    
    private func retrieveName() {
        var nameField: UITextField?
        
        let askName = UIAlertController(title: "What's your name?", message: "We need your name to let your friends know that it's you.", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            askName.dismiss(animated: true, completion: nil)
        }
        
        let done = UIAlertAction(title: "Done", style: .default) { action in
            if let name = nameField?.text, name.count > 0 {
                UserDefaults.standard.set(name, forKey: "peripheralName")
                self.peripheralName = name
                askName.dismiss(animated: true, completion: nil)
            } else {
                nameField?.placeholder = "Type name"
                action.isEnabled = false
            }
        }
        
        askName.addTextField { alertTextField in
            alertTextField.placeholder = "Name"
            nameField = alertTextField
        }
        
        askName.addAction(cancel)
        askName.addAction(done)
        
        present(askName, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PeripheralViewController: CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            service = CBMutableService(type: serviceUUID, primary: true)
            let properties: CBCharacteristicProperties = [.read, .notify, .write]
            let permissions: CBAttributePermissions = [.readable, .writeable]
            longChar = CBMutableCharacteristic(type: longCharUUID, properties: properties, value: nil, permissions: [.readable])
            latChar = CBMutableCharacteristic(type: latCharUUID, properties: properties, value: nil, permissions: [.readable])
            foundChar = CBMutableCharacteristic(type: foundYaUUID, properties: properties, value: nil, permissions: [.readable, .writeable])
            service?.characteristics = [longChar!, latChar!]
            peripheralManager?.add(service!)
            peripheralManager?.delegate = self
            
            var adName = UserDefaults.standard.object(forKey: "adName") as? String
            
            if adName == nil {
                adName = createAdName()
            }
            
            let adData = [CBAdvertisementDataLocalNameKey: adName!, CBAdvertisementDataServiceUUIDsKey: [serviceUUID]] as [String:Any]
            peripheralManager?.startAdvertising(adData)
        }
    }
    
    private func createAdName() -> String {
        let name = "\(peripheralName!):\(UIDevice.current.name):\(UUID().uuidString)"
        UserDefaults.standard.set(name, forKey: "adName")
        return name
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            let longValue = withUnsafeBytes(of: Double(self.location?.coordinate.longitude ?? 0.0)) { pointer in
                Data(pointer)
            }
            peripheral.updateValue(longValue, for: self.longChar!, onSubscribedCentrals: nil)
        }
    }
}

extension PeripheralViewController: CLLocationManagerDelegate {
    private func startSharingLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
        peripheralButton.backgroundColor = .green
        peripheralButton.setTitle("Be seen!", for: .normal)
    }
    
    private func stopSharingLocation() {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        peripheralButton.backgroundColor = .red
        peripheralButton.setTitle("Paused", for: .normal)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Retrieving location failed with: \(error.localizedDescription)")
        stopSharingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        self.location = location
    }
}
