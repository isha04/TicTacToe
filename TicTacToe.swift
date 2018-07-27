#!/usr/bin/swift

import Foundation

var validInput = false
var player1PreviousMoves = 0
var player2PreviousMoves = 0
var player1Input: String? = ""
var player2Input: String? = ""
var currentIsPlayer1 = false
var currentIsPlayer2 = false
var player1Choice = ""
var player2Choice = ""
var gameRefreshed = false


var dict = ["1": (row: 0, column: 0),
            "2": (row: 0, column: 1),
            "3": (row: 0, column: 2),
            "4": (row: 1, column: 0),
            "5": (row: 1, column: 1),
            "6": (row: 1, column: 2),
            "7": (row: 2, column: 0),
            "8": (row: 2, column: 1),
            "9": (row: 2, column: 2)]


func helpMessage() {
    print( "\nWecome to the Tic-Tac-Toe Game!" )
    print("When your are asked, choose your character from either \"X\" or \"O\"")
    print( "\nTo play the game chhose the number from the grid, where you want to place your chosen character" )
    print( "You can type the following alphabets : " )
    print( "    q - To quit the game." )
    print( "    r - To restart the game." )
}

enum PlayerMoves: String {
    case anO = "O"
    case aX = "X"
    
    enum empty: String {
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
    }
}

var validResponses: [String] = [PlayerMoves.empty.one.rawValue, PlayerMoves.empty.two.rawValue, PlayerMoves.empty.three.rawValue, PlayerMoves.empty.four.rawValue, PlayerMoves.empty.five.rawValue, PlayerMoves.empty.six.rawValue, PlayerMoves.empty.seven.rawValue, PlayerMoves.empty.eight.rawValue, PlayerMoves.empty.nine.rawValue, "q", "r" ]

let playerChoices = ["O", "X", "q", "r"]


var gameBoard: [[String]] = [[PlayerMoves.empty.one.rawValue, PlayerMoves.empty.two.rawValue, PlayerMoves.empty.three.rawValue],
        [PlayerMoves.empty.four.rawValue, PlayerMoves.empty.five.rawValue, PlayerMoves.empty.six.rawValue],
        [PlayerMoves.empty.seven.rawValue, PlayerMoves.empty.eight.rawValue, PlayerMoves.empty.nine.rawValue]]


func drawBoard() {
    print(" \(gameBoard[0][0]) | \(gameBoard[0][1]) | \(gameBoard[0][2]) ")
    print("___________")
    print(" \(gameBoard[1][0]) | \(gameBoard[1][1]) | \(gameBoard[1][2]) ")
    print("___________")
    print(" \(gameBoard[2][0]) | \(gameBoard[2][1]) | \(gameBoard[2][2]) ")
}

func refresh() {
    gameBoard = [[PlayerMoves.empty.one.rawValue, PlayerMoves.empty.two.rawValue, PlayerMoves.empty.three.rawValue],
        [PlayerMoves.empty.four.rawValue, PlayerMoves.empty.five.rawValue, PlayerMoves.empty.six.rawValue],
        [PlayerMoves.empty.seven.rawValue, PlayerMoves.empty.eight.rawValue, PlayerMoves.empty.nine.rawValue]]
    validInput = false
    player1Input = ""
    player2Input = ""
    player1Choice = ""
    player2Choice = ""
    validResponses = [PlayerMoves.empty.one.rawValue, PlayerMoves.empty.two.rawValue, PlayerMoves.empty.three.rawValue, PlayerMoves.empty.four.rawValue, PlayerMoves.empty.five.rawValue, PlayerMoves.empty.six.rawValue, PlayerMoves.empty.seven.rawValue, PlayerMoves.empty.eight.rawValue, PlayerMoves.empty.nine.rawValue, "q", "r" ]
    currentIsPlayer1 = false
    currentIsPlayer2 = false
    player1PreviousMoves = 0
    player2PreviousMoves = 0
    gameRefreshed = true
    print("Restarting the game")
}


var isWin: Bool {
    return
        gameBoard[0][0] == gameBoard[0][1] && gameBoard[0][0] == gameBoard[0][2] || // row 0
        gameBoard[1][0] == gameBoard[1][1] && gameBoard[1][0] == gameBoard[1][2] || // row 1
        gameBoard[2][0] == gameBoard[2][1] && gameBoard[2][0] == gameBoard[2][2]  || // row 2
        gameBoard[0][0] == gameBoard[1][0] && gameBoard[0][0] == gameBoard[2][0]  || // col 0
        gameBoard[0][1] == gameBoard[1][1] && gameBoard[0][1] == gameBoard[2][1] || // col 1
        gameBoard[0][2] == gameBoard[1][2] && gameBoard[0][2] == gameBoard[2][2] || // col 2
        gameBoard[0][0] == gameBoard[1][1] && gameBoard[0][0] == gameBoard[2][2] || // diag 0
        gameBoard[0][2] == gameBoard[1][1] && gameBoard[0][2] == gameBoard[2][0]  // diag 1
}


