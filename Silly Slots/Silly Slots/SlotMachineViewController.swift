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
import web3swift

//
class SlotMachineViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var slotPickerView: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    
    var winFlag: Bool = false
    var bounds    = CGRect.zero
    var dataArray = [[Int](), [Int](), [Int](), [Int]()]
    var reelImageArray = [[PFObject](), [PFObject](), [PFObject](), [PFObject](), [PFObject](), [PFObject]()]
    var randomSet = [[String:String](), [String:String](), [String:String](),
        [String:String](),[String:String](), [String:String]()]
    
    let size = CGSize(width: 5, height: 5)
    
    var dollarsign = UIImage(named: "dollarSign.png")!
    //dollarsign =  resizeImage(image: dollarsign, targetSize: size)!
    var wpng = UIImage(named: "w.png")!
   // wpng = resizeImage(image: wpng, targetSize: size)!
    var gpng = UIImage(named: "g.png")!
   // gpng = resizeImage(image: gpng, targetSize: size)!
    var ipng = UIImage(named: "i.png")!
    //ipng = resizeImage(image: ipng, targetSize: size)!
    var ape = UIImage(named: "ape.png")!
    //ape =  resizeImage(image: ape, targetSize: size)!
    var rug = UIImage(named: "rug.png")!
   // rug = resizeImage(image: rug, targetSize: size)!
    var diamond = UIImage(named: "diamond.png")!
    //diamond = resizeImage(image: diamond, targetSize: size)!
    var banana = UIImage(named: "banana.png")!
   // banana = resizeImage(image: banana, targetSize: size)!
    var treasure = UIImage(named: "treasure.png")!
    //treasure = resizeImage(image: treasure, targetSize: size)!
    
    
    var imageArray2: [UIImage] = [
          UIImage(named: "dollarSign.png")!,
          UIImage(named: "g.png")!,
          UIImage(named: "i.png")!,
          UIImage(named: "w.png")!

      ]
    
    var imageView = UIImageView()
    
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
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        
        randomSet = [["myImage":"ape"], ["myImage":"banana"], ["myImage":"rug"], ["myImage":"diamond"], ["myImage":"treasure"],["myImage":"dollarsign"]]

        func randomiseSet () -> UIImage{
            let randomNumber:Int = Int(arc4random_uniform(5))
            var image = UIImage(named: randomSet[randomNumber]["myImage"]!)!
            let size = CGSize(width: 80, height: 80)
            image = resizeImage(image: image, targetSize: size)!
           return image
        }

        
        
        switch component {
            case 0 : imageView = //pickerLabel.text = 
           // UIImageView(image: dollarsign)
            UIImageView(image: randomiseSet())
            //imagesArray1[(Int)(dataArray[1][row])]
          //  K.imageArray[(Int)(dataArray[0][row])]
               // imageArray2[(Int)(dataArray[0][row])]
          // myImageView =  UIImageView(image: UIImage(named: "dollarSign.png"))
           
            
            
            case 1 :  imageView = //pickerLabel.text =
            UIImageView(image: randomiseSet())
            //UIImageView(image: wpng)
            
            //K.imageArray[(Int)(dataArray[1][row])]
           // imageArray2[(Int)(dataArray[1][row])]
            
            case 2 : imageView = // pickerLabel.text =
            UIImageView(image: randomiseSet())
            //UIImageView(image: gpng)
            //K.imageArray[(Int)(dataArray[2][row])]
           // imageArray2[(Int)(dataArray[2][row])]
            case 3 : imageView = //pickerLabel.text =
            UIImageView(image: randomiseSet())
            //UIImageView(image: ipng)
            //K.imageArray[(Int)(dataArray[3][row])]
            //imageArray2[(Int)(dataArray[3][row])]
            
            default : print("done")
        }
      // let rect =  CGRect.init(x: 0, y: 0, width: 20, height: 22)
       // imageView.frame(forAlignmentRect: rect)
        return imageView
//        pickerLabel.font = UIFont(name : K.emojiFont, size : 75)
//        pickerLabel.textAlignment = NSTextAlignment.center
        //return pickerLabel
    }
    
    func loadData() {
        for i in 0...3 {
            for _ in 0...100 {
              // dataArray[i].append(Int.random(in: 0...K.imageArray.count - 1))
                dataArray[i].append(Int.random(in: 0...randomSet.count - 1))
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
        
        UIView.animate(withDuration : 0.00,
                       delay        : 0.00,
                       options      : .curveEaseOut,
                       animations   : { self.spinButton.alpha = 1 },
                       completion   : nil)
    }
    
    
    func checkWinOrLose() {
//        let image0 = slotPickerView.selectedRow(inComponent: 0)
//        let image1 = slotPickerView.selectedRow(inComponent: 1)
//        let image2 = slotPickerView.selectedRow(inComponent: 2)
//        let image3 = slotPickerView.selectedRow(inComponent: 3)

//        let image0 = UIImage.init(imageLiteralResourceName: "ape.png")
//        let image1 = UIImage.init(imageLiteralResourceName: "banana.png")
//        let image2 = UIImage.init(imageLiteralResourceName: "diamond.png")
//        let image3 = UIImage.init(imageLiteralResourceName: "rug.png")
//        let image4 = UIImage.init(imageLiteralResourceName: "dollarsigns.png")
//        let image5 = UIImage.init(imageLiteralResourceName: "treasure.png")

//        let comp0 = UIImage.itemProviderVisibilityForRepresentation(withTypeIdentifier: <#T##String#>) slotPickerView.selectedRow(inComponent: 0)
        //let comp = UIImage.imageAss
        let comp0 = slotPickerView.view(forRow: 0, forComponent: 0) as? UIImageView
        
        let comp1 = slotPickerView.view(forRow: 0, forComponent: 0) as? UIImageView
        
        let comp2 = slotPickerView.view(forRow: 0, forComponent: 0) as? UIImageView
        
        let comp3 = slotPickerView.view(forRow: 0, forComponent: 0) as? UIImageView
       
        if (comp0?.description == comp1?.description && comp1?.description == comp2?.description && comp2?.description == comp3?.description){
            resultLabel.text = "W I N N E R !"
        }
        else if(comp0?.description == comp1?.description || comp1?.description == comp2?.description || comp2?.description == comp3?.description){
            resultLabel.text = "MONEY BACK"

        }
        
        else {
        resultLabel.text = "RISKY REELS CLUB"
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
        
        let web3 = Web3.InfuraRinkebyWeb3()
       // web3.addKeystoreManager(keystoreManager)
        
        
        
        //insert pop up here
            spinSlots()
            checkWinOrLose()
            animateButton()
        }
    }

