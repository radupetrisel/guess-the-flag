//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Radu Petrisel on 06.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var numberOfQuestionsLeft = 8
    @State private var showingGameOver = false
    
    @State private var flagRotationAngles = [0.0, 0.0, 0.0]
    @State private var flagOpacities = [1.0, 1.0, 1.0]
    @State private var flagScales = [1.0, 1.0, 1.0]
    
    var body: some View {
        ZStack {
           RadialGradient(stops: [
            .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
            .init(color: Color(red: 0.76, green: 0.15, blue: 0.2), location: 0.3)
           ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Text(countries[correctAnswer])
                            .largeBlueTitleFont()
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(flagName: countries[number])
                                .rotation3DEffect(.degrees(flagRotationAngles[number]), axis: (x: 0, y: 1, z: 0))
                                .opacity(flagOpacities[number])
                                .scaleEffect(flagScales[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game over", isPresented: $showingGameOver) {
            Button("New game", action: startGame)
        } message: {
            Text("Your final score was \(score).")
        }
    }
    
    private func flagTapped(_ number: Int) {
        withAnimation {
            flagRotationAngles[number] = 360
            
            for i in flagOpacities.indices {
                if i != number {
                    flagOpacities[i] = 0.25
                }
            }
            
            for i in flagScales.indices {
                if i != number {
                    flagScales[i] = 0.2
                }
            }
        }
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreMessage = "Good job!"
            score += 1
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That was the flag of \(countries[number])."
            score -= 1
        }
        
        numberOfQuestionsLeft -= 1
        
        if numberOfQuestionsLeft > 0 {
            showingScore = true
        } else {
            showingGameOver = true
        }
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        for i in flagRotationAngles.indices {
            flagRotationAngles[i] = 0
        }
        
        for i in flagOpacities.indices {
            flagOpacities[i] = 1.0
        }
        
        for i in flagOpacities.indices {
            flagScales[i] = 1.0
        }
    }
    
    private func startGame() {
        numberOfQuestionsLeft = 8
        score = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
