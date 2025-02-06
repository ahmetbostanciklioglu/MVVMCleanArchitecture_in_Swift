import SwiftUI

@main
struct Main: App {
    
    /// **Uygulama genelinde kullanılacak ViewModel'i başlatıyoruz.**
    @StateObject private var viewModel = HomeViewModel(
        productsUseCase: ProductsUseCaseImpl(
            repository: ProductsRepositoryImpl(
                productsService: ProductsService(
                    networkService: NetworkService()
                )
            )
        )
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
