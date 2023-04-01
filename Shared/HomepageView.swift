//
//  Homepage.swift
//  Black Diamond (iOS)
//
//  Created by Elijah Ahmad on 27/03/2023.
//

import Foundation
import SwiftUI

struct CurrencyPoftolio :Hashable {
    let token: String
    let value: Float
    let rate: Float
    let type: String
}

let portfolio =  [
    CurrencyPoftolio(token: "ada", value: 0.318, rate: 30102, type: "currency"),
    CurrencyPoftolio(token: "btc", value: 22981.31, rate: 0.32, type: "currency"),
    CurrencyPoftolio(token: "eth", value: 3.43, rate:  1480.35, type: "currency")
]

struct CurrencyView: View {
    var token: String
    var coins: Float
    var totalValue: Float
    var rate: Float
    // get icons from https://cryptoicons.org/api  /white/ada/400
    
    init(_ token: String, _ rate: Float, _ coins: Float) {
        self.token = token;
        self.coins = coins
        self.rate = rate;
        self.totalValue = rate * coins
        }
    
    var body: some View {
        HStack {
            NavigationLink(destination: AddToPorfolioView(token, rate)){
                AsyncImage(
                    url: URL(string: "https://cryptoicons.org/api/white/\(token)/400")!
                ) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: 30, height: 30)
                    // Displays the loaded image.
                } else if phase.error != nil {
                    Color.red // Indicates an error.
                } else {
                    Color.white // Acts as a placeholder.
                }
                }.frame(width: 30, height: 30)
            }
            Spacer()
                .frame(width: 15)
            VStack {
                Text("£\(totalValue, specifier: "%.2f")")
                    .fontWeight(.bold)
                    .font(.title2)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(WHITE)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    Text("\(coins, specifier: "%.2f") \(token.uppercased())")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(WHITE)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Text("£\(rate, specifier: "%.2f")")
                        .font(.caption2)
                    .fontWeight(.regular)
                    .foregroundColor(WHITE)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            
                .frame(maxWidth: .infinity)
            }
        }
        .padding(10)
        .frame(width: UIScreen.screenWidth * 0.87)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(WHITE, lineWidth: 1)
        )
    }
}

struct HompageView: View {
    
    func getTotalValue() -> Float {
        var totalValue : Float = 0;
        for currencyValue in portfolio {
            totalValue = totalValue +  Float(currencyValue.value)
        }
        return totalValue;
    }
    
    var body: some View {
        Color(red: 3/255, green: 15/255, blue: 17/255)
            .ignoresSafeArea()
            .overlay(
                
            VStack{
                Text("Portfolio Tracker")
                    .underline(true, color: .white)
                    .fontWeight(.bold)
                    .foregroundColor(WHITE)
                    .multilineTextAlignment(.leading)
                    .padding(20.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                        
                DashboardTotalView(getTotalValue())
                
                Spacer()
                    .frame(height: 10)
                
                HStack {
                    Text("Your Portofolio")
                        .foregroundColor(WHITE)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(portfolio, id:\.self) {
                            contentValue in
                            CurrencyView(contentValue.token, contentValue.rate, contentValue.value)
                        }
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                
                Spacer()
                Spacer()
                }
                .frame(maxHeight: .infinity)
            )
    }
}

struct PreviewsView_Previews: PreviewProvider {
    static var previews: some View {
        HompageView()
    }
}
