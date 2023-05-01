//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Shah Md Imran Hossain on 1/5/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    // for async method call task is needed
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Methods
extension CheckoutView {
    func placeOrder() async {
        guard let endcoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        // this is testing server url
        // really nice sever to prototyping
        guard let url = URL(string: "https://reqres.in/api/cupcakes") else {
            print("invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: endcoded)
            // handle the result
        } catch {
            print("Checkout failed")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
