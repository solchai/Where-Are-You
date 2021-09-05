//
//  CentralViewController.swift
//  CentralViewController
//
//  Created by Solomon Chai on 2021-09-04.
//

import UIKit

private let reuseIdentifier = "CentralViewCell"

class CentralViewController: UICollectionViewController {
    
    static var friends = [Friend]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes; not needed if already done on storyboard
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 130.0, height: 210.0)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if CentralViewController.friends.count > 0 {
            return CentralViewController.friends.count
        } else {
            return 1
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CentralViewCell
        
        if CentralViewController.friends.count > 0 {
            cell.nameLabel.text = CentralViewController.friends[indexPath.row].name ?? "Error"
            
            let image = UIImage(named: "iAmHere")
            cell.ownerImageView.image = image
        } else {
            cell.nameLabel.text = "Add a friend"
            
            let image = UIImage(systemName: "plus")
            cell.ownerImageView.image = image
        }
        
        cell.nameLabel.layer.zPosition = 1
        cell.nameLabel.layer.cornerRadius = 100
        cell.nameLabel.layer.masksToBounds = true
        cell.nameLabel.layer.cornerRadius = 5
//        cell.ownerImageView.layer.borderWidth = 10
//        cell.ownerImageView.layer.borderColor = CGColor(red: 119, green: 198, blue: 110, alpha: 1)
    
        return cell
    }
    
    @IBAction func addFriend(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showAddPersonForm", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//        if segue.identifier == "showAddPersonForm" {
//            let destinationVC = segue.destination as! AddFriendFormViewController
//        }
//
//    }


    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if CentralViewController.friends.count > 0 {
            
        } else {
            performSegue(withIdentifier: "showAddPersonForm", sender: self)
        }
    }
}

