
import UIKit

class GameViewController: UIViewController {
    
    let model = GameModel()
    
    // IBOutlets
    
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var eventLogLabel: UILabel!
    @IBOutlet weak var northButton: UIButton!
    @IBOutlet weak var eastButton: UIButton!
    @IBOutlet weak var southButton: UIButton!
    @IBOutlet weak var westButton: UIButton!
    @IBOutlet weak var specEventLabel: UILabel!
    @IBOutlet weak var moveCounterLabel: UILabel!
    
    // Set up any properties needed
    
    var bestScore:Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        let currentLocation = model.currentLocation()
        currentLocationLabel.text = "(\(currentLocation.x),\(currentLocation.y))"
        specEventLabel.isHidden = true

        // Do any additional setup after loading the view.
    }
    
    
    //  Connect IBActions
    @IBAction func northButtonPushed(_ sender: UIButton) {
        model.move(direction: .north)
        updateLabelsAndButtons(direction: "⬆️")

    }
    
    @IBAction func eastButtonPushed(_ sender: UIButton) {
        model.move(direction: .east)
        updateLabelsAndButtons(direction: "➡️")
    }
    
    @IBAction func westButtonPushed(_ sender: UIButton) {
        model.move(direction: .west)
        updateLabelsAndButtons(direction: "⬅️")
    }
    
    @IBAction func southButtonPushed(_ sender: UIButton) {
        model.move(direction: .south)
        updateLabelsAndButtons(direction: "⬇️")
    }
    
    @IBAction func resetButtonPushed(_ sender: UIButton) {
        model.restart()
        updateLabelsAndButtons()
        specEventLabel.isHidden = true
    }
    
    
    func updateLabelsAndButtons (direction:String? = nil){
        updateButtons()
        updateEventLogLabel(direction: direction)
        updateCurrentLocationLabel()
        updateMoveCounter()
        if let specialEvent = model.currentLocation().event {
            updateSpecialEventLabel(specialEvent: specialEvent)
        }
        
     }
    func updateButtons () {
        if !model.currentLocation().allowedDirections.contains(.north) {
            northButton.isHidden = true
        } else {
            northButton.isHidden = false
            
        }
        if !model.currentLocation().allowedDirections.contains(.south) {
            southButton.isHidden = true
        } else {
            southButton.isHidden = false

            
        }
        if !model.currentLocation().allowedDirections.contains(.east) {
            eastButton.isHidden = true
        } else {
            eastButton.isHidden = false

            
        }
        if !model.currentLocation().allowedDirections.contains(.west) {
            westButton.isHidden = true
        } else {
            westButton.isHidden = false

            
        }
    }
    
    func updateEventLogLabel (direction: String? = nil) {
        if let movedDirection = direction {
            eventLogLabel.text = "Last move: \(movedDirection)"
        } else {
            eventLogLabel.text = "The game has been reset!"
        }
    }
    func updateCurrentLocationLabel () {
        currentLocationLabel.text = "(\(model.currentLocation().x),\(model.currentLocation().y))"
    }
    func updateMoveCounter() {
        moveCounterLabel.text = "Move Counter: \(model.numberOfMoves)"
    }
    func updateSpecialEventLabel (specialEvent: String) {
            specEventLabel.isHidden = false
            specEventLabel.text = "\(specialEvent) @ \(currentLocationLabel.text!)"
            model.restart()
            updateLabelsAndButtons()
    }
}

