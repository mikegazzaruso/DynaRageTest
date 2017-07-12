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
    
    var dynaRage: AKDynaRageCompressor!
    
    //let input = AKStereoInput()

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            let mixloop = try AKAudioFile(readFileName: "houze.wav", baseDir: .resources)
        
            let player = try AKAudioPlayer(file: mixloop) {
                print("completion callback has been triggered!")
            }
            dynaRage = AKDynaRageCompressor(player)
            AudioKit.output = dynaRage
            AudioKit.start()
            player.looping = true
            player.start()    
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        setupUI()
    }

    private func setupUI() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(AKPropertySlider(
            property: "Attack Amount",
            format: "%0.2f s",
            value: self.dynaRage.attackTime, minimum: 0.1, maximum: 500.0,
            color: UIColor.green) { sliderValue in
                self.dynaRage.attackTime = sliderValue
        })
        
        stackView.addArrangedSubview(AKPropertySlider(
            property: "Release Amount",
            format: "%0.2f s",
            value: self.dynaRage.releaseTime, minimum: 0.1, maximum: 500.0,
            color: UIColor.green) { sliderValue in
                self.dynaRage.releaseTime = sliderValue
        })
        
        stackView.addArrangedSubview(AKPropertySlider(
            property: "Threshold Amount",
            format: "%0.2f s",
            value: self.dynaRage.threshold, minimum: -100.0, maximum: 0.0,
            color: UIColor.green) { sliderValue in
                self.dynaRage.threshold = sliderValue
        })
        
        stackView.addArrangedSubview(AKPropertySlider(
            property: "Ratio Amount",
            format: "%0.2f s",
            value: self.dynaRage.ratio, minimum: 0.1, maximum: 20.0,
            color: UIColor.green) { sliderValue in
                self.dynaRage.ratio = sliderValue
        })
        
        stackView.addArrangedSubview(AKPropertySlider(
            property: "Rage Amount",
            format: "%0.2f s",
            value: self.dynaRage.rageAmount, minimum: 0.1, maximum: 20.0,
            color: UIColor.green) { sliderValue in
                self.dynaRage.rageAmount = sliderValue
        })
        
        view.addSubview(stackView)
        
        stackView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.9).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}

