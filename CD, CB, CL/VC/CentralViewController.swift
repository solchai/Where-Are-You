//
//  CentralViewController.swift
//  CentralViewController
//
//  Created by Solomon Chai on 2021-09-04.
//

import UIKit
import CoreData

private let reuseIdentifier = "CentralViewCell"
private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class CentralViewController: UICollectionViewController {
    
    var friends = [Friend]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes; not needed if already done on storyboard
//        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: self.view.bounds.size.width/3.0 - 16, height: 210)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        loadItems()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if friends.count > 0 {
            return friends.count
        } else {
            return 1
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CentralViewCell
        
        if friends.count > 0 {
            cell.nameLabel.text = friends[indexPath.row].name
            if let imageData = friends[indexPath.row].ownerImage, let image = UIImage(data: imageData) {
                cell.ownerImageView.image = image
            } else {
                cell.ownerImageView.image = UIImage(systemName: "person.fill.questionmark")!
            }
        } else {
            cell.nameLabel.text = "Add a friend"
            cell.ownerImageView.image = UIImage(systemName: "plus")
        }
        
        cell.nameLabel.layer.zPosition = 1
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "showAddPersonForm" {
            let destinationVC = segue.destination as! AddFriendFormViewController
            destinationVC.delegate = self
        } else if segue.identifier == "showDevices" {
            let destinationVC = segue.destination as! DeviceListViewController
            
            let index = collectionView.indexPathsForSelectedItems?.first
            destinationVC.owner = friends[(index?.row)!]
        }
        

    }


    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if friends.count <= 0 {
            performSegue(withIdentifier: "showAddPersonForm", sender: self)
        }
    }
    
    // MARK: CoreData methods
    
    private func saveFriends() {
        do {
            try context.save()
        } catch let error {
            print("Error saving context \(error.localizedDescription)")
        }
        
        collectionView.reloadData()
    }
    
    private func loadItems(with request: NSFetchRequest<Friend> = Friend.fetchRequest()) {
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            friends = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        
        collectionView.reloadData()
    }
}

extension CentralViewController: AddFriendDelegate {
    func successfullyAddedFriend(named name: String, with image: UIImage?) {
        let newFriend = Friend(context: context)
        newFriend.name = name
        if let image = image {
            newFriend.ownerImage = convertImageToData(with: image)
        } else {
            newFriend.ownerImage = UIImage(systemName: "person.fill.questionmark")!.pngData()
        }
        
        friends.append(newFriend)
        saveFriends()
    }
    
    private func convertImageToData(with image: UIImage) -> Data? {
        return image.pngData()
    }
}
