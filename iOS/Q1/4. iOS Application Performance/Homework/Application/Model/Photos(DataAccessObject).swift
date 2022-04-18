//
//  Photos(DataAccessObject).swift
//  Homework
//
//  Created by Александр on 07.01.2022.
//

import Foundation
import RealmSwift

// MARK: - PhotosDAO
class PhotosDAO: Object, Decodable {
    @objc dynamic var id: Int = Int()
    @objc dynamic var date: Int = Int()
    @objc dynamic var ownerID: Int = Int()
    @objc dynamic var postID: Int = Int()
    @objc dynamic var text: String = String()
    @objc dynamic var hasTags: Bool = Bool()
    @objc dynamic var albumID: Int = Int()
    @objc dynamic var canComment: Int = Int()
    @objc dynamic var likes: LikesDAO? = LikesDAO()
    @objc dynamic var comments: CommentsDAO? = CommentsDAO()
    @objc dynamic var reposts: RepostsDAO? = RepostsDAO()
    @objc dynamic var tags: TagsDAO? = TagsDAO()
    var sizes = List<SizeDAO>()

    enum CodingKeys: String, CodingKey {
        case id, comments, likes, reposts, tags, date
        case ownerID = "owner_id"
        case postID = "post_id"
        case text, sizes
        case hasTags = "has_tags"
        case albumID = "album_id"
        case canComment = "can_comment"
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        date = try values.decode(Int.self, forKey: .date)
        ownerID = try values.decode(Int.self, forKey: .ownerID)
        postID = try values.decodeIfPresent(Int.self, forKey: .postID) ?? 0
        text = try values.decode(String.self, forKey: .text)
        hasTags = try values.decode(Bool.self, forKey: .hasTags)
        albumID = try values.decode(Int.self, forKey: .albumID)
        canComment = try values.decode(Int.self, forKey: .canComment)
        likes = try values.decode(LikesDAO.self, forKey: .likes)
        comments = try values.decode(CommentsDAO.self, forKey: .comments)
        reposts = try values.decode(RepostsDAO.self, forKey: .reposts)
        tags = try values.decode(TagsDAO.self, forKey: .tags)
        sizes = try values.decode(List<SizeDAO>.self, forKey: .sizes)
    }
}

// MARK: - Likes
class LikesDAO: Object, Decodable {
    @objc dynamic var userLikes: Int = Int()
    @objc dynamic var count: Int = Int()

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Comments
class CommentsDAO: Object, Decodable {
    @objc dynamic var count: Int = 0
}
// MARK: - Reposts
class RepostsDAO: Object, Decodable {
    @objc dynamic var count: Int = 0
}

// MARK: - Tags
class TagsDAO: Object, Decodable {
    @objc dynamic var count: Int = 0
}

// MARK: - Size
class SizeDAO: Object, Decodable {
    @objc dynamic var width: Int = Int()
    @objc dynamic var height: Int = Int()
    @objc dynamic var url: String = String()
    @objc dynamic var type: String = String()
    
    enum CodingKeys: String, CodingKey {
        case width, height, url, type
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        width = try values.decode(Int.self, forKey: .width)
        height = try values.decode(Int.self, forKey: .height)
        url = try values.decode(String.self, forKey: .url)
        type = try values.decode(String.self, forKey: .type)
    }
}
