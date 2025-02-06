import Foundation
import Combine

protocol ProductsRepository {
    func fetchAllProducts() -> AnyPublisher<[Company], Error>
}

class ProductsRepositoryImpl: ProductsRepository {
    
    private let productsService: ProductsService
    
    init(productsService: ProductsService) {
        self.productsService = productsService
    }
    
    func fetchAllProducts() -> AnyPublisher<[Company], any Error> {
        
        return productsService.fetchCompanies()
    }
}
