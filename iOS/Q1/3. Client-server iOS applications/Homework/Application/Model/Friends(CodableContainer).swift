// This file was generated from JSON Schema using https://app.quicktype.io, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let friendsContainer = try? newJSONDecoder().decode(FriendsContainer.self, from: jsonData)

import Foundation

// MARK: - FriendsContainer
struct FriendsContainer: Codable {
    let response: FriendsResponse
}

// MARK: - FriendsResponse
struct FriendsResponse: Codable {
    let count: Int
    let items: [Friends]
}

// MARK: - Friends
struct Friends: Codable {
    let canAccessClosed: Bool
    let id: Int
    let lastName: String
    let photo50: String
    let trackCode: String
    let isClosed: Bool
    let firstName: String
    let lists: [Int]?

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case id
        case lastName = "last_name"
        case photo50 = "photo_50"
        case trackCode = "track_code"
        case isClosed = "is_closed"
        case firstName = "first_name"
        case lists
    }
}
