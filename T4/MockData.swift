//
//  MockData.swift
//  T4
//
//  Created by Anas Nasr on 03/08/2025.
//

import Foundation

class MockData {
    static let shared = MockData()
    
    private init() {}
    
    // MARK: - Mock Posts Data
    static let mockPosts: [Post] = [
        Post(
            userName: "Anas Nasr",
            postText: "Hello, this is my first post! It's a great day to learn SwiftUI.",
            postImage: "coding1",
            initialLikes: 200,
            initialComments: 50,
            timeAgo: "Few hours ago"
        ),
        
        Post(
            userName: "Jane Doe",
            postText: "Our first Germany football kit 2025/2026, Find our website and be special!!",
            postImage: "firstBrand",
            initialLikes: 5021,
            initialComments: 283,
            timeAgo: "2 hours ago"
        ),
        
        Post(
            userName: "Malak",
            postText: "Enjoying the summer vibes 🌞🏝️",
            postImage: "beachImage",
            initialLikes: 186,
            initialComments: 23,
            timeAgo: "5 hours ago"
        )
    ]
}
