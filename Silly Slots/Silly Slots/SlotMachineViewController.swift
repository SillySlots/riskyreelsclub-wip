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
    let defaults = UserDefaults.standard
    
    var winFlag: Bool = false
    var bounds    = CGRect.zero
    var dataArray = [[Int](), [Int](), [Int](), [Int]()]
    var reelImageArray = [[PFObject](), [PFObject](), [PFObject](), [PFObject](), [PFObject](), [PFObject]()]
    var randomSet = [[String:String](), [String:String](), [String:String](),
        [String:String](),[String:String](), [String:String]()]
    var componentsFromRow = [UIImage(),UIImage(),UIImage(),UIImage()]
    
    var stringArray = [String(), String(), String(), String()]
    
    let size = CGSize(width: 5, height: 5)
    //var verbose = Bool()
    var verbose = false
    var time = true
    
    
    struct Wallet {
        let address: String
        let data: Data
        let name: String
        let isHD: Bool
    }
    struct ImportantVals {
        static var privKey = String()
    }
    
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
    
    var betConfirm = false
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
        disclaimer()
        loadData()
        setupUI()
        spinSlots()
        
        print(" BET CONFIRMED STATUS \(defaults.bool(forKey: "betConfirmed"))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaults.synchronize()
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
        var i = 0
        func randomiseSet (validate: Bool) -> UIImage{
            let randomNumber:Int = Int(arc4random_uniform(5))
            //print("about to print")
            //print("\(randomSet[randomNumber]["myImage"]!)")
            
            var image = UIImage(named: randomSet[randomNumber]["myImage"]!)!
            let size = CGSize(width: 80, height: 80)
            image = resizeImage(image: image, targetSize: size)!
            
            if(validate) {
//                stringArray[0] = randomSet[randomNumber]["my Image"]!
                if(i < stringArray.count ) {
                let appendString = (randomSet[randomNumber]["myImage"]!)
                //print(appendString)
                
                stringArray[i] = appendString
                //print(stringArray.count)
                i = i + 1
                }
            }
            
           return image
        }
        

        
        
        switch component {
            case 0:
            //verbose = true
            let image =  randomiseSet(validate: true)
           imageView = UIImageView(image: image)
            componentsFromRow[0] = image
            
            
            
            //imagesArray1[(Int)(dataArray[1][row])]
          //  K.imageArray[(Int)(dataArray[0][row])]
               // imageArray2[(Int)(dataArray[0][row])]
          // myImageView =  UIImageView(image: UIImage(named: "dollarSign.png"))
           
            
            
            case 1 :
            
            //verbose = true
            let image =  randomiseSet(validate: true)
           imageView = UIImageView(image: image)
            componentsFromRow[1] = image
            
            case 2 :
            //verbose = true
            let image =  randomiseSet(validate: true)
           imageView = UIImageView(image: image)
            componentsFromRow[2] = image
            case 3 :
           // verbose = true
            let image =  randomiseSet(validate: true)
           imageView = UIImageView(image: image)
            componentsFromRow[3] = image
            
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
       // let row0=slotPickerView.selectedRow(inComponent: 0)
       // let comp0 = slotPickerView.view(forRow: row0, forComponent: 0) as? UIImageView
        
        let comp0 = stringArray[0]
        let comp1 = stringArray[1]
        let comp2 = stringArray[2]
        let comp3 = stringArray[3]
        
        
        print("\(comp0)")
        print("\(comp1)")
        print("\(comp2)")
        print("\(comp3)")
        //var image0 = comp0?.image
       // image0?.cgImage
        
       // let row1=slotPickerView.selectedRow(inComponent: 1)
        //let comp1 = slotPickerView.view(forRow: row1, forComponent: 1) as? UIImageView
        //var image1 = comp1?.image
        //image1?.cgImage
        
       // let row2=slotPickerView.selectedRow(inComponent: 2)
       // let comp2 = slotPickerView.view(forRow: row2, forComponent: 2) as? UIImageView
       // var image2 = comp2?.image
        //image2?.cgImage
        
       // let row3=slotPickerView.selectedRow(inComponent: 3)
        //let comp3 = slotPickerView.view(forRow: row3, forComponent: 3) as? UIImageView
        //var image3 = comp3?.image
        
        //print(slotPickerView.numberOfComponents)
        
        //image3?.cgImage
        
        //print(" comp0  \(comp0) comp 1  \(comp1)")
        
        //pickerView(slotPickerView, didSelectRow: 0, inComponent: 0)

       
        if (comp0.isEqual(comp1) && comp1.isEqual(comp2) && comp2.isEqual(comp3)){
            print("they are the same")
            resultLabel.text = "W I N N E R !"
            defaults.set(false, forKey: "betConfirmed")
            defaults.synchronize()
        }
        else if(comp0.isEqual(comp1) || comp1.isEqual(comp2) || comp2.isEqual(comp3)){
            print("they are different")
            resultLabel.text = "L O S E R !"
//            defaults.set(true, forKey: "betConfirmed")
//            defaults.synchronize()
        }
        
//        if (image0?.cgImage ==  image1?.cgImage &&  image1?.cgImage == image2?.cgImage && image2?.cgImage == image3?.cgImage){
//            resultLabel.text = "W I N N E R !"
//        }
//        else if(image0?.description == image1?.description || image1?.description == image2?.description || image2?.description == image3?.description){
//            resultLabel.text = "MONEY BACK"
//
//        }
        
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
    var count = 0
    
    
    func disclaimer() {
        self.performSegue(withIdentifier: "disclaimerSegue", sender: nil)
        
    }
    
    @IBAction func onSpin(_ sender: Any) {
        //var time = true
        //verbose = true
        
        let password = SlotPopUpViewController.Verbose.password
        
        print(password)
        let completedTranscation = initializeTranscation()
        
        if(completedTranscation == true) {
        spinSlots()
        checkWinOrLose()
        animateButton()
        }
       // web3.addKeystoreManager(keystoreManager)
        
//        print(count)
//        if(count == 0) {
        
//        if (defaults.integer(forKey: "countBet") == 0){
//            print("\(defaults.integer(forKey: "countBet"))")
//            
//            self.performSegue(withIdentifier: "disclaimerSegue", sender: nil)
//        }
//        else {
//            spinSlots()
//            checkWinOrLose()
//            animateButton()
//        }
//        if !(defaults.bool(forKey: "betConfirmed")){
//            print("\(defaults.bool(forKey: "betConfirmed"))")
//        self.performSegue(withIdentifier: "disclaimerSegue", sender: nil)
//          //  let confirmation =  SlotPopUpViewController().confirmBool
//
//
//            //print(confirmation)
//        }
//        else if (defaults.bool(forKey: "betConfirmed")) {
//
//            print("\(defaults.bool(forKey: "betConfirmed"))")
//            //count = count + 1
//            spinSlots()
//            checkWinOrLose()
//            animateButton()
//        }
            //time = false
        
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        {
            let location = randomSet[row]
            print(location)
            
            

        }
    
    
    func initializeTranscation() -> Bool{
        let password = SlotPopUpViewController.Verbose.password
        
        print(password)
        
        
        
        let wallet = Wallet(address: WalletViewController.Information.address2, data: WalletViewController.Information.data2, name: WalletViewController.Information.name2, isHD: false)
        
        let data = wallet.data
        let keystoreManager: KeystoreManager
        if wallet.isHD {
            let keystore = BIP32Keystore(data)!
            keystoreManager = KeystoreManager([keystore])
        } else {
            let keystore = EthereumKeystoreV3(data)!
            keystoreManager = KeystoreManager([keystore])
        }
        
        
        let web3 = Web3.InfuraRinkebyWeb3()
        
        web3.addKeystoreManager(keystoreManager)
        
        
        let value: String = "1.0" // In Ether
        let walletAddress = EthereumAddress(wallet.address)! // Your wallet address
        //sends the money to our public address
        let toAddress = EthereumAddress("0x4540c5722522f258f101eEd4CC087E80E1Ae9D7e")!
        let contract = web3.contract(Web3.Utils.coldWalletABI, at: toAddress, abiVersion: 2)!
        let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
        var options = TransactionOptions.defaultOptions
        //options.value = amount
        options.from = walletAddress
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.write(
            "fallback",
            parameters: [AnyObject](),
            extraData: Data(),
            transactionOptions: options)!
        
        //send transacation
        //let password = "web3swift"
        
        //let result = try! transaction.call()
        
        
        
        let result = try! tx.send(password: password) throws
        //let result2 = try! transaction.call()
        print(result)
        
        
        
        //contract.
        
//        let ethereumAddress = EthereumAddress(wallet.address)!
//        let pkData = try! keystoreManager.UNSAFE_getPrivateKeyData(password: password, account: ethereumAddress).toHexString()
//        ImportantVals.privKey = pkData
        
        return true
        
        
        
        
        //let password = passwordField.text!
       // return true
    }
    
    

    }

