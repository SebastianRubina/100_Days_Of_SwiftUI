//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Sebastián Rubina on 2025-03-24.
//

import SwiftUI

struct ContentView: View {
    let MAX_QUESTIONS = 4
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var alertMessage = ""
    @State private var userScore = 0
    @State private var currentQuestion = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle)
                            .fontWeight(.semibold)
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
                
                Text("Score: \(userScore)/\(currentQuestion)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding(.horizontal)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if currentQuestion < MAX_QUESTIONS {
                Button("Continue") {
                    askQuestion()
                }
            } else {
                Button("Restart") {
                    restartGame()
                }
            }
        } message: {
            Text(alertMessage)
        }
    }
    
    func flagTapped(_ number: Int) {
        currentQuestion += 1
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
            alertMessage = "Your score is \(userScore)/\(currentQuestion)"
        } else {
            scoreTitle = "Wrong"
            alertMessage = "That is the flag of \(countries[number])"
        }
        
        if currentQuestion == MAX_QUESTIONS {
            scoreTitle = "Final Score: \(userScore)/\(currentQuestion)"
            alertMessage = "Would you like to restart?"
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        currentQuestion = 0
        userScore = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
