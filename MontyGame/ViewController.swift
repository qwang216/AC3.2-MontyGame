//
//  NCardMontyViewController2.swift
//  ThreeCardMonty
//
//  Created by Annie Tung on 9/14/16.
//  Copyright © 2016 Annie Tung. All rights reserved.
//


/*
 Bugs

 */


import UIKit

class ViewController: UIViewController {
    var label = UILabel()
    let titles = ["A", "B", "C", "D", "E"]
    let resetGameName = "Reset Game"

    // change amount of cards to titles array count
    var gameEngine: MontyEngine?
    //    let gameEngine = MontyEngine(amountOfCards: 3)


    override func viewDidLoad() {
        super.viewDidLoad()
        gameEngine = MontyEngine(amountOfCards: titles.count)
        gameEngine?.setupCards()
        setupLabel()
        setupResetButton()
        for (index, title) in titles.enumerate() {
            setupButton(title, tag: index)
        }
    }

    func setupResetButton() {
        // we want to use constrain for reset button
        let resetButton = UIButton(type: .System)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        // set the title of the button and the color
        resetButton.setTitle(resetGameName, forState: .Normal)
        resetButton.setTitleColor(.whiteColor(), forState: .Normal)
        resetButton.backgroundColor = .redColor()
        // adding target to button
        resetButton.addTarget(self, action: #selector(handleResetButton), forControlEvents: UIControlEvents.TouchUpInside)
        // add the button to the View
        view.addSubview(resetButton)

        // x,y,w,h
        resetButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true
        resetButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -50).active = true
        resetButton.widthAnchor.constraintEqualToConstant(120).active = true
        resetButton.heightAnchor.constraintEqualToConstant(60).active = true
    }

    func handleResetButton() {
        resetAllButtonColor()
    }

    func setupButton(title: String, tag: Int) {
        let xValue = tag * 75
        let frame = CGRect(x: xValue + 20, y: 75, width: 65, height: 60)
        let button = UIButton(frame: frame)
        button.backgroundColor = UIColor.lightGrayColor()
        button.setTitle(title, forState: .Normal)
        button.tag = tag
        button.addTarget(self, action: #selector(handleButtonTapped), forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }

    func handleButtonTapped(button: UIButton) {
        guard let didWin = gameEngine?.checkCard(button.tag) else { return }
        if didWin {
            label.text = "WINNER"
            button.backgroundColor = UIColor.greenColor()
            // i want to disable buttons if we won the game
            // BUT i don't want to disable the RESET button
            disableCardButtons()
        } else {
            label.text = "Try Again"
            button.backgroundColor = UIColor.redColor()
        }
    }

    func disableCardButtons() {
        for v in view.subviews {
            if let button = v as? UIButton {
                if button.currentTitle != resetGameName {
                    button.enabled = false
                }
            }
        }
    }

    func resetAllButtonColor() {
        // reset cards in the game engine
        gameEngine?.setupCards()
        // reset buttons to lightGrayColor
        for v in view.subviews {
            // only grab the view if it's a button
            if let button = v as? UIButton {
                // check the title of the button
                if button.currentTitle != resetGameName {
                    button.backgroundColor = UIColor.lightGrayColor()
                    button.enabled = true
                    label.text = "Let's Play"
                }
            }
        }
    }

    func setupLabel() {
        // setting the title
        label.text = "Let's Play"
        view.addSubview(label)

        // add constrain after adding the label as the subview of the VIEW
        // ALWAYS SET translatesAutoresizingMaskIntoConstraints TO FALSE!!!!!!
        label.translatesAutoresizingMaskIntoConstraints = false
        // ALWAYS REMEMBER TO SET THE CONSTRAIN ACTIVE TO TRUE!!!!!
        label.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 40).active = true
        label.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor).active = true

    }
    
    
}








