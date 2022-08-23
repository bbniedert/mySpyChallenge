//
//  NearMeChallengeDetailsViewController.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import UIKit

class NearMeChallengeDetailsViewController: UIViewController {

    @IBOutlet private weak var challengeImageView: UIImageView!
    
    private var viewModel: NearMeChallengeDetailsViewModel?
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let image = viewModel?.image {
            challengeImageView.image = image
        }
    }
    
    // MARK: - Injection
    
    func inject(viewModel: NearMeChallengeDetailsViewModel?) {
        self.viewModel = viewModel
    }
}
