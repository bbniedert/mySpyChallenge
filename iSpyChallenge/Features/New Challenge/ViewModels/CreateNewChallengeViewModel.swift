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
    
    var hint: String?
    
    let hintTitle = "Hint"
    let hintPlaceholder = "Enter hint"
    let submitTitle = "Submit"
    
    init(dataController: DataController, image: UIImage?) {
        self.dataController = dataController
        self.image = image
    }
    
    func submitChallenge(completion: @escaping (Bool) -> Void) {
        guard let hint = hint, let image = image else { return }
        let currentLocation = LocationManager.shared.location ?? LocationManager.shared.mockedLocation
        dataController.createChallengeForCurrentUser(hint: hint,
                                                     latitude: currentLocation.coordinate.latitude,
                                                     longitude: currentLocation.coordinate.longitude,
                                                     photoImageName: UUID().uuidString,
                                                     image: image,
                                                     completion: completion)
    }
}
