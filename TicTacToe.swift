#!/usr/bin/swift

// The above line refers to the path where swift is installed on your system.

// Install Swift: https://swift.org/download/

// If you are not able to run the file because of permission issue, please run the below command (make sure that .swift is included in the file-path)
// chmod +x <path-to-this-file>


var validInput = false
var player1PreviousMoves = 0
var player2PreviousMoves = 0
var player1Input: String? = ""
var player2Input: String? = ""
var currentIsPlayer1 = false
var currentIsPlayer2 = false
var player1Choice = ""
var player2Choice = ""
var gameDraw = false


var boardIndices = ["1": (row: 0, column: 0),
            "2": (row: 0, column: 1),
            "3": (row: 0, column: 2),
            "4": (row: 1, column: 0),
            "5": (row: 1, column: 1),
            "6": (row: 1, column: 2),
            "7": (row: 2, column: 0),
            "8": (row: 2, column: 1),
            "9": (row: 2, column: 2)]


func helpMessage() {
    print( "\nWelcome to Isha's Tic-Tac-Toe Game!" )
    print("When your are asked, choose your sign from either 'x' or 'o'")
    print( "\nTo play the game, choose the number from the grid below, where you want to place your chosen sign." )
    print( "You can enter 'q' to quit the game and 'r' to restart the game.\n")
}


