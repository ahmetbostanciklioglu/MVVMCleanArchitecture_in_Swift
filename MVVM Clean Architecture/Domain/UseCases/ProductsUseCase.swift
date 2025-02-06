import Foundation
import Combine


protocol ProductsUseCase {
    func execute() -> AnyPublisher<[Company], Error>
}


class ProductsUseCaseImpl: ProductsUseCase {

    private let repository: ProductsRepository
    
    init(repository: ProductsRepository) {
        self.repository = repository
    }
    
    
    func execute() -> AnyPublisher<[Company], any Error> {
        return repository.fetchAllProducts()
    }
    
    
}
