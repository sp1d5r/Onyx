//
//  DashboardView.swift
//  Black Diamond (iOS)
//
//  Created by Elijah Ahmad on 27/03/2023.
//

import SwiftUI

struct DashboardTotalView: View {
    var totalValue : Float;
    
    init(_ totalValue: Float) {
        self.totalValue = totalValue;
    }
    
    var body: some View {
            HStack {
                
                // Main Text
                Text("£\(totalValue, specifier: "%.2f")")
                    .fontWeight(.heavy)
                    .foregroundColor(WHITE)
                    .font(.title)
                
                Spacer()
                
                // Button to Add new Stock Value
                Button(action: {print("pressed Add")}
                ) {
                    Text("+")
                        .foregroundColor(WHITE)
                        .font(.largeTitle)
                }
            }
            .padding(20)
            .frame(width: UIScreen.screenWidth*0.8)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(PURPLE, lineWidth: 5)
            )
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTotalView(10000)
    }
}
