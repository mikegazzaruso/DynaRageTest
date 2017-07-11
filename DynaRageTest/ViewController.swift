//
//  ViewController.swift
//  DynaRageTest
//
//  Created by Mike Gazzaruso on 11/07/17.
//  Copyright © 2017 Devoloop Srls. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController {
    
    var rageProcessor: AKDynaRageCompressor!
    
    let input = AKStereoInput()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        rageProcessor = AKDynaRageCompressor(input)
        AudioKit.output = rageProcessor
        
        AudioKit.start()
        
        setupUI()
    }

    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(AKPropertySlider(
            property: "Rage Amount",
            format: "%0.2f s",
            value: self.rageProcessor.rageAmount, minimum: 0.1, maximum: 20.0,
            color: UIColor.green) { sliderValue in
                self.rageProcessor.rageAmount = sliderValue
        })
        
        view.addSubview(stackView)
        
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.9).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}

