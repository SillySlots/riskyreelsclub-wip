//
//  SlotMachineViewController.swift
//  Silly Slots
//
//  Created by Caroline Mitchem on 3/23/22.
//

import UIKit


class SlotMachineViewController: UIViewController {

    var winFlagbool = false
    
    @IBOutlet weak var spinButton: UIButton!
    
    @IBOutlet weak var slotPickerView: UIPickerView!
    
    @IBOutlet weak var resultLabel: UILabel!
 
    var bounds    = CGRect.zero
    var dataArray = [[Int](), [Int](), [Int]()]
    var winSound  = SoundManager()
    var rattle    = SoundManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate   = self
        pickerView.dataSource = self
        loadData()
        setupUIAndSound()
        spinSlots()
    }
    
    
    func loadData() {
        for i in 0...2 {
            for _ in 0...100 {
                dataArray[i].append(Int.random(in: 0...K.imageArray.count - 1))
            }
        }
    }
    
    func setupUIAndSound() {
        // SOUND
        winSound.setupPlayer(soundName: K.sound, soundType: SoundType.m4a)
        rattle.setupPlayer(soundName: K.rattle, soundType: .m4a)
        winSound.volume(1.0)
        rattle.volume(0.1)
        spinButton.alpha = 0
        
        // UI
        bounds = spinButton.bounds
        setTrim()
        resultLabel.layer.cornerRadius  = 10
        resultLabel.layer.masksToBounds = true
        pickerView.layer.cornerRadius   = 10
        spinButton.layer.cornerRadius   = 40
    }
    
    func setTrim () {
        resultLabel.layer.borderColor = UIColor.label.cgColor
        pickerView.layer.borderColor  = UIColor.label.cgColor
        spinButton.layer.borderColor  = UIColor.label.cgColor
        
        resultLabel.layer.borderWidth = 2
        pickerView.layer.borderWidth  = 2
        spinButton.layer.borderWidth  = 2
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }
        setTrim()
    }
    
    
    func spinSlots() {
        for i in 0...2 {
            pickerView.selectRow(Int.random(in: 3...97), inComponent: i, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration : 0.5,
                       delay        : 0.3,
                       options      : .curveEaseOut,
                       animations   : { self.spinButton.alpha = 1 },
                       completion   : nil)
    }

    
    @IBAction func onSpin(_ sender: Any) {
        winSound.pause()
        rattle.play()
        spinSlots()
        checkWinOrLose()
        animateButton()
    }
    
   
    func checkWinOrLose() {
        let emoji0 = pickerView.selectedRow(inComponent: 0)
        let emoji1 = pickerView.selectedRow(inComponent: 1)
        let emoji2 = pickerView.selectedRow(inComponent: 2)
        let emoji3 = pickerView.selectedRow(inComponent: 3)
        

        if (dataArray[0][emoji0] == dataArray[1][emoji1]
         && dataArray[1][emoji1] == dataArray[2][emoji2] && dataArray[2][emoji2] == dataArray[3][emoji3]) {
            resultLabel.text = K.win
            winSound.play()
        } else {
            resultLabel.text = K.lose
        }
    }

    
    func animateButton(){
        // animate button
        let shrinkSize = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width - 15, height: bounds.size.height)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       usingSpringWithDamping: 0.1,
                       initialSpringVelocity: 5,
                       options: .curveLinear,
                       animations: { self.spinButton.bounds = shrinkSize },
                       completion: nil )
    }
} // end of View Controller


// MARK:UIPickerViewDataSource
extension ViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
}

// MARK:UIPickerViewDelegate
extension ViewController: UIPickerViewDataSource {
    
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 83.5
    }
    
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 120.0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let pickerLabel = UILabel()
        
        switch component {
            case 0 : pickerLabel.text = K.imageArray[(Int)(dataArray[0][row])]
            case 1 : pickerLabel.text = K.imageArray[(Int)(dataArray[1][row])]
            case 2 : pickerLabel.text = K.imageArray[(Int)(dataArray[2][row])]
            case 3 : pickerLabel.text = K.imageArray[(Int)(dataArray[3][row])]
            default : print("done")
        }
        
        pickerLabel.font          = UIFont(name : K.emojiFont, size : 75)
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }

}
