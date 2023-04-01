//
//  AddToPorfolio.swift
//  Onyx
//
//  Created by Elijah Ahmad on 01/04/2023.
//

import SwiftUI
import Combine

struct AddToPorfolioView: View {
    var colors = ["No Token Selected","ADA", "BTC", "ETH", "VALS"]
    
    let rate: Float;
    
    @State private var selectedToken = "No Token Selected"
    @State private var tokenAmount = "0"
    
    
    init(_ token: String, _ rate: Float) {
        if (!token.elementsEqual("")) {
            self.selectedToken = token;
        }
        self.rate = rate
    }
    
    var body: some View {
        Color(red: 3/255, green: 15/255, blue: 17/255)
            .ignoresSafeArea()
            .overlay(
                
            VStack{
                Text("Add to Porfolio.")
                    .underline(true, color: .white)
                    .fontWeight(.bold)
                    .foregroundColor(WHITE)
                    .multilineTextAlignment(.leading)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 30)
                
                Picker("Please choose a color", selection: $selectedToken) {
                                ForEach(colors, id: \.self) {
                                    Text($0)
                                        .foregroundColor(WHITE)
                                        
                                }
                            }
                .frame(width: UIScreen.screenWidth * 0.8)
                .foregroundColor(WHITE)
                .accentColor(WHITE)
                .background(
                    Color(red: 41/255, green: 41/255, blue: 41/255)
                )
                .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.purple, lineWidth: 1)
                        )
                
                Spacer().frame(height: 30)
                
                Text("Select an amount")
                    .foregroundColor(WHITE)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                
                TextField("Input", text: $tokenAmount)
                    .onReceive(Just(tokenAmount)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.tokenAmount = filtered
                                    }
                                }
                            .padding()
                            .keyboardType(.decimalPad)
                            .foregroundColor(WHITE)
                            .accentColor(WHITE)
                            .overlay(RoundedRectangle(cornerRadius: 2)
                                .stroke(WHITE, lineWidth: 1)
                            )
                            .frame(width: UIScreen.screenWidth * 0.8)
                
                Spacer().frame(height: 30)
                
                Text("Total Value: \(Float(tokenAmount) ?? 0 * rate)")
                    .foregroundColor(WHITE)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(10)
                
                Spacer()
                
                }
                .padding(15)
            )
    }
}

struct AddToPorfolioView_Previews: PreviewProvider {
    static var previews: some View {
        AddToPorfolioView("", 0.3)
    }
}

class NumbersOnly: ObservableObject {
    @Published var value = "" {
        didSet {
            let filtered = value.filter { $0.isNumber }
            
            if value != filtered {
                value = filtered
            }
        }
    }
}
