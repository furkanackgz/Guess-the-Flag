//
//  ContentView.swift
//  findCountryFlag
//
//  Created by Furkan Açıkgöz on 30.06.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var alertTitle = ""
    @State private var messageTitle = ""
    @State private var alertIsPresented = false
    @State private var countries = ["France", "UK", "US", "Ireland", "Spain", "Estonia", "Germany", "Italy", "Monaco", "Nigeria", "Russia", "Poland"]
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var gameTurn = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.75, green: 0.2, blue: 0.25), location: 0.3)
            ], center: .top, startRadius: 175, endRadius: 700)
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
                VStack(spacing: 20) {
                    VStack(spacing: 5) {
                        Text("Choose the flag of")
                            .foregroundStyle(.secondary)
                            .font(.headline.weight(.bold))
                        
                        Text(countries[correctAnswer])
                            .foregroundColor(.primary)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            checkChosenFlag(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                
                Text("Your score: \(score)")
                    .foregroundColor(.white)
                    .font(.title2)
                
                Spacer()
                Spacer()
                
            }
            .padding(.horizontal, 20)
        }
        .alert(alertTitle, isPresented: $alertIsPresented) {
            if gameTurn == 8 {
                Button("Restart the Game") { restartTheGame() }
            } else {
                Button("Continue") { shuffleTheGame() }
            }
        } message: {
            Text("\(messageTitle)")
        }
        .background(LinearGradient(colors: [Color(red: 0.1, green: 0.2, blue: 0.45),
                                            Color(red: 0.75, green: 0.2, blue: 0.25)], startPoint: .top, endPoint: .bottom))
    }
    
    private func checkChosenFlag(_ number: Int) {
        gameTurn += 1
        
        if number == correctAnswer {
            alertTitle = "Correct"
            score += 1
            
            if gameTurn == 8 {
                messageTitle =
                            """
                            The game is finished
                            Score: \(score)
                            """
            } else {
                messageTitle =
                            """
                            Score: \(score)
                            """
            }
        } else {
            alertTitle = "Wrong"
            score -= 1
            
            if gameTurn == 8 {
                messageTitle =
                            """
                            That is the flag of \(countries[number])
                            The game is finished
                            Score: \(score)
                            """
            } else {
                messageTitle =
                            """
                            That is the flag of \(countries[number])
                            Score: \(score)
                            """
            }
        }
        
        alertIsPresented = true
    }
    
    private func restartTheGame() {
        shuffleTheGame()
        score = 0
        gameTurn = 0
    }
    
    private func shuffleTheGame() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
