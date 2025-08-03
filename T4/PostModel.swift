//
//  PostModel.swift
//  T4
//
//  Created by Anas Nasr on 03/08/2025.
//

import Foundation

// MARK: - Post Model
struct Post: Identifiable {
    let id = UUID()
    let userName: String
    let postText: String
    let postImage: String
    let initialLikes: Int
    let initialComments: Int
    let timeAgo: String
    
    init(userName: String, postText: String, postImage: String, initialLikes: Int, initialComments: Int, timeAgo: String = "Few hours ago") {
        self.userName = userName
        self.postText = postText
        self.postImage = postImage
        self.initialLikes = initialLikes
        self.initialComments = initialComments
        self.timeAgo = timeAgo
    }
}
