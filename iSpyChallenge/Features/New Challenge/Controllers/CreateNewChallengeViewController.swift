//
//  CreateNewChallengeViewController.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import UIKit

class CreateNewChallengeViewController: UIViewController {
    
    @IBOutlet weak var newImageView: UIImageView!
    
    private var viewModel: CreateNewChallengeViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let viewModel = viewModel, let image = viewModel.image {
            newImageView.image = image
        }
    }
    
    func inject(viewModel: CreateNewChallengeViewModel?) {
        self.viewModel = viewModel
    }
}
