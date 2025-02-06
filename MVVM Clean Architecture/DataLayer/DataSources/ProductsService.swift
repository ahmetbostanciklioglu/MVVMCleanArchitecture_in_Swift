import Foundation
import Combine

/// `ProductsService`, şirket verilerini almak için bir servis sağlar.
/// Combine kullanarak asenkron veri akışı yönetir.
class ProductsService {
    
    /// Ağ isteklerini yönetmek için kullanılan servis.
    /// Bağımlılık enjeksiyonu (Dependency Injection) sayesinde dışarıdan bir `NetworkService` nesnesi alır.
    /// Bu yaklaşım, test edilebilirliği artırır.
    private let networkService: NetworkService
    
    /// `ProductsService` için başlatıcı (initializer).
    /// - Parameter networkService: Ağ isteklerini yönetecek `NetworkService` örneği.
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    /// API'den şirketler listesini getirir.
    /// - Returns: `[Company]` dizisini içeren bir `AnyPublisher`. Hata durumunda `Error` fırlatır.
    func fetchCompanies() -> AnyPublisher<[Company], Error> {
        /// API çağrısı yapılacak URL'yi oluşturur.
        guard let url = URL(string: "https://127.0.0.1:3001/allproducts") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return networkService.request(url)
            .map { (response: CompaniesResponse) in
                /// API’den gelen `CompaniesResponse` içindeki `companies` listesini döndürür.
                response.companies
            }
            /// Ana iş parçacığında (`main thread`) yayınlanmasını sağlar.
            .receive(on: DispatchQueue.main)
            /// Publisher türünü `AnyPublisher` olarak soyutlar.
            .eraseToAnyPublisher()
    }
}
