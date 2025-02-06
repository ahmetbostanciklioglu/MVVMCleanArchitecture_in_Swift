import SwiftUI

struct ContentView: View {
    
    /// **ViewModel’in bağımsız olarak yönetilmesini sağlar.**
    @ObservedObject var viewModel : HomeViewModel
    
    var body: some View {
        HomeView(viewModel: viewModel)
    }
}
