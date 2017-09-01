import Foundation

enum GameDirection {
    case north, east, west, south
}

struct GameLocation {
    let x: Int
    let y: Int
    let allowedDirections: [GameDirection]
    var event: String?
}

struct GameRow {
    let locations: [GameLocation]
}

class GameModel {
    
    private var gameGrid = [GameRow]()
    private var currentRowIndex = 2
    private var currentLocationIndex = 2
    private let minXYvalue = -2
    private let maxXYvalue = 2
    private var usedXCoordinates = [Int]()
    private var usedYCoordinates = [Int]()
    private var buriedTreasure = (randomX: 1, randomY: 1)
    private var bomb = (randomX: 1, randomY: 1)
    private var tresspassingEvent = (randomX: 1, randomY: 1)
    


    var numberOfMoves = 0

    
    init() {
        self.gameGrid = createGameGrid()
        randomizeSpecialEvents()
    }
    
    func restart() {
        usedXCoordinates = []
        usedYCoordinates = []
        currentRowIndex = 2
        currentLocationIndex = 2
        randomizeSpecialEvents()
        numberOfMoves = 0
    }
    
    func randomizeSpecialEvents() {
        self.buriedTreasure = setRandomCoordinates()
        self.bomb = setRandomCoordinates()
        self.tresspassingEvent = setRandomCoordinates()
    }
    
    func setRandomCoordinates () -> (randomX: Int, randomY: Int) {
        var randomX:Int = 0
        var randomY:Int = 0
        repeat {
            randomX = Int(arc4random_uniform(5)) - 2
            randomY = Int(arc4random_uniform(5)) - 2
            
        } while ((usedXCoordinates.contains(randomX) && usedYCoordinates.contains(randomY)) || (randomX == 0 && randomY == 0))
        usedXCoordinates.append(randomX)
        usedYCoordinates.append(randomY)
        return (randomX, randomY)
    }
    
    func currentLocation() -> GameLocation {
        
        // After writing all this code I realized that this is probably not how you wanted it to be done. I know how to fix it, given some more time. Sorry

        
        let yCoordinate = currentRowIndex - 2
        let xCoordinate = currentLocationIndex - 2
        var specEvent:String? = nil
        if xCoordinate == buriedTreasure.randomX && yCoordinate == buriedTreasure.randomY {
            specEvent = "🏆🏆🏆"
        } else if xCoordinate == bomb.randomX && yCoordinate == bomb.randomY {
            specEvent = "💣💣💣"
        } else if xCoordinate == tresspassingEvent.randomX && yCoordinate == tresspassingEvent.randomY{
            specEvent = "GO TO JAIL! 😂"
        }
        return GameLocation(x: xCoordinate, y: yCoordinate, allowedDirections: allowedDirectionsForCoordinate(x: xCoordinate, y: yCoordinate), event: specEvent)
    }
    
    func move(direction: GameDirection) {
        switch direction {
        case .north: currentRowIndex += 1
        case .south: currentRowIndex -= 1
        case .east: currentLocationIndex += 1
        case .west: currentLocationIndex -= 1
        }
        numberOfMoves += 1
        
        // in case you don't want to waste time exploring
        
        print("bomb: \(bomb), treasure: \(buriedTreasure) jail \(tresspassingEvent)")
    }
    
    // MARK: Helper methods for creating grid
    
    private func createGameGrid() -> [GameRow] {
        var gameGrid = [GameRow]()
        
        for yValue in minXYvalue...maxXYvalue {
            var locations = [GameLocation]()
            for xValue in minXYvalue...maxXYvalue {
                let directions = allowedDirectionsForCoordinate(x: xValue, y: yValue)
                let location = GameLocation(x: xValue, y: yValue, allowedDirections: directions, event: nil)
                locations.append(location)
            }
            let gameRow = GameRow(locations: locations)
            gameGrid.append(gameRow)
        }
        return gameGrid
    }
    
    private func allowedDirectionsForCoordinate(x: Int, y: Int) -> [GameDirection] {
        var directions = [GameDirection]()
        switch y {
        case minXYvalue:    directions += [.north]
        case maxXYvalue:    directions += [.south]
        default:            directions += [.north, .south]
        }
        switch x {
        case minXYvalue:    directions += [.east]
        case maxXYvalue:    directions += [.west]
        default:            directions += [.east, .west]
        }
        return directions
    }

}





