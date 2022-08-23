//
//  iSpyChallengeTests.swift
//  iSpyChallengeTests
//
//  Created by Brandon Niedert on 8/23/22.
//

import XCTest
@testable import iSpyChallenge

class CreateNewChallenegeViewModelTests: XCTestCase {

    var viewModel: CreateNewChallengeViewModel?
    let dataController = MockDataController(apiService: APIService())
    
    func testConstants() {
        viewModel = CreateNewChallengeViewModel(dataController: dataController, image: UIImage(systemName: "photo"))
        XCTAssertEqual("Hint", viewModel?.hintTitle)
        XCTAssertEqual("Enter Hint", viewModel?.hintPlaceholder)
        XCTAssertEqual("Submit", viewModel?.submitTitle)
    }
    
    func testSubmitCorrectlyCalled() {
        viewModel = CreateNewChallengeViewModel(dataController: dataController, image: UIImage(systemName: "photo"))
        viewModel?.hint = "Test"
        viewModel?.submitChallenge(completion: { _ in })
        XCTAssert(dataController.didCallCreate)
    }
    
    func testSubmitNotCalledWithNoHint() {
        viewModel = CreateNewChallengeViewModel(dataController: dataController, image: UIImage(systemName: "photo"))
        viewModel?.submitChallenge(completion: { _ in })
        XCTAssertFalse(dataController.didCallCreate)
    }
    
    func testSubmitNotCalledWithNoImage() {
        viewModel = CreateNewChallengeViewModel(dataController: dataController, image: nil)
        viewModel?.hint = "Test"
        viewModel?.submitChallenge(completion: { _ in })
        XCTAssertFalse(dataController.didCallCreate)
    }
}

class MockDataController: DataController {
    var didCallCreate = false
    
    override func createChallengeForCurrentUser(hint: String, latitude: Double, longitude: Double, photoImageName: String, image: UIImage? = nil, completion: @escaping (Bool) -> Void) {
        super.createChallengeForCurrentUser(hint: hint, latitude: latitude, longitude: longitude, photoImageName: photoImageName, image: image, completion: completion)
        
        didCallCreate = true
    }
}
