//
//  NewChallengeViewController.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import UIKit

class NewChallengeViewController: UIViewController {
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var choosePhotoButton: UIButton!
    
    // DI This
    private var imagePicker = UIImagePickerController()
    private var viewModel: NewChallengeViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewModel = viewModel {
            takePhotoButton.setTitle(viewModel.takeButtonTitle, for: .normal)
            choosePhotoButton.setTitle(viewModel.chooseButtonTitle, for: .normal)
            viewModel.selectedImage = nil
        }
    }
    
    @IBAction func takePhotoPressed(_ sender: Any) {
    }
    
    @IBAction func choosePhotoPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        injectProperties(viewController: segue.destination)
    }
    
    // MARK: - Injection
    
    private func injectProperties(viewController: UIViewController) {
        if let vc = viewController as? CreateNewChallengeViewController {
            vc.inject(viewModel: viewModel?.viewModelForCreation())
        }
    }
    
    func inject(viewModel: NewChallengeViewModel) {
        self.viewModel = viewModel
    }
}

extension NewChallengeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) {
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            self.viewModel?.selectedImage = image
            self.performSegue(withIdentifier: "ShowCreateNewChallenge", sender: self)
        }
    }
}
