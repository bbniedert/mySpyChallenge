//
//  CreateNewChallengeViewController.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import UIKit

class CreateNewChallengeViewController: UIViewController {
    
    @IBOutlet private weak var newImageView: UIImageView!
    @IBOutlet private weak var hintLabel: UILabel!
    @IBOutlet private weak var hintTextField: UITextField!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var loadingSpinner: UIActivityIndicatorView!
    
    private var viewModel: CreateNewChallengeViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadingSpinner.isHidden = true
        
        if let viewModel = viewModel, let image = viewModel.image {
            newImageView.image = image
            hintLabel.text = viewModel.hintTitle
            hintTextField.placeholder = viewModel.hintPlaceholder
            submitButton.setTitle(viewModel.submitTitle, for: .normal)
        }
    }
    
    @IBAction func didTapSubmit(_ sender: Any) {
        loadingSpinner.startAnimating()
        loadingSpinner.isHidden = false
        contentView.isHidden = true
        viewModel?.submitChallenge() { success in
            DispatchQueue.main.async {
                if success {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.contentView.isHidden = false
                    self.loadingSpinner.isHidden = true
                }
            }
        }
    }
    
    
    @IBAction func didUpdateHint(_ sender: UITextField) {
        viewModel?.hint = sender.text
        submitButton.isEnabled = (viewModel?.hint?.count ?? 0) > 0
    }
    
    func inject(viewModel: CreateNewChallengeViewModel?) {
        self.viewModel = viewModel
    }
}
