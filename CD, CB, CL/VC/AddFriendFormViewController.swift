//
//  AddFriendFormViewController.swift
//  AddFriendFormViewController
//
//  Created by Solomon Chai on 2021-09-05.
//

import UIKit

class AddFriendFormViewController: UIViewController {
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var imagePickerController: UIImagePickerController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageButton.layer.masksToBounds = true
        imageButton.layer.cornerRadius = 15
        
        addButton.backgroundColor = .green
        addButton.tintColor = .white
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 25
    }
    
    @IBAction func dismissForm(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickFriendPhoto(_ sender: UIButton) {
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        imagePickerController?.allowsEditing = true
        imagePickerController?.mediaTypes = ["public.image", "public.movie"]
        imagePickerController?.sourceType = .camera
        self.navigationController?.present(imagePickerController!, animated: true, completion: nil)
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
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        guard let image = info[.editedImage] as? UIImage else {
            return imagePickerControllerDidCancel(picker)
        }
        
        imageButton.setImage(image, for: .normal)
        imageButton.titleLabel?.text = ""
    }
}
