//
//  DeviceListViewController.swift
//  DeviceListViewController
//
//  Created by Solomon Chai on 2021-09-05.
//

import UIKit
import CoreData

private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class DeviceListViewController: UITableViewController {
    
    var owner: Friend? {
        didSet {
            loadDevices()
        }
    }
    
    var devices = [Device]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        if let ownerName = owner?.name {
            navigationItem.title = "\(ownerName)'s Devices"
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if devices.count > 0 {
            return devices.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceLIstViewCell", for: indexPath) as! DeviceListViewCell

        // Configure the cell...
        
        if devices.count > 0 {
            
        } else {
            cell.deviceImage.image = UIImage(systemName: "plus")!
            cell.uuidLabel.text = "Register device"
        }

        return cell
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - CoreData
    
    private func loadDevices(with request: NSFetchRequest<Device> = Device.fetchRequest()) {
        
        request.predicate = NSPredicate(format: "owner.name MATCHES %@", owner!.name)
        
        do {
            devices = try context.fetch(request)
        } catch let error {
            print("Error fetching data from context \(error.localizedDescription)")
        }
        
        tableView.reloadData()
    }
}
