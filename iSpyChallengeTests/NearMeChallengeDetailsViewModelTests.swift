//
//  NearMeChallengeDetailsViewModelTests.swift
//  iSpyChallengeTests
//
//  Created by Brandon Niedert on 8/23/22.
//

import XCTest
@testable import iSpyChallenge

class NearMeChallengeDetailsViewModelTests: XCTestCase {
    
    var viewModel: NearMeChallengeDetailsViewModel!
    let dataController = DataController(apiService: APIService())
    
    override func setUp() {
        viewModel = NearMeChallengeDetailsViewModel(dataController: dataController, challengeId: "")
    }
    
    func testImageIsNil() {
        XCTAssertNil(viewModel.image)
    }
}
