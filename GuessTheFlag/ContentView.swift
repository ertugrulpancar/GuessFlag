//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ertuğrul Pancar on 6.12.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "Türkiye", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score  = 0
    @State private var scoreMessage = ""
    @State private var questionCount = 0
    var body: some View {
        ZStack {
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guees the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack (spacing: 15) {
                    VStack {
                        Text("Tap to flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            
                Spacer()
                Spacer()
            
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
            
                
            
            
        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button ("Continue", action: askQuestion)
            if questionCount == 8 {
                Button("Restart", action: restartGame)
            }
        } message: {
            Text(scoreTitle == "Correct" ? "You got it!" : scoreMessage)
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "You selected the flag of \(countries[number])"
        }
        questionCount += 1
        
        if questionCount == 8 {
            scoreTitle = "Game Over"
            scoreMessage = "Your Final score is \(score)."
            showingScore = true
        }
        else{
            showingScore = true
        }
    }
    func askQuestion() {
        if questionCount < 9 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        
    }
    
    func restartGame() {
        score = 0
        questionCount = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        showingScore = false
    }
}

#Preview {
    ContentView()
}
