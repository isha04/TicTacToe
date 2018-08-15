#!/usr/bin/swift

import Foundation

var currentPlayerIsHuman = false
var currentPlayerIsComputer = false
var humanPlayerCharacter = ""
var computerPlayerCharacter = ""
var humanPlayerChoice = ""
var gameRefreshed = false
var validInput = false


enum PlayerMoves: String {
    case o = "o"
    case x = "x"
    case quit = "q"
    case restart = "r"
    case yes = "y"
    case no = "n"
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


let boardIndices = ["1": (row: 0, column: 0),
                    "2": (row: 0, column: 1),
                    "3": (row: 0, column: 2),
                    "4": (row: 1, column: 0),
                    "5": (row: 1, column: 1),
                    "6": (row: 1, column: 2),
                    "7": (row: 2, column: 0),
                    "8": (row: 2, column: 1),
                    "9": (row: 2, column: 2)]


//valid responses for the game's grid - Player can type a number between 1 - 9 or r (to restart) or q (to quit)
var validResponses: [String] = [PlayerMoves.empty.one.rawValue, PlayerMoves.empty.two.rawValue, PlayerMoves.empty.three.rawValue,
                                PlayerMoves.empty.four.rawValue, PlayerMoves.empty.five.rawValue, PlayerMoves.empty.six.rawValue,
                                PlayerMoves.empty.seven.rawValue, PlayerMoves.empty.eight.rawValue, PlayerMoves.empty.nine.rawValue ]

var gameBoard: [[String]] = [[PlayerMoves.empty.one.rawValue, PlayerMoves.empty.two.rawValue, PlayerMoves.empty.three.rawValue],
                             [PlayerMoves.empty.four.rawValue, PlayerMoves.empty.five.rawValue, PlayerMoves.empty.six.rawValue],
                             [PlayerMoves.empty.seven.rawValue, PlayerMoves.empty.eight.rawValue, PlayerMoves.empty.nine.rawValue]]


//Conditions for winning the game
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
        humanPlayerChoice == PlayerMoves.quit.rawValue
}


func drawBoard() {
    print("\n")
    print(" \(gameBoard[0][0]) | \(gameBoard[0][1]) | \(gameBoard[0][2]) ")
    print("___________")
    print(" \(gameBoard[1][0]) | \(gameBoard[1][1]) | \(gameBoard[1][2]) ")
    print("___________")
    print(" \(gameBoard[2][0]) | \(gameBoard[2][1]) | \(gameBoard[2][2]) ")
    print("\n")
}


func welcomeMessage() {
    print( "\nWelcome to Isha's 1 player Tic-Tac-Toe Game!" )
    print("You will be asked to if you want to play first.\nPress \"y\" if you want to go first. Press \"n\"    if you want the computer to go first. \nThe player to take the first turn will get \"o\" as their sign. \nThe player to go second will get \"x\" as their sign. ")
    print( "\nTo play the game, choose the number from the grid below, where you want to place your chosen sign." )
    print( "You can enter 'q' to quit the game and 'r' to restart the game.\n")
}


func playerToGoFirst() {
    var yesNoValidity = false
    
    print("Do you want to take the first turn? Type \"y\" if you want to go first. Type \"n\" if you want the computer to go first")
    while !yesNoValidity {
        let yesOrNoInput = readLine()
        if let z = yesOrNoInput {
            switch z {
            case PlayerMoves.yes.rawValue:
                yesNoValidity = true
                humanPlayerCharacter = PlayerMoves.o.rawValue
                computerPlayerCharacter = PlayerMoves.x.rawValue
                humanPlayerChoice = z
                if humanPlayerChoice == PlayerMoves.restart.rawValue {
                    gameRefreshed = true
                    return
                }
                currentPlayerIsHuman = true
                currentPlayerIsComputer = false
                
            case PlayerMoves.no.rawValue:
                yesNoValidity = true
                humanPlayerCharacter = PlayerMoves.x.rawValue
                computerPlayerCharacter = PlayerMoves.o.rawValue
                humanPlayerChoice = z
                currentPlayerIsComputer = true
                currentPlayerIsHuman = false
                
            case PlayerMoves.quit.rawValue:
                humanPlayerChoice = z
                return
            case PlayerMoves.restart.rawValue:
                humanPlayerChoice = z
                gameRefreshed = true
                yesNoValidity = false
                return
            default:
                yesNoValidity = false
                print("Invalid Input. Please type \"y\" if you want to go first. type \"n\" if you want the computer to go first")
            }
        }
    }
}


