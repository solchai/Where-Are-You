//
//  AddFriendFormViewController.swift
//  AddFriendFormViewController
//
//  Created by Solomon Chai on 2021-09-05.
//

import UIKit

protocol AddFriendDelegate {
    func successfullyAddedFriend(named name: String, with image: UIImage?)
}

class AddFriendFormViewController: UIViewController {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var imagePickerController: UIImagePickerController?
    var delegate: AddFriendDelegate?
    var ownerImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageButton.layer.masksToBounds = true
        imageButton.layer.cornerRadius = 15
        
        addButton.backgroundColor = .green
        addButton.tintColor = .white
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 25

    }
    
    @IBAction func cancelClicked(_ sender: UIButton) {
        print("cancel clicked")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func pickFriendPhoto(_ sender: UIButton) {
        print("pick photo")
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        imagePickerController?.allowsEditing = true
        imagePickerController?.sourceType = .photoLibrary
        if let imagePickerController = imagePickerController {
            present(imagePickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func addFriendClicked(_ sender: UIButton) {
        guard let name = nameField.text, name.count > 0 else {
            nameField.attributedPlaceholder = NSAttributedString(string: "Enter Name!", attributes: [.foregroundColor: UIColor.red])
            return
        }
        nameField.resignFirstResponder()
        
        delegate?.successfullyAddedFriend(named: name, with: ownerImage)
        dismiss(animated: true, completion: nil)
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

extension AddFriendFormViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.editedImage] as? UIImage else {
            return imagePickerControllerDidCancel(picker)
        }
        
        ownerImage = image
        
        setButtonImage(image)
        imageButton.titleLabel?.text = ""
        imageButton.backgroundColor = .none
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func setButtonImage(_ image: UIImage) {
        imageButton.setImage(image, for: .normal)
        imageButton.setImage(image, for: .selected)
        imageButton.setImage(image, for: .highlighted)
        imageButton.setImage(image, for: .focused)
    }
}
