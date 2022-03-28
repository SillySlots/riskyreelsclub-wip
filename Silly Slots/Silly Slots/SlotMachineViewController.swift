//////
//////  SlotMachineViewController.swift
//////  Silly Slots
//////
//////  Created by Caroline Mitchem on 3/23/22.
//////
//
import UIKit
import CoreData
import Parse

//
class SlotMachineViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var slotPickerView: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var winFlag: Bool = false
    var bounds    = CGRect.zero
    var dataArray = [[Int](), [Int](), [Int](), [Int]()]
    var reelImageArray = [[PFObject](), [PFObject](), [PFObject](), [PFObject]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slotPickerView.delegate   = self
        slotPickerView.dataSource = self
        loadData()
        setupUI()
        spinSlots()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return 80.0
    }


    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 120.0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        
        let pickerLabel = UILabel()
        
        switch component {
            case 0 : pickerLabel.text = K.imageArray[(Int)(dataArray[0][row])]
            case 1 : pickerLabel.text = K.imageArray[(Int)(dataArray[1][row])]
            case 2 : pickerLabel.text = K.imageArray[(Int)(dataArray[2][row])]
            case 3 : pickerLabel.text = K.imageArray[(Int)(dataArray[3][row])]
            
            default : print("done")
        }
        
        pickerLabel.font = UIFont(name : K.emojiFont, size : 75)
        pickerLabel.textAlignment = NSTextAlignment.center
        return pickerLabel
    }
    
    func loadData() {
        for i in 0...3 {
            for _ in 0...100 {
                dataArray[i].append(Int.random(in: 0...K.imageArray.count - 1))
            }
        }
    }
    
    func setupUI() {
        bounds = spinButton.bounds
        setTrim()
        resultLabel.layer.cornerRadius  = 10
        resultLabel.layer.masksToBounds = true
        slotPickerView.layer.cornerRadius   = 10
        spinButton.layer.cornerRadius   = 40
    }
    
    func setTrim () {
        resultLabel.layer.borderColor = UIColor.label.cgColor
        slotPickerView.layer.borderColor  = UIColor.label.cgColor
        spinButton.layer.borderColor  = UIColor.label.cgColor
        
        resultLabel.layer.borderWidth = 2
        slotPickerView.layer.borderWidth  = 2
        spinButton.layer.borderWidth  = 2
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }
        setTrim()
    }
    
    func spinSlots() {
        for i in 0...3 {
            slotPickerView.selectRow(Int.random(in: 4...97), inComponent: i, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration : 0.5,
                       delay        : 0.3,
                       options      : .curveEaseOut,
                       animations   : { self.spinButton.alpha = 1 },
                       completion   : nil)
        
//        let query = PFQuery(className:"reelImage")
//        query.getObjectInBackground(withId: "55aGPEtvyQ") { (reelImage, error) in
//            if error == nil {
//                var symboli = reelImage!["photo"] as? PFObject
//            } else {
//                // Fail!
//            }
//        }
//        query.getObjectInBackground(withId: "H5LtgQW3bn") { (reelImage, error) in
//            if error == nil {
//                var symbolm = reelImage!["photo"] as? PFObject
//            } else {
//                // Fail!
//            }
//        }
//
//        query.getObjectInBackground(withId: "OqPisOBxtR") { (reelImage, error) in
//            if error == nil {
//                var symbolg = reelImage!["photo"] as? PFObject
//            } else {
//                // Fail!
//            }
//        }
//        query.getObjectInBackground(withId: "8aoDWq9unQ") { (reelImage, error) in
//            if error == nil {
//                var symbolw = reelImage!["photo"] as? PFObject
//            } else {
//                // Fail!
//            }
//        }
//        query.getObjectInBackground(withId: "l6Y7LiB7PM") { (reelImage, error) in
//            if error == nil {
//                var bananas = reelImage!["photo"] as? PFObject
//            } else {
//                // Fail!
//            }
//        }
//        query.getObjectInBackground(withId: "hRloRjGLJw") { (reelImage, error) in
//            if error == nil {
//                var rug = reelImage!["photo"] as? PFObject
//            } else {
//                // Fail!
//            }
//        }
//        query.getObjectInBackground(withId: "veedoYWByx") { (reelImage, error) in
//            if error == nil {
//                var ape = reelImage!["photo"] as? PFObject
//            } else {
//                // Fail!
//            }
//        }
        
        //reelImageArray = [ape, rug, bananas, symbolw, symboli, symbolm, symbolg]
        
    }
    
    
    func checkWinOrLose() {
        let emoji0 = slotPickerView.selectedRow(inComponent: 0)
        let emoji1 = slotPickerView.selectedRow(inComponent: 1)
        let emoji2 = slotPickerView.selectedRow(inComponent: 2)
        let emoji3 = slotPickerView.selectedRow(inComponent: 3)


        if (dataArray[0][emoji0] == dataArray[1][emoji1]
            && dataArray[1][emoji1] == dataArray[2][emoji2] && dataArray[2][emoji2] == dataArray[3][emoji3]) {
            resultLabel.text = K.win

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
    
    @IBAction func onSpin(_ sender: Any) {
            spinSlots()
            checkWinOrLose()
            animateButton()
        }
    }




    




//func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//
//    let pickerLabel = UILabel()
//
//    switch component {
//        case 0 : pickerLabel.text = K.imageArray[(Int)(dataArray[0][row])]
//        case 1 : pickerLabel.text = K.imageArray[(Int)(dataArray[1][row])]
//        case 2 : pickerLabel.text = K.imageArray[(Int)(dataArray[2][row])]
//        default : print("done")
//    }
//
//    pickerLabel.font = UIFont(name : K.emojiFont, size : 75)
//    pickerLabel.textAlignment = NSTextAlignment.center
//    return pickerLabel
//}




//
//    var bounds    = CGRect.zero
//    var dataArray = [[PFObject](), [PFObject](), [PFObject](),  [PFObject](),  [PFObject]()]
//    var winFlagbool = false
//    var reelImage = [PFObject]()
//    var selectedPost: PFObject!
//    var pickerData: [String] = [String] ()
//    var countImage: Int = 0
//   // let reelImage = PFObject(className: "reelImage")
//
////    var rug = (reelImage["rug"] as? [PFObject]) ?? []
////    var ape = (reelImage["ape"] as? [PFObject]) ?? []
////    var dollar = (reelImage["dollarsigns"] as? [PFObject]) ?? []
////    var banana = (reelImage["bananas"] as? [PFObject]) ?? []
////    var w = (reelImage["wsymbol"] as? [PFObject]) ?? []
////    var m = (reelImage["msymbol"] as? [PFObject]) ?? []
////    var g = (reelImage["isymbol"] as? [PFObject]) ?? []
////    var i = (reelImage["gsymbol"] as? [PFObject]) ?? []
////    var winSound  = SoundManager()
////    var rattle    = SoundManager()
//
////    let images = [rug, ape, dollar, banana, w, m, g, i] as! PFObject
//
//    let images = ["rug", "ape", "dollar", "banana", "chest"]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        slotPickerView.delegate   = self
//        slotPickerView.dataSource = self
////        loadData()
////        setupUIAndSound()
////        spinSlots()
//
//
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        let query = PFQuery(className:"reelImage")
//
//        // Include the post data with each comment
//        query.includeKeys(["name", "photo"])
//        // You also can initialize multiple levels of relations
//        // query.includeKey("post.author")
//        query.findObjectsInBackground { (reelImage, error) in
//          if let error = error {
//            // The request failed
//            print(error.localizedDescription)
//          } else if let reelImage = reelImage {
//            // Comments now contains the "post" field
//              for reelImage in reelImage {
//
//              let image = reelImage["name.photo"] as? PFObject
//              let name = reelImage["name"] as? PFObject
//
//              print("retrieved related image: \(String(describing: reelImage))")
//            }
//          }
//        }
//    }
//
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 6;
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
////        let image = PFObject(className: "reelImage")
////        let ape = image["ape"]
////        let rug = image["rug"]
////        let banana = image["bananas"]
////        let dollar = image["dollarsigns"]
////        let images = [rug, ape, dollar, banana] as! PFObject
//
//        return images.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return images[row]
//    }
//
////    func loadData() {
////        countImage = 6
////        for i in 0...2 {
////            for _ in 0...100 {
////                dataArray[i].append(Int.random(in: 0..countImage.imageArray.count - 1))
////            }
////        }
////    }
////
////    func setupUIAndSound() {
////        // SOUND
////
////        spinButton.alpha = 0
////
////        // UI
////        bounds = spinButton.bounds
////        setTrim()
////        resultLabel.layer.cornerRadius  = 10
////        resultLabel.layer.masksToBounds = true
////        slotPickerView.layer.cornerRadius   = 10
////        spinButton.layer.cornerRadius   = 40
////    }
////
////    func setTrim () {
////        resultLabel.layer.borderColor = UIColor.label.cgColor
////        slotPickerView.layer.borderColor  = UIColor.label.cgColor
////        spinButton.layer.borderColor  = UIColor.label.cgColor
////
////        resultLabel.layer.borderWidth = 2
////        slotPickerView.layer.borderWidth  = 2
////        spinButton.layer.borderWidth  = 2
////    }
////
////
////    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
////        super.traitCollectionDidChange(previousTraitCollection)
////        guard traitCollection.userInterfaceStyle != previousTraitCollection?.userInterfaceStyle else { return }
////        setTrim()
////    }
////
////
////    func spinSlots() {
////        for i in 0...2 {
////            slotPickerView.selectRow(Int.random(in: 3...97), inComponent: i, animated: true)
////        }
////    }
////
////    override func viewDidAppear(_ animated: Bool) {
////        super.viewDidAppear(animated)
////
////        UIView.animate(withDuration : 0.5,
////                       delay        : 0.3,
////                       options      : .curveEaseOut,
////                       animations   : { self.spinButton.alpha = 1 },
////                       completion   : nil)
////    }
////
////
////    @IBAction func onSpin(_ sender: Any) {
////
////        spinSlots()
////        checkWinOrLose()
////        animateButton()
////    }
////
////
////    func checkWinOrLose() {
////        let emoji0 = slotPickerView.selectedRow(inComponent: 0)
////        let emoji1 = slotPickerView.selectedRow(inComponent: 1)
////        let emoji2 = slotPickerView.selectedRow(inComponent: 2)
////        let emoji3 = slotPickerView.selectedRow(inComponent: 3)
////
////
////        if (dataArray[0][emoji0] == dataArray[1][emoji1]
////         && dataArray[1][emoji1] == dataArray[2][emoji2] && dataArray[2][emoji2] == dataArray[3][emoji3]) {
////            resultLabel.text = K.win
////
////        } else {
////            resultLabel.text = K.lose
////        }
////    }
////
////
////    func animateButton(){
////        // animate button
////        let shrinkSize = CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width - 15, height: bounds.size.height)
////
////        UIView.animate(withDuration: 0.5,
////                       delay: 0.0,
////                       usingSpringWithDamping: 0.1,
////                       initialSpringVelocity: 5,
////                       options: .curveLinear,
////                       animations: { self.spinButton.bounds = shrinkSize },
////                       completion: nil )
////    }
////} // end of View Controller
////
////
////// MARK:UIslotPickerViewDataSource
////extension ViewController : UIPickerViewDelegate {
////
////    func slotPickerView(_ slotPickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
////        return 100
////    }
////
////    func numberOfComponents(in slotPickerView: UIPickerView) -> Int {
////        return 4
////    }
////}
////
////// MARK:UIslotPickerViewDelegate
////extension ViewController: UIPickerViewDataSource {
////
////
////    func slotPickerView(_ slotPickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
////        return 83.5
////    }
////
////
////    func slotPickerView(_ slotPickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
////        return 120.0
////    }
////
////
////    func slotPickerView(_ slotPickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
////
////        let pickerLabel = UILabel()
////
////        switch component {
////            case 0 : pickerLabel.text = K.imageArray[(Int)(dataArray[0][row])]
////            case 1 : pickerLabel.text = K.imageArray[(Int)(dataArray[1][row])]
////            case 2 : pickerLabel.text = K.imageArray[(Int)(dataArray[2][row])]
////            case 3 : pickerLabel.text = K.imageArray[(Int)(dataArray[3][row])]
////            default : print("done")
////        }
////
////        pickerLabel.font          = UIFont(name : K.emojiFont, size : 75)
////        pickerLabel.textAlignment = NSTextAlignment.center
////        return pickerLabel
////    }
//
//}
