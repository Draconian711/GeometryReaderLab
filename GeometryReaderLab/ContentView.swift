//
//  ContentView.swift
//  GeometryReaderLab
//
//  Created by Kevin Bjornberg on 2/1/25.
//

import SwiftUI

struct ProfileGridView: View {
    @Environment(\.horizontalSizeClass) var sizeClass  // Get the horizontal size class

    let profiles = [
        ("Alice", "A passionate developer.", "person.circle"),
        ("Bob", "Designer and artist.", "person.fill"),
        ("Charlie", "UI/UX expert.", "person.crop.circle"),
        ("David", "Backend guru.", "person.circle.fill"),
        ("Eve", "Creative director.", "person.crop.circle"),
        ("Frank", "Full-stack developer.", "person.fill"),
        ("Grace", "Product manager.", "person.circle"),
        ("Hank", "Business strategist.", "person.circle.fill")
    ]

    var body: some View {
        GeometryReader { geometry in
            let columns = sizeClass == .compact ? 2 : 3  // 2 for compact, 3 for regular
            let cardWidth = (geometry.size.width - CGFloat(columns + 1) * 16) / CGFloat(columns)  // Calculate the width of each card with spacing
            
            let rows = (profiles.count + columns - 1) / columns  // Calculate row count
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(0..<rows, id: \.self) { row in
                        HStack(spacing: 16) {
                            ForEach(0..<columns, id: \.self) { col in
                                let index = row * columns + col
                                if index < profiles.count {
                                    ProfileCard(name: profiles[index].0, description: profiles[index].1, image: "person.circle", width: cardWidth)  // Pass data to the card
                                } else {
                                    Spacer()  // Ensure alignment when the last row has fewer items
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct ProfileCard: View {
    let name: String
    let description: String
    let image: String
    let width: CGFloat

    var body: some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding()

            Text(name)
                .font(.headline)
                .foregroundColor(.primary)

            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)  // Limit the description to a few lines
                .multilineTextAlignment(.center)
                .padding([.top, .bottom], 4)
        }
        .frame(width: width, height: 220)  // Adjust card height to fit content
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 5)
        .padding(.vertical, 8)
    }
}

struct ContentView: View {
    var body: some View {
        ProfileGridView()
            .background(Color.gray.opacity(0.2).edgesIgnoringSafeArea(.all))
    }
}



#Preview {
    ContentView()
}
