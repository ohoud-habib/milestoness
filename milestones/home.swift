import SwiftUI
import Combine

struct HomeView: View {
    @EnvironmentObject var viewModel: ProjectViewModel
    @State private var showShareView = false

    let categories = [
           ("App Store Launch", "🚀"),
           ("Design Project", "🎨"),
           ("Code Project", "💻")
       ]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                Color.background.ignoresSafeArea()
                
                if viewModel.projects.isEmpty {
                    VStack {
                        
                        //   Color.background.ignoresSafeArea()
                            Image("Screen Content1")
                            .offset(x:-30,y:-250)
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)]) {
                            ForEach(viewModel.projects) { project in
                                VStack(alignment: .leading, spacing: 6) {
                                    Image(uiImage: project.image)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 120)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                                        .clipped()
                                    
                                    Text(project.title)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    
                                    HStack {
                                        if let emoji = categories.first(where: { $0.0 == project.category })?.1 {
                                            Text("\(emoji) \(project.category)")
                                                .font(.caption)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.white.opacity(0.1))
                                                .clipShape(Capsule())
                                        } else {
                                            // fallback if not found
                                            Text(project.category)
                                                .font(.caption)
                                                .padding(.horizontal, 8)
                                                .padding(.vertical, 4)
                                                .background(Color.white.opacity(0.1))
                                                .clipShape(Capsule())
                                        }

                                        Spacer()
                                    }

                                }
                                .padding(8)
                                .background(Color.white.opacity(0.05))
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                        }
                        .padding()
                    }
                }
                 Button(action: {
                    showShareView = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.purplee)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                        .padding()
                }
                .sheet(isPresented: $showShareView) {
                    ShareProjectView()
                        .environmentObject(viewModel)
                }
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)        }
    }
}
#Preview {
    HomeView()
    .environmentObject(ProjectViewModel())
}

