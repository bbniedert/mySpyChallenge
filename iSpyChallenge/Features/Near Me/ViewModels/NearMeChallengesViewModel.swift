//
//  ChallengesListViewModel.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import Foundation
import CoreLocation

class NearMeChallengesViewModel {
    private let dataController: DataController
    private(set) var challenges: [NearMeChallengeModel]?
    var selectedChallenge: NearMeChallengeModel?
    
    init(dataController: DataController) {
        self.dataController = dataController
        
        registerForDataControllerNotifications()
    }
    
    // MARK: - Notifications
    
    private func registerForDataControllerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRetrieveData), name: .dataControllerDidUpdate, object: dataController)
    }
    
    @objc private func didRetrieveData() {
        let currentLocation = LocationManager.shared.location ?? LocationManager.shared.mockedLocation
        
        let challengeDisplayModels = dataController.allChallenges.map({ challenge -> NearMeChallengeModel in
            let username = dataController.user(identifiedBy: challenge.creatorID)?.username
            let wins =  challenge.matches.filter( { $0.verified } ).count
            let averageRating = challenge.ratings.count == 0 ? 0 : Double(challenge.ratings.map( { $0.stars } ).reduce(0, +)) / Double(challenge.ratings.count)
            let challengeLocation = CLLocation(latitude: challenge.latitude, longitude: challenge.longitude)
            
            return NearMeChallengeModel(id: challenge.id,
                                        wins: wins,
                                        averageRating: averageRating,
                                        distance: currentLocation.distance(from: challengeLocation),
                                        hint: challenge.hint,
                                        userName: username)
        })
        
        self.challenges = challengeDisplayModels.sorted(by: { $0.distance < $1.distance })
        
        NotificationCenter.default.post(name: .viewModelDidUpdate, object: self)
    }
    
    // MARK: - Injection Helper
    
    func detailsViewModel() -> NearMeChallengeDetailsViewModel? {
        guard let selectedId = selectedChallenge?.id else { return nil }
        return NearMeChallengeDetailsViewModel(dataController: dataController, challengeId: selectedId)
    }
}
