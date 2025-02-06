import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var title: String = "Home"
    @Published var companies: [Company] = []
    
    private let productsUserCase: ProductsUseCase
    private var cancellables = Set<AnyCancellable>()
    
    
    init(productsUserCase: ProductsUseCase) {
        self.productsUserCase = productsUserCase
    }
    
    func fetchCompanies() {
        productsUserCase.execute()
            .sink { completion in
                //handle errors if needed
            } receiveValue: { companies in
                self.companies = companies
            }
            .store(in: &cancellables)
    }
}
