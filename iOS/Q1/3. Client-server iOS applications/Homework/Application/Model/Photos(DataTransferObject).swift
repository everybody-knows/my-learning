//
//  Photos(DataTransferObject).swift
//  Homework
//
//  Created by Александр on 06.01.2022.
//

import Foundation

// MARK: - PhotosDTO
struct PhotosDTO: Codable {
    let id: Int
    let comments: Comments
    let likes: Likes
    let reposts, tags: Comments
    let date, ownerID: Int
    let postID: Int?
    let text: String
    let sizes: [Size]
    let hasTags: Bool
    let albumID, canComment: Int
    
    enum CodingKeys: String, CodingKey {
        case id, comments, likes, reposts, tags, date
        case ownerID = "owner_id"
        case postID = "post_id"
        case text, sizes
        case hasTags = "has_tags"
        case albumID = "album_id"
        case canComment = "can_comment"
    }
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int
    
    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}
