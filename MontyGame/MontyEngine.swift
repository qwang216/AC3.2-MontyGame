import Foundation
import UIKit

class MontyEngine {
    enum State  {
        case Hit
        case Miss
    }

    private var cards = [State]()
    //    var cards = Array(count: 5, repeatedValue: State.Miss)

    private let numCards: Int
    //create an intializer
    init(amountOfCards: Int) {
        self.numCards = amountOfCards
        setupCards()
    }

    func setupCards(){
        cards = Array(count: numCards, repeatedValue: State.Miss)
        cards[Int(arc4random_uniform(UInt32(numCards)))] = .Hit
    }

    func checkCard (index: Int) -> Bool {
        assert (index < cards.count) //make sure index is smaller than the counter of cards. It will only run if it's true, if it's false we want the program to crash!
        return cards[index] == .Hit //we know that it's a part of State
    }

    subscript(i: Int) -> State { //gets the raw value of the state
        get {
            return cards[i] //allowing us access var engine with a subscript operator to get one of the States.
        }
    }

    //resetting button state to change color
    func resetButtonState(buttonA: UIButton, buttonB: UIButton, buttonC: UIButton, buttonD: UIButton, buttonE: UIButton) {
        buttonA.backgroundColor = .lightGrayColor()
        buttonB.backgroundColor = .lightGrayColor()
        buttonC.backgroundColor = .lightGrayColor()
        buttonD.backgroundColor = .lightGrayColor()
        buttonE.backgroundColor = .lightGrayColor()
    }
}