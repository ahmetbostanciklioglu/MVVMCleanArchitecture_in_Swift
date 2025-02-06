import Foundation
import Combine

/// **Ana Sayfa Görünüm Modeli (HomeViewModel)**.
/// - `ObservableObject`: SwiftUI'de veri değişimlerini otomatik olarak izler.
/// - `@Published` değişkenleri, UI'nin otomatik olarak güncellenmesini sağlar.
class HomeViewModel: ObservableObject {
    
    /// **Ekranın başlık metni**.
    @Published var title: String = "Home"
    
    /// **Şirketler listesi** (UI'yi günceller).
    @Published var companies: [Company] = []
    
    /// Ürünleri almak için kullanılan **Use Case** katmanı.
    private let productsUseCase: ProductsUseCase
    
    /// Combine aboneliklerini saklayan yapı.
    private var cancellables = Set<AnyCancellable>()
    
    /// **`HomeViewModel` başlatıcısı**.
    /// - Parameter productsUseCase: Şirket verilerini getiren **ProductsUseCase** örneği.
    init(productsUseCase: ProductsUseCase) {
        self.productsUseCase = productsUseCase
    }
    
    /// **Şirketleri API’den getirir ve UI’yi günceller**.
    func fetchCompanies() {
        productsUseCase.execute()
            .receive(on: DispatchQueue.main) // Ana iş parçacığında (main thread) güncellenmesini sağlar.
            .sink { completion in
                switch completion {
                case .finished:
                    break // Başarılı tamamlandı, işlem gerekmiyor.
                case .failure(let error):
                    print("Şirketler alınırken hata oluştu: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] companies in
                self?.companies = companies
            }
            .store(in: &cancellables)
    }
}
