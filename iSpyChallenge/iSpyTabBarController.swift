//
//  iSpyTabBarController.swift
//  iSpyChallenge
//

import UIKit
import CoreData

class iSpyTabBarController: UITabBarController {
    private let dataController = DataController(apiService: APIService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let challengesViewModel = NearMeChallengesViewModel(dataController: dataController)
        nearMeChallengesViewController?.inject(viewModel: challengesViewModel)
        
        let newChallengeViewModel = NewChallengeViewModel(dataController: dataController)
        newChallengeViewController?.inject(viewModel: newChallengeViewModel)
        
        
        dataBrowserViewController?.dataController = dataController
        
        dataController.loadAllData()
        LocationManager.shared.start()
    }
}

private extension iSpyTabBarController {
    var dataBrowserViewController: DataBrowserTableViewController? {
        viewControllers?
            .compactMap { ($0 as? UINavigationController)?.viewControllers.first as? DataBrowserTableViewController }
            .first
    }
    
    var nearMeChallengesViewController: NearMeChallengesViewController? {
        viewControllers?
            .compactMap { ($0 as? UINavigationController)?.viewControllers.first as? NearMeChallengesViewController }
            .first
    }
    
    var newChallengeViewController: NewChallengeViewController? {
        viewControllers?
            .compactMap { ($0 as? UINavigationController)?.viewControllers.first as? NewChallengeViewController }
            .first
    }
}
