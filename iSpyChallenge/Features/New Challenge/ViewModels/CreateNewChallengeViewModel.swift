//
//  CreateNewChallengeViewModel.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import Foundation
import UIKit

class CreateNewChallengeViewModel {
    let dataController: DataController
    let image: UIImage?
    
    init(dataController: DataController, image: UIImage?) {
        self.dataController = dataController
        self.image = image
    }
}
