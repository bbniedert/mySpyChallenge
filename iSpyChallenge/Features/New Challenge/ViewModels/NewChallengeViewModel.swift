//
//  NewChallengeViewModel.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import UIKit

class NewChallengeViewModel {
    private let dataController: DataController
    var selectedImage: UIImage?
    
    let chooseButtonTitle = Strings.chooseButtonTitle
    let takeButtonTitle = Strings.takeButtonTitle
    
    init(dataController: DataController) {
        self.dataController = dataController
    }
    
    func viewModelForCreation() -> CreateNewChallengeViewModel? {
        return CreateNewChallengeViewModel(dataController: dataController, image: selectedImage)
    }
}
