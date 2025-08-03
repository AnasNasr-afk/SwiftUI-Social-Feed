//
//  ViewModifiers.swift
//  T4
//
//  Created by Anas Nasr on 03/08/2025.
//

import SwiftUI

// MARK: - Post Card Style Modifier
struct PostCardStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}

// MARK: - Like Button Animation Modifier
struct LikeButtonAnimation: ViewModifier {
    let isLiked: Bool
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isLiked ? 1.1 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isLiked)
    }
}

// MARK: - Custom Button Style for Social Actions
struct SocialButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - View Extensions
extension View {
    func postCardStyle() -> some View {
        modifier(PostCardStyle())
    }
    
    func likeButtonAnimation(isLiked: Bool) -> some View {
        modifier(LikeButtonAnimation(isLiked: isLiked))
    }
    
    func socialButtonStyle() -> some View {
        buttonStyle(SocialButtonStyle())
    }
}
