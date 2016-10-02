//
//  ViewController.swift
//  Bazinga
//
//  Created by Justyna Rafalska on 23.09.2016.
//  Copyright © 2016 jrafa. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    private var sound: AVAudioPlayer = AVAudioPlayer()
   
    private let screenSize: CGRect = UIScreen.main.bounds
    private let buttonWidth: Double = 100.0
    private let buttonHeight: Double = 30.0
    private let delta: Double = 50.0
    private let ratio: Double = 0.75

    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .center
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        
        return sv
    }()
    
    private let buttonBazinga: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.setTitle("Bazinga", for: .normal)

        return button
    }()
    
    private let imageBazinga: UIImageView = {
        let myImage = UIImageView()
        myImage.image = UIImage(named: "bazinga.jpg")
       
        return myImage
    }()
    
    private func getXY(lengthScreen: Double, lengthComponent: Double) -> Double {
        if lengthScreen >= lengthComponent {
            return (lengthScreen - lengthComponent) / 2.0
        }

        return 0
    }
    
    private func prepareSoundBazinga() {
        if let soundPath = Bundle.main.path(forResource: "bazinga", ofType: "mp3") {
            do {
                sound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: soundPath))
            } catch {
                print("Ups, problem with file :(")
            }

            sound.prepareToPlay()

        } else {
          print("Audio file not found!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = UIView()
        self.view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(stackView)

        let screenWidth: Double = Double(self.screenSize.width)
        let screenHeight: Double = Double(self.screenSize.height)
        let imageWidthHeight: Double = screenWidth * self.ratio
        
        buttonBazinga.frame = CGRect(
            x: self.getXY(lengthScreen: screenWidth, lengthComponent: self.buttonWidth),
            y: self.getXY(lengthScreen: screenHeight, lengthComponent: self.buttonHeight) + self.delta,
            width: self.buttonWidth,
            height: self.buttonHeight
        )
        
        buttonBazinga.addTarget(self, action: #selector(self.displayBazinga), for: .touchUpInside)

        self.view.addSubview(buttonBazinga)

        imageBazinga.frame = CGRect(
            x: self.getXY(lengthScreen: screenWidth, lengthComponent: imageWidthHeight),
            y: self.delta,
            width: imageWidthHeight,
            height: imageWidthHeight
        )
        
    }
    
    func displayBazinga(sender: AnyObject) {
        self.view.willRemoveSubview(imageBazinga)
        self.view.addSubview(imageBazinga)
        self.prepareSoundBazinga()
        self.sound.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