func checkValidityOfCharacters(response: String?) -> Bool {
    if let y = response {
        if  (validResponses.contains(y) && y.count == 1) {
            if let index = validResponses.index(of: y) {
                validResponses.remove(at: index)
                return true
            }
        } else if y == "r" || y == "q" {
            return true
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
            humanPlayerChoice = t
        }
    }
}


//Getting input for where in the grid to place the humanPlayer's signs (x and o)
func getInput() {
    validInput = false
    if !gameQuit || !gameRefreshed {
        while !validInput {
            if currentPlayerIsHuman {
                print("Your turn. Please enter the available number from the grid where you want to place your sign")
                let gridInput = readLine()
                checkInputVaidity(input: gridInput)
            }
        }
    }
}


func computerPlays() {
    if currentPlayerIsComputer {
        if let randomCharacter = validResponses.randomItem() {
            let row = boardIndices[randomCharacter]?.row
            let column = boardIndices[randomCharacter]?.column
            gameBoard[row!][column!] = computerPlayerCharacter
            if let index = validResponses.index(of: randomCharacter) {
                validResponses.remove(at: index)
            }
            print("Computer's turn")
            drawBoard()
            currentPlayerIsComputer = false
            currentPlayerIsHuman = true
        }
    }
}


func humanPlays() {
    if currentPlayerIsHuman {
        getInput()
        if validInput {
            if humanPlayerChoice == PlayerMoves.restart.rawValue {
                gameRefreshed = true
            }
            if gameQuit || gameRefreshed {
                return
            }
            let row = boardIndices[humanPlayerChoice]?.row
            let column = boardIndices[humanPlayerChoice]?.column
            gameBoard[row!][column!] = humanPlayerCharacter
            if let index = validResponses.index(of: humanPlayerChoice) {
                validResponses.remove(at: index)
            }
            drawBoard()
            currentPlayerIsComputer = true
            currentPlayerIsHuman = false
        }
    }
}


func startGame() {
    while validResponses.count > 0 {
        humanPlays()
        if gameQuit || gameRefreshed {
            return
        }
        if isWin {
            gameRefreshed = true
            print("Game Over")
            print("\n-----------------------------------")
            print("You win")
            print("-----------------------------------\n")
            return
        }
        computerPlays()
        
        if isWin {
            gameRefreshed = true
            print("Game Over")
            print("\n-----------------------------------")
            print("You lose")
            print("-----------------------------------\n")
            return
        }
    }
    if !isWin {
        print("\n-----------------------------------")
        print("No Winner. Game Over")
        print("-----------------------------------\n")
        gameRefreshed = true
        return
    }
}

//Restoring all variables to default value to restart the game
func refresh() {
    gameBoard = [[PlayerMoves.empty.one.rawValue, PlayerMoves.empty.two.rawValue, PlayerMoves.empty.three.rawValue],
                 [PlayerMoves.empty.four.rawValue, PlayerMoves.empty.five.rawValue, PlayerMoves.empty.six.rawValue],
                 [PlayerMoves.empty.seven.rawValue, PlayerMoves.empty.eight.rawValue, PlayerMoves.empty.nine.rawValue]]
    validInput = false
    validResponses = [PlayerMoves.empty.one.rawValue, PlayerMoves.empty.two.rawValue, PlayerMoves.empty.three.rawValue, PlayerMoves.empty.four.rawValue, PlayerMoves.empty.five.rawValue, PlayerMoves.empty.six.rawValue, PlayerMoves.empty.seven.rawValue, PlayerMoves.empty.eight.rawValue, PlayerMoves.empty.nine.rawValue]
    currentPlayerIsHuman = false
    currentPlayerIsComputer = false
    humanPlayerCharacter = ""
    computerPlayerCharacter = ""
    humanPlayerChoice = ""
    gameRefreshed = false
    validInput = false
    print("Restarting the game")
}


func restartGame() {
    while gameRefreshed {
        refresh()
        gameRefreshed = false
        drawBoard()
        playerToGoFirst()
        
        if gameQuit {
            print("Quitting the game")
            return
        } else if gameRefreshed && !gameQuit {
            refresh()
            playerToGoFirst()
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

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

func playTheGame() {
    welcomeMessage()
    drawBoard()
    playerToGoFirst()
    if !gameQuit {
        startGame()
    }
    restartGame()
}

playTheGame()

