//
//  NearMeChallengeDetailsViewModel.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import Foundation
import UIKit

class NearMeChallengeDetailsViewModel {
    
    private let dataController: DataController
    private let challenge: Challenge?
    
    init(dataController: DataController, challengeId: String) {
        self.dataController = dataController
        self.challenge = dataController.challenge(for: challengeId)
    }
    
    var image: UIImage? {
        guard let imageName = challenge?.photoImageName else { return nil }
        if let image = UIImage(named: imageName) {
            return image
        } else if let storedImage = dataController.persistedImage(named: challenge?.photoImageName ?? "") {
            return storedImage
        } else {
            return nil
        }
    }
}
