//
//  ChallengesListViewController.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import UIKit

// I chose a UIViewController over a UITableViewController because I like the organization that comes with implementing the data source and delegate in extensions
class NearMeChallengesViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var loadingSpinner: UIActivityIndicatorView!
    
    private var viewModel: NearMeChallengesListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTableView()
        registerViewModelListener()
    }
    
    private func registerViewModelListener() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: .viewModelDidUpdate, object: viewModel)
    }
    
    @objc private func updateUI() {
        if viewModel?.challenges != nil {
            loadingSpinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
        } else {
            // ERROR
        }
    }
    
    private func setUpTableView() {
        tableView.register(ChallengeTableViewCell.nib(), forCellReuseIdentifier: ChallengeTableViewCell.nibName)
    }
    
    func inject(viewModel: NearMeChallengesListViewModel) {
        self.viewModel = viewModel
    }
}

extension NearMeChallengesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.challenges?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let challenge = viewModel?.challenges?[indexPath.row],
              let cell = tableView.dequeueReusableCell(withIdentifier: ChallengeTableViewCell.nibName) as? ChallengeTableViewCell else { return UITableViewCell() }
        cell.configure(for: challenge)
        return cell
    }
}

extension NearMeChallengesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("CELL")
    }
}
