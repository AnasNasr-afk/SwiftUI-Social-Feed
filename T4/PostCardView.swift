//
//  PostCardView.swift
//  T4
//
//  Created by Anas Nasr on 03/08/2025.
//
import SwiftUI

struct PostCardView: View {
    let post: Post
    
    @State private var isLiked = false
    @State private var likesNumber: Int
    @State private var commentsNumber: Int
    
    init(post: Post) {
        self.post = post
        self._likesNumber = State(initialValue: post.initialLikes)
        self._commentsNumber = State(initialValue: post.initialComments)
    }
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: - User Header
                HStack {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading) {
                        Text(post.userName)
                            .font(.headline)
                        Text(post.timeAgo)
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }
                    
                    Spacer()
                }
                
                // MARK: - Post Content
                Text(post.postText)
                    .font(.body)
                
                // MARK: - Post Image
                Image(post.postImage)
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(20)
                
                // MARK: - Action Buttons
                HStack(alignment: .top, spacing: 5) {
                    
                    // Like Button
                    Button {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isLiked.toggle()
                            
                            if isLiked {
                                likesNumber += 1
                            } else {
                                likesNumber -= 1
                            }
                        }
                    } label: {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(isLiked ? .red : .primary)
                            .likeButtonAnimation(isLiked: isLiked)
                    }
                    .socialButtonStyle()
                    
                    Text("\(likesNumber)")
                        .font(.subheadline)
                    
                    Spacer().frame(width: 20)
                    
                    // Comment Button
                    Image(systemName: "message")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(.primary)
                    
                    Text("\(commentsNumber)")
                        .font(.subheadline)
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    PostCardView(post: MockData.mockPosts[0])
        .padding()
}
