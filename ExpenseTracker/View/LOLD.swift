//
//  LOLD.swift
//  ExpenseTracker
//
//  Created by Joshua Yoo on 12/12/24.
//


import SwiftUI

struct LogoPageView: View {
    var body: some View {
        VStack {
            Spacer()
            
            // Display the logo (you can replace the image name with your logo's actual name)
            Image("IOSPHOTO-1") // Make sure to add your logo image in your Xcode project
                .resizable()
                .scaledToFit()
                .frame(width: 500, height: 200) // Adjust the size as needed
            
            // Add a simple welcome text
            Text("Welcome to Expense Tracker")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .padding(.top, 20)
            
            Spacer()
            
            // Button to navigate to the main screen or dashboard
            
        }
        .padding()
        .background(Color.white)
        .navigationBarHidden(true) // Hide the navigation bar
    }
}
