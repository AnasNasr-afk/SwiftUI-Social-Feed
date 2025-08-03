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
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Custom Animation Modifier for Like Button
struct LikeButtonAnimationModifier: ViewModifier {
    let isLiked: Bool
    @State private var bounceScale: CGFloat = 1.0
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isLiked ? 1.1 : 1.0)
            .scaleEffect(bounceScale)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isLiked)
            .onChange(of: isLiked) { _, newValue in
                if newValue {
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.4)) {
                        bounceScale = 1.3
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                            bounceScale = 1.0
                        }
                    }
                }
            }
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
    
    func enhancedLikeButtonAnimation(isLiked: Bool) -> some View {
        modifier(LikeButtonAnimationModifier(isLiked: isLiked))
    }
}
