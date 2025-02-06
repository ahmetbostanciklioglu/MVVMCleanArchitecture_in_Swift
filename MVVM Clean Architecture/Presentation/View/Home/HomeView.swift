import SwiftUI

/// **Ana Sayfa Görünümü (HomeView)**.
/// - `ObservedObject`: `HomeViewModel` içindeki değişiklikleri izleyerek UI'yi otomatik olarak günceller.
/// - `List`: Şirketleri liste halinde görüntüler.
struct HomeView: View {
    
    /// **ViewModel ile bağlantılı değişken.**
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            /// **Başlık Metni**
            Text(viewModel.title)
                .font(.largeTitle)
                .padding()
            
            /// **Şirketler Listesi**
            List(viewModel.companies) { company in
                HStack {
                    AsyncImage(url: URL(string: company.logo)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(company.name)
                        .font(.headline)
                }
            }
        }
        .onAppear {
            viewModel.fetchCompanies()
        }
    }
}
