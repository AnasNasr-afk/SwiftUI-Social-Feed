import SwiftUI

struct PostCardView: View {
    let post: Post
    
    @State private var isLiked = false
    @State private var likesNumber: Int
    @State private var commentsNumber: Int
    
    // Animation States
    @State private var isLikePressed = false
    @State private var isCommentPressed = false
    @State private var heartBurst = false
    @State private var showLikeParticles = false
    @State private var cardScale: CGFloat = 1.0
    @State private var imageScale: CGFloat = 1.0
    @State private var isCardPressed = false
    
    init(post: Post) {
        self.post = post
        self._likesNumber = State(initialValue: post.initialLikes)
        self._commentsNumber = State(initialValue: post.initialComments)
    }
    
    var body: some View {
        GroupBox {
            VStack(alignment: .leading, spacing: 20) {
                
                // MARK: - User Header with Animations
                userHeaderView
                
                // MARK: - Post Content with Animation
                postContentView
                
                // MARK: - Post Image with Interactive Animation
                postImageView
                
                // MARK: - Action Buttons with Enhanced Animations
                actionButtonsView
            }
        }
        .scaleEffect(cardScale)
        .scaleEffect(isCardPressed ? 0.98 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: cardScale)
        .animation(.easeInOut(duration: 0.1), value: isCardPressed)
        .onTapGesture {
            // Card press animation
            withAnimation(.easeInOut(duration: 0.1)) {
                isCardPressed = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isCardPressed = false
                }
            }
            
            // Light haptic feedback
            lightHapticFeedback()
        }
        .overlay(
            // Like particles effect
            likeParticlesOverlay
        )
    }
}

// MARK: - View Components
extension PostCardView {
    
    private var userHeaderView: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
                .scaleEffect(isCardPressed ? 1.1 : 1.0)
                .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isCardPressed)
            
            VStack(alignment: .leading) {
                Text(post.userName)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(post.timeAgo)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // More options button with animation
            Button {
                mediumHapticFeedback()
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundColor(.secondary)
                    .scaleEffect(isCardPressed ? 1.2 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isCardPressed)
            }
        }
    }
    
    private var postContentView: some View {
        Text(post.postText)
            .font(.body)
            .lineLimit(nil)
            .opacity(isCardPressed ? 0.7 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isCardPressed)
    }
    
    private var postImageView: some View {
        Image(post.postImage)
            .resizable()
            .scaledToFit()
            .cornerRadius(20)
            .scaleEffect(imageScale)
            .onTapGesture {
                // Image zoom animation
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    imageScale = imageScale == 1.0 ? 1.05 : 1.0
                }
                
                // Double tap to like
                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                    if !isLiked {
                        performLikeAction()
                    }
                }
                
                mediumHapticFeedback()
            }
            .overlay(
                // Double tap heart animation
                Image(systemName: "heart.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .scaleEffect(heartBurst ? 1.5 : 0.1)
                    .opacity(heartBurst ? 0.8 : 0.0)
                    .animation(.spring(response: 0.4, dampingFraction: 0.6), value: heartBurst)
            )
    }
    
    private var actionButtonsView: some View {
        HStack(alignment: .top, spacing: 5) {
            
            // Enhanced Like Button
            Button {
                performLikeAction()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: isLiked ? "heart.fill" : "heart")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .foregroundColor(isLiked ? .red : .primary)
                        .scaleEffect(isLikePressed ? 1.3 : 1.0)
                        .scaleEffect(isLiked ? 1.1 : 1.0)
                        .rotationEffect(.degrees(isLikePressed ? 15 : 0))
                        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isLiked)
                        .animation(.spring(response: 0.2, dampingFraction: 0.7), value: isLikePressed)
                    
                    Text("\(likesNumber)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(isLiked ? .red : .primary)
                        .scaleEffect(isLikePressed ? 1.2 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isLikePressed)
                }
            }
            .socialButtonStyle()
            .scaleEffect(isLikePressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isLikePressed)
            
            Spacer().frame(width: 20)
            
            // Enhanced Comment Button
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    isCommentPressed = true
                    commentsNumber += 1
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.8)) {
                        isCommentPressed = false
                    }
                }
                
                lightHapticFeedback()
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "message")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.primary)
                        .scaleEffect(isCommentPressed ? 1.2 : 1.0)
                        .rotationEffect(.degrees(isCommentPressed ? -10 : 0))
                        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isCommentPressed)
                    
                    Text("\(commentsNumber)")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .scaleEffect(isCommentPressed ? 1.1 : 1.0)
                        .animation(.spring(response: 0.3, dampingFraction: 0.8), value: isCommentPressed)
                }
            }
            .socialButtonStyle()
            .scaleEffect(isCommentPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: isCommentPressed)
            
            Spacer()
        }
    }
    
    private var likeParticlesOverlay: some View {
        ZStack {
            if showLikeParticles {
                ForEach(0..<6, id: \.self) { index in
                    Circle()
                        .fill(Color.red.opacity(0.7))
                        .frame(width: 6, height: 6)
                        .scaleEffect(showLikeParticles ? 1.5 : 0.1)
                        .opacity(showLikeParticles ? 0.8 : 0.0)
                        .offset(
                            x: CGFloat(cos(Double(index) * Double.pi / 3)) * 40,
                            y: CGFloat(sin(Double(index) * Double.pi / 3)) * 40
                        )
                        .animation(
                            .easeOut(duration: 0.6).delay(Double(index) * 0.05),
                            value: showLikeParticles
                        )
                }
            }
        }
    }
}

// MARK: - Animation Functions
extension PostCardView {
    
    private func performLikeAction() {
        // Haptic feedback based on action
        if isLiked {
            lightHapticFeedback()
        } else {
            mediumHapticFeedback()
        }
        
        // Button press animation
        withAnimation(.easeInOut(duration: 0.1)) {
            isLikePressed = true
        }
        
        // Main like animation
        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
            isLiked.toggle()
            
            if isLiked {
                likesNumber += 1
                
                // Heart burst animation
                heartBurst = true
                showLikeParticles = true
                
                // Card celebration animation
                cardScale = 1.02
                
                // Reset animations
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    withAnimation(.easeOut(duration: 0.3)) {
                        heartBurst = false
                        showLikeParticles = false
                        cardScale = 1.0
                    }
                }
            } else {
                likesNumber -= 1
            }
        }
        
        // Reset button press
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            withAnimation(.easeInOut(duration: 0.1)) {
                isLikePressed = false
            }
        }
    }
}

// MARK: - Haptic Feedback Functions
extension PostCardView {
    
    private func lightHapticFeedback() {
        let impact = UIImpactFeedbackGenerator(style: .light)
        impact.impactOccurred()
    }
    
    private func mediumHapticFeedback() {
        let impact = UIImpactFeedbackGenerator(style: .medium)
        impact.impactOccurred()
    }
    
    private func successHapticFeedback() {
        let notification = UINotificationFeedbackGenerator()
        notification.notificationOccurred(.success)
    }
}

// MARK: - Preview
#Preview {
    PostCardView(post: MockData.mockPosts[0])
        .padding()
}
