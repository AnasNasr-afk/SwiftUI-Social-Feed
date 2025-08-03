import SwiftUI

struct SwiftUIFeedView: View {
    @Environment(\.colorScheme) var systemColorScheme
    @State private var userPreferredColorScheme: ColorScheme? = nil
    @State private var posts: [Post] = MockData.mockPosts

    private var currentEffectiveColorScheme: ColorScheme {
        userPreferredColorScheme ?? systemColorScheme
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            // MARK: - Custom App Bar
            HStack {
                Text("Feed")
                    .font(.system(size: 35))
                    .bold()

                Spacer()

                Button {
                    // Toggle the color scheme when the button is tapped
                    if currentEffectiveColorScheme == .light {
                        userPreferredColorScheme = .dark
                    } else {
                        userPreferredColorScheme = .light
                    }
                } label: {
                    // Use the appropriate SF Symbol based on the current mode
                    Image(systemName: currentEffectiveColorScheme == .light ? "sun.max.fill" : "moon.fill")
                        .font(.system(size: 35))
                }
            }
            .padding(.horizontal)
            .padding(.top)
            .padding(.bottom, 8)

            Divider()
            
            // MARK: - Posts Feed
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(posts) { post in
                        PostCardView(post: post)
                    }
                }
                .padding()
            }
        }
        .preferredColorScheme(userPreferredColorScheme)
    }
}

// MARK: - Preview
#Preview {
    SwiftUIFeedView()
}