var gameQuit: Bool {
    return
        player1Choice == "q" || player2Choice == "q" || player2Input == "q" || player1Input == "q"
}

func getPlayerChoice() {
    var vaidCharacter = false
    while !vaidCharacter {
        print("Player1: Please choose between X or O. Type your choice: ")
        let choice = readLine()
        
        if let z = choice {
            if playerChoices.contains(z) {
                vaidCharacter = true
                player1Choice = z
                
                if player1Choice == "q" {
                    print("Quitting Game")
                    return
                }
                
                if player1Choice == "r" {
                    gameRefreshed = true
                    return
                }
                
                if player1Choice == "O" {
                    player2Choice = "X"
                }
            
                if player1Choice == "X" {
                    player2Choice = "O"
                }
            } else {
                print("Invalid response. Please choose between X or O")
            }
        }
    }
}


func checkValidityOfCharacters(response: String?) -> Bool {
    if let y = response {
        if  validResponses.contains(y) && y.count == 1 {
            if let index = validResponses.index(of: y) {
                validResponses.remove(at: index)
                return true
            }
        }
    }
    return false
}


func checkInputVaidity(input: String?) {
    if let x = input {
        let characterInputValidity = checkValidityOfCharacters(response: x)
        if !characterInputValidity {
            print("Invalid Input. Choose from availabale digits.")
        } else if characterInputValidity {
            validInput = true
        }
    }
}


func getInput() {
    player1Input = ""
    player2Input = ""
    validInput = false
    
    while !validInput {
        if currentIsPlayer1 {
            print("Player1: Please type the number where you want to place your choice of \(player1Choice):")
            player1Input = readLine()
            checkInputVaidity(input: player1Input)
            if player1Input == "q" {
                return
            }
            if player1Input == "r" {
                gameRefreshed = true
                return
            }
        }
        
    
        if currentIsPlayer2 {
            print("Player2: Please type the number where you want to place your choice of \(player2Choice):")
            player2Input = readLine()
            checkInputVaidity(input: player2Input)
            if player2Input == "q" {
                return
            }
            if player2Input == "r" {
                gameRefreshed = true
                return
            }
        }
    }
}


func player1Game() {
    currentIsPlayer1 = true
    currentIsPlayer2 = false
    getInput()
    if gameQuit || gameRefreshed {
        return
    }
    if validInput {
        if let z = player1Input {
            let row = dict[z]?.row
            let column = dict[z]?.column
            gameBoard[row!][column!] = player1Choice
            player1PreviousMoves += 1
            drawBoard()
        }
    }
}


func player2Game() {
    currentIsPlayer1 = false
    currentIsPlayer2 = true
    getInput()
    if gameQuit || gameRefreshed {
        return
    }
    if validInput {
        if let z = player2Input {
            let row = dict[z]?.row
            let column = dict[z]?.column
            gameBoard[row!][column!] = player2Choice
            player2PreviousMoves += 1
            drawBoard()
        }
    }
}


func checkWin() {
    if isWin {
        print("Game Over")
        if currentIsPlayer1 {
            print("Player1 is the winner")
        }
        if currentIsPlayer2 {
            print("Player2 is the winner")
        }
    }
}


func startGame() {
    while (player1PreviousMoves < 3 || player1PreviousMoves == 3) && (player1PreviousMoves < 5 || player1PreviousMoves == 5) && (player2PreviousMoves < 4 || player2PreviousMoves == 4) {
        player1Game()
        
        if player1Input == "q" {
            print("Quitting the game")
            return
        }
        
        if player1Input == "r" {
            gameRefreshed = true
            return
        }
        
        checkWin()
        if isWin {
            gameRefreshed = true
            return
        }
        player2Game()
        
        if  player2Input == "q" {
            print("Quitting the game")
            return
        }
        
        if player2Input == "r" {
            gameRefreshed = true
            return
        }
        
        checkWin()
        if isWin {
            gameRefreshed = true
            return
        }
    }
    
    if !isWin {
        print("No Winner. Game Over")
        gameRefreshed = true
    }
}

func playTheGame() {
    helpMessage()
    drawBoard()
    getPlayerChoice()
    if !gameQuit && !gameRefreshed {
        startGame()
    }
}

func restartGame() {
    while gameRefreshed {
        if gameRefreshed && !gameQuit {
            refresh()
            helpMessage()
            drawBoard()
            getPlayerChoice()
        
            if !gameQuit && gameRefreshed {
                gameRefreshed = false
                startGame()
            } else {
                return
            }
        }
    }
}

playTheGame()
restartGame()
