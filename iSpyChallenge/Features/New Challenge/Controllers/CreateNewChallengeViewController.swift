//
//  CreateNewChallengeViewController.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import UIKit

class CreateNewChallengeViewController: UIViewController {
    
    @IBOutlet weak var newImageView: UIImageView!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var hintTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    private var viewModel: CreateNewChallengeViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewModel = viewModel, let image = viewModel.image {
            newImageView.image = image
            hintLabel.text = viewModel.hintTitle
            hintTextField.placeholder = viewModel.hintPlaceholder
            submitButton.setTitle(viewModel.submitTitle, for: .normal)
        }
    }
    
    @IBAction func didTapSubmit(_ sender: Any) {
        viewModel?.submitChallenge() { success in
            DispatchQueue.main.async {
                if success {
                    self.navigationController?.popViewController(animated: true)
                } else {
                    // Erroor
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
