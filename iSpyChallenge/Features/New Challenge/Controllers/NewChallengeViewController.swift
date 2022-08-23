//
//  NewChallengeViewController.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import UIKit

class NewChallengeViewController: UIViewController {
    @IBOutlet private weak var takePhotoButton: UIButton!
    @IBOutlet private weak var choosePhotoButton: UIButton!
    
    private var viewModel: NewChallengeViewModel?
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewModel = viewModel {
            takePhotoButton.setTitle(viewModel.takeButtonTitle, for: .normal)
            choosePhotoButton.setTitle(viewModel.chooseButtonTitle, for: .normal)
            viewModel.selectedImage = nil
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func takePhotoPressed(_ sender: Any) {
        openImagePicker(for: .camera)
    }
    
    @IBAction func choosePhotoPressed(_ sender: Any) {
        openImagePicker(for: .savedPhotosAlbum)
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
    
    // MARK: - View Management
    
    private func openImagePicker(for type: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(type){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = type
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate

extension NewChallengeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true) {
            guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            self.viewModel?.selectedImage = image
            self.performSegue(withIdentifier: Strings.newChallengeSegue, sender: self)
        }
    }
}
