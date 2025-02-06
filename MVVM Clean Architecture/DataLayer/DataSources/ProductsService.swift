import Foundation
import Combine

class ProductsService {
    
    ///Bağımlılık enjeksiyonu (Dependency Injection) kullanarak dışarıdan bir NetworkService nesnesi alıyor. Böylece, test edilebilirliği artırır.
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    ///AnyPublisher Combine framework’te veri akışını yöneten bir türdür.
    func fetchCompanies() -> AnyPublisher<[Company], Error> {
        guard let url = URL(string: "https://127.0.0.1:3001/allproducts") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return networkService.request(url)
            .map { (response: CompaniesResponse) in
                response.companies
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
