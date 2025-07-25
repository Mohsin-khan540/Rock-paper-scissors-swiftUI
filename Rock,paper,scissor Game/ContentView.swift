//
//  ContentView.swift
//  Rock,paper,scissor Game
//
//  Created by Mohsin khan on 25/07/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var gameImages = ["rock", "paper", "scissors"]
    
    @State private var computerChoice = Int.random(in: 0...2)
    @State private var userChoice = 0
    
    @State private var computerScore = 0
    @State private var playerScore = 0
    
    @State private var scoreTitle = ""
    @State private var showingScore = false
    
    @State private var isGameOver = false
    
    @State private var Round = 1
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black, .gray], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                Text("Round : \(Round)")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                    .frame(width: 200 , height:50)
                    .background(.blue)
                    .clipShape(.buttonBorder)
                Spacer().frame(height: 50)
                // Title
                if !isGameOver{
                Text("Make your move!")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                }else{
                Text("🎉 Game Over!")
                .font(.largeTitle)
                .foregroundStyle(.white)
                }
                              
                
                VStack(spacing: 20) {
                    Text("Choose Rock, Paper or Scissors:")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                    
                    Spacer().frame(height: 30)
                    
                    HStack(spacing: 30) {
                        ForEach(0..<3) { number in
                            Button {
                                if !isGameOver {
                                    userChoice = number
                                    generateComputerChoice()
                                    checkWinner()
                                    showingScore = true
                                    Round += 1
                                }
                            } label: {
                                Image(gameImages[number])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                        }
                    }
                    
                    Spacer().frame(height: 40)
                    
                   
                        Text("Player Score: \(playerScore)")
                        .font(.title2)
                       .foregroundStyle(.secondary)
                        Text("Computer Score: \(computerScore)")
                       .font(.title2)
                        .foregroundStyle(.red)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.horizontal)
                Spacer().frame(height: 130)
            }
           
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if isGameOver {
                Button("Play Again", action: resetGame)
            } else {
                Button("Next Round", role: .cancel) {}
            }
        }
    }
    
    func generateComputerChoice() {
        computerChoice = Int.random(in: 0...2)
    }
    
    func checkWinner() {
        if computerChoice == userChoice {
            scoreTitle = "It's a tie! Both chose \(gameImages[userChoice])."
        } else if (userChoice == 0 && computerChoice == 2) ||
                  (userChoice == 1 && computerChoice == 0) ||
                  (userChoice == 2 && computerChoice == 1) {
            playerScore += 1
            scoreTitle = "\(gameImages[userChoice]) beats \(gameImages[computerChoice]). You win this round!"
        } else {
            computerScore += 1
            scoreTitle = "\(gameImages[computerChoice]) beats \(gameImages[userChoice]). Computer wins this round!"
        }
        
        // Check for Game Over
        if playerScore == 5 {
            scoreTitle = "🎉 You Win the Game!"
            isGameOver = true
        } else if computerScore == 5 {
            scoreTitle = "💻 Computer Wins the Game!"
            isGameOver = true
        }
    }
    
    func resetGame() {
        playerScore = 0
        computerScore = 0
        isGameOver = false
        generateComputerChoice()
    }
}

#Preview {
    ContentView()
}