enum PlayerMoves: String {
    case o = "o"
    case x = "x"
    case quit = "q"
    case restart = "r"
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

var validResponses: [String] = [PlayerMoves.empty.one.rawValue, PlayerMoves.empty.two.rawValue, PlayerMoves.empty.three.rawValue,
                                PlayerMoves.empty.four.rawValue, PlayerMoves.empty.five.rawValue, PlayerMoves.empty.six.rawValue,
                                PlayerMoves.empty.seven.rawValue, PlayerMoves.empty.eight.rawValue, PlayerMoves.empty.nine.rawValue,
                                PlayerMoves.quit.rawValue, PlayerMoves.restart.rawValue ]

let playerChoices = [PlayerMoves.o.rawValue, PlayerMoves.x.rawValue, PlayerMoves.quit.rawValue, PlayerMoves.restart.rawValue]


var gameBoard: [[String]] = [[PlayerMoves.empty.one.rawValue, PlayerMoves.empty.two.rawValue, PlayerMoves.empty.three.rawValue],
                             [PlayerMoves.empty.four.rawValue, PlayerMoves.empty.five.rawValue, PlayerMoves.empty.six.rawValue],
                             [PlayerMoves.empty.seven.rawValue, PlayerMoves.empty.eight.rawValue, PlayerMoves.empty.nine.rawValue]]


func drawBoard() {
    print("\n")
    print(" \(gameBoard[0][0]) | \(gameBoard[0][1]) | \(gameBoard[0][2]) ")
    print("___________")
    print(" \(gameBoard[1][0]) | \(gameBoard[1][1]) | \(gameBoard[1][2]) ")
    print("___________")
    print(" \(gameBoard[2][0]) | \(gameBoard[2][1]) | \(gameBoard[2][2]) ")
    print("\n")
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
    validResponses = [PlayerMoves.empty.one.rawValue, PlayerMoves.empty.two.rawValue, PlayerMoves.empty.three.rawValue, PlayerMoves.empty.four.rawValue, PlayerMoves.empty.five.rawValue, PlayerMoves.empty.six.rawValue, PlayerMoves.empty.seven.rawValue, PlayerMoves.empty.eight.rawValue, PlayerMoves.empty.nine.rawValue, PlayerMoves.quit.rawValue, PlayerMoves.restart.rawValue]
    currentIsPlayer1 = false
    currentIsPlayer2 = false
    player1PreviousMoves = 0
    player2PreviousMoves = 0
    gameDraw = false
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
        player1Choice == PlayerMoves.quit.rawValue || player2Choice == PlayerMoves.quit.rawValue || player2Input == PlayerMoves.quit.rawValue || player1Input == PlayerMoves.quit.rawValue
}

var gameRefreshed: Bool {
    return
        player1Choice == PlayerMoves.restart.rawValue || player2Choice == PlayerMoves.restart.rawValue || player2Input == PlayerMoves.restart.rawValue || player1Input == PlayerMoves.restart.rawValue || isWin || gameDraw
}


func getPlayerChoice() {
    var vaidCharacter = false
    while !vaidCharacter {
        print("\nPlayer1: Please choose between x or o. Type your choice: ")
        let choice = readLine()
        
        if let z = choice {
            if playerChoices.contains(z) {
                vaidCharacter = true
                player1Choice = z
                
                //Checking if player has pressed "r" or "q" to quit/restart
                if gameQuit {
                    return
                } else if gameRefreshed {
                    return
                }
                
                //Setting choice of character
                if player1Choice == PlayerMoves.o.rawValue {
                    player2Choice = PlayerMoves.x.rawValue
                } else if player1Choice == PlayerMoves.x.rawValue {
                    player2Choice = PlayerMoves.o.rawValue
                }
                
            } else {
                print("\nInvalid response. Please choose between 'x' or 'o'")
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
    if let t = input {
        let characterInputValidity = checkValidityOfCharacters(response: t)
        if !characterInputValidity {
            print("Invalid Input. Choose from available numbers.\n")
        } else if characterInputValidity {
            validInput = true
        }
    }
}


func getInput() {
    player1Input = ""
    player2Input = ""
    validInput = false
    
    if gameRefreshed || gameQuit {
        return
    }
    
    while !validInput {
        //Getting input from Player1
        if currentIsPlayer1 {
            print("Player1: Please enter the available number from the grid where you want to place your sign \(player1Choice):")
            player1Input = readLine()
            checkInputVaidity(input: player1Input)
        }
        
        //Getting input from Player2
        if currentIsPlayer2 {
            print("Player2: Please enter the available number from the grid where you want to place your sign \(player2Choice):")
            player2Input = readLine()
            checkInputVaidity(input: player2Input)
        }
    }
}


func player1Game() {
    currentIsPlayer1 = true
    currentIsPlayer2 = false
    getInput()
   
    if validInput {
        if let z = player1Input {
            if gameQuit || gameRefreshed {
                return
            }
            let row = boardIndices[z]?.row
            let column = boardIndices[z]?.column
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
    
    if validInput {
        if let z = player2Input {
            if gameQuit || gameRefreshed {
                return
            }
            let row = boardIndices[z]?.row
            let column = boardIndices[z]?.column
            gameBoard[row!][column!] = player2Choice
            player2PreviousMoves += 1
            drawBoard()
        }
    }
}


func checkWin() {
    if isWin {
        gameDraw = false
        print("Game Over")
        if currentIsPlayer1 {
            print("\n-----------------------------------")
            print("Player1 is the winner")
            print("-----------------------------------\n")
        } else if currentIsPlayer2 {
            print("\n-----------------------------------")
            print("Player2 is the winner")
            print("-----------------------------------\n")
        }
    }
}


func startGame() {
    while (player1PreviousMoves < 3 || player1PreviousMoves == 3) && (player1PreviousMoves < 5 || player1PreviousMoves == 5) && (player2PreviousMoves < 4 || player2PreviousMoves == 4) {
        
        player1Game()
        if gameQuit {
            print("Quitting the game")
            return
        } else if gameRefreshed {
           return
        }
        
        checkWin()
        if isWin {
            return
        }
        
        player2Game()
        if  gameQuit {
            print("Quitting the game")
            return
        } else if gameRefreshed {
            return
        }
        
        checkWin()
        if isWin {
            return
        }
    }
    
    if !isWin {
        print("\n-----------------------------------")
        print("No Winner. Game Over")
        print("-----------------------------------\n")
        gameDraw = true
        print("comes here")
        return
    }
}


func restartGame() {
    while gameRefreshed {
        
        refresh()
        drawBoard()
        getPlayerChoice()
            
        if gameQuit {
            print("Quitting the game")
            return
        } else if gameRefreshed && !gameQuit {
            refresh()
            getPlayerChoice()
            startGame()
            if gameQuit {
                return
            }
        } else if !gameRefreshed && !gameQuit {
            startGame()
            if gameQuit {
                return
            }
        }
    }
}



func playTheGame() {
    helpMessage()
    drawBoard()
    getPlayerChoice()
    if !gameQuit {
        startGame()
    }
    restartGame()
}




playTheGame()


