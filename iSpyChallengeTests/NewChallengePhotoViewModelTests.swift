//
//  File.swift
//  iSpyChallengeTests
//
//  Created by Brandon Niedert on 8/23/22.
//

import XCTest
@testable import iSpyChallenge

class NewChallengePhotoViewModelTests: XCTestCase {
    var viewModel: NewChallengePhotoViewModel!
    var dataController = DataController(apiService: APIService())
    
    override func setUp() {
        viewModel = NewChallengePhotoViewModel(dataController: dataController)
    }
    
    func testChooseButtonTitle() {
        XCTAssertEqual("Choose Photo", viewModel.chooseButtonTitle)
    }
    
    func testTakeButtonTitle() {
        XCTAssertEqual("Take Photo", viewModel.takeButtonTitle)
    }
    
    func testViewModelForCreation() {
        let image = UIImage(systemName: "photo")
        viewModel.selectedImage = image
        XCTAssertEqual(image, viewModel.viewModelForCreation()?.image)
    }
}
