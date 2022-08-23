//
//  NibBasedView.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import Foundation
import UIKit

protocol NibBasedView {
    static var nibName: String { get }
    static func nib() -> UINib?
}

extension NibBasedView {
    static var nibName: String {
        String(describing: self)
    }
    
    static func nib() -> UINib? {
        UINib(nibName: nibName, bundle: nil)
    }
}
