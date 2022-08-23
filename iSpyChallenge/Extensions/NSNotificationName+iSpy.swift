//
//  File.swift
//  iSpyChallenge
//
//  Created by Brandon Niedert on 8/22/22.
//

import Foundation

extension NSNotification.Name {
    /// Indicates that a `DataController` instance updated its data.
    /// This notification is only fired on the main thread.
    static let dataControllerDidUpdate = NSNotification.Name(rawValue: "dataControllerDidUpdate")
    static let viewModelDidUpdate = NSNotification.Name(rawValue: "viewModelDidUpdate")
}
