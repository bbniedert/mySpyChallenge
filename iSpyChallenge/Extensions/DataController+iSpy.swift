//
//  DataController+iSpy.swift
//  iSpyChallenge
//
//

import UIKit

// A set of convenience functions for navigating the data stored in DataController
extension DataController {
    func user(identifiedBy userID: String) -> User? {
        allUsers.first { $0.id == userID }
    }
    
    var allChallenges: [Challenge] {
        let mockedChallenges = allUsers.flatMap { $0.challenges }
        let persistedChallenges = persistedChallenges()
        return mockedChallenges + persistedChallenges
    }
    
    func challenge(for id: String) -> Challenge? {
        allChallenges.first { $0.id == id }
    }
    
    func challenge(for match: Match) -> Challenge? {
        allChallenges.first { $0.matches.contains(match) }
    }
    
    var allMatches: [Match] {
        allChallenges.flatMap { $0.matches }
    }
        
    func matches(createdBy userId: String) -> [Match] {
        allChallenges
            .flatMap { $0.matches }
            .filter { $0.creatorID == userId }
    }
    
    func ratings(createdBy userId: String) -> [Rating] {
        allChallenges
            .flatMap { $0.ratings }
            .filter { $0.creatorID == userId }
    }
    
    func persistedImage(named name: String) -> UIImage? {
        guard let data = UserDefaults.standard.data(forKey: name) else { return nil }
        do {
            let decoded = try PropertyListDecoder().decode(Data.self, from: data)
            let image = UIImage(data: decoded)
            return image
        } catch {
            return nil
        }
    }
    
    private func persistedChallenges() -> [Challenge] {
        guard let data = UserDefaults.standard.data(forKey: "PersistedChallenges") else { return [] }
        let challenges = try? PropertyListDecoder().decode([Challenge].self, from: data)
        return challenges ?? []
    }
    
    /// Returns the original array of ratings, but with each rating paired with the user that created it.
    func ratingsAndAssociatedUsers(for ratings: [Rating]) -> [RatingAndAssociatedUser] {
        ratings.compactMap { rating in
            guard let user = self.user(identifiedBy: rating.creatorID) else {
                return nil
            }
            
            return RatingAndAssociatedUser(rating: rating, user: user)
        }
    }
}
