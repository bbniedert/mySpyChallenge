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
        challengesListViewController?.inject(viewModel: challengesViewModel)
        
        dataBrowserViewController?.dataController = dataController
        
        dataController.loadAllData()
    }
}

private extension iSpyTabBarController {
    var dataBrowserViewController: DataBrowserTableViewController? {
        viewControllers?
            .compactMap { ($0 as? UINavigationController)?.viewControllers.first as? DataBrowserTableViewController }
            .first
    }
    
    var challengesListViewController: NearMeChallengesViewController? {
        viewControllers?
            .compactMap { ($0 as? UINavigationController)?.viewControllers.first as? NearMeChallengesViewController }
            .first
    }
}
