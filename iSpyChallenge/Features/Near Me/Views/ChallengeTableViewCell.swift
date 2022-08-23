//
//  ChallengeTableViewCell.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import UIKit

class ChallengeTableViewCell: UITableViewCell, NibBasedView {

    @IBOutlet private weak var winsLabel: UILabel!
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var distanceLabel: UILabel!
    @IBOutlet private weak var hintLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    
    func configure(for challenge: NearMeChallengeModel) {
        winsLabel.text = String(format: "%d wins", challenge.wins)
        ratingLabel.text = String(format: "%.2f stars", challenge.averageRating)
        distanceLabel.text = String(format: "%.2fm", challenge.distance)
        hintLabel.text = challenge.hint
        if let username = challenge.userName {
            authorLabel.text = "By: \(username)"
        } else {
            authorLabel.text = ""
        }
    }
    
}
