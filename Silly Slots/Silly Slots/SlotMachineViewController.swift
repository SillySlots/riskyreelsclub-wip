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
    
    enum TransactionErrors : Error {
        case insufficientFunds
    }
    

    struct ImportantVals {
        static var privKey = String()
        static var ourPrivKey = String()
        static var ourPass = String()
        static var ourWallet = Wallet()
    }
    
    
    
    var dollarsign = UIImage(imageLiteralResourceName: "dollarSign")
//    var wpng = UIImage(named: "w.png")!
//    var gpng = UIImage(named: "g.png")!
//    var ipng = UIImage(named: "i.png")!
    var ape = UIImage(imageLiteralResourceName: "ape")
    var rug = UIImage(imageLiteralResourceName: "rug")
    var diamond = UIImage(imageLiteralResourceName: "diamond")
    var banana = UIImage(imageLiteralResourceName: "banana")
    var treasure = UIImage(imageLiteralResourceName: "treasure")
    
    var betConfirm = false
    var imageArray2: [UIImage] = [
          UIImage(named: "dollarSign.png")!,
          UIImage(named: "g.png")!,
          UIImage(named: "i.png")!,
          UIImage(named: "w.png")!

      ]
    
    var randomImages = [UIImage(), UIImage(), UIImage(), UIImage(), UIImage(), UIImage()]
    
    var imageView = UIImageView()
    var pickedImages = Array<UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        slotPickerView.delegate   = self
        slotPickerView.dataSource = self
       // displayAlert()
        disclaimer()
        loadData()
        setupUI()
        spinSlots()
        defaults.set("0.1", forKey: "bettingAmount")
        defaults.synchronize()
        
        print(" BET CONFIRMED STATUS \(defaults.bool(forKey: "betConfirmed"))")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaults.synchronize()
    }
    

        func displayAlert (){
            let dialogMessage = UIAlertController(title: "Attention", message: "Insufficient funds to play.", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                        print("Ok button tapped")
                        self.deleteRecord()
                    })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
        
        func deleteRecord()
            {
                print("Delete record function called")
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
    
    static func createLocalUrl(forImageNamed name: String) -> URL? {

            let fileManager = FileManager.default
            let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)[0]
            let url = cacheDirectory.appendingPathComponent("\(name).png")

            guard fileManager.fileExists(atPath: url.path) else {
                guard
                    let image = UIImage(named: name),
                    let data = image.pngData()
                else { return nil }

                fileManager.createFile(atPath: url.path, contents: data, attributes: nil)
                return url
            }

            return url
        print("\(url)")
        }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView{
        
        randomImages = [ape, banana, diamond, rug, treasure, dollarsign]
        
        
        
        randomSet = [["myImage":"ape"], ["myImage":"banana"], ["myImage":"rug"], ["myImage":"diamond"], ["myImage":"treasure"],["myImage":"dollarsign"]]
        //print ("\(randomSet)")
        
        var i = 0
        func randomiseSet (validate: Bool) -> UIImage{
            let randomNumber:Int = Int(arc4random_uniform(5))
            //print("about to print")
            //print("\(randomSet[randomNumber]["myImage"]!)")
            
            let randomName = randomSet[randomNumber]["myImage"]!
            var image = UIImage(named: randomName)!
            let size = CGSize(width: 80, height: 80)
            image = resizeImage(image: image, targetSize: size)!
            
            //print("\(SlotMachineViewController.createLocalUrl(forImageNamed: randomName))")
            
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
//        let image = randomImages.randomElement();
//            let size = CGSize(width: 80, height: 80)
//            image = resizeImage(image: image ?? UIImage(imageLiteralResourceName: "defaultImage"), targetSize: size)!
            
            let image = randomiseSet(validate: true)
           imageView = UIImageView(image: image)
//            componentsFromRow[0] = image ?? UIImage(imageLiteralResourceName: "defaultImage")
//            pickedImages.append(image ?? UIImage(imageLiteralResourceName: "defaultImage"))
           // print("\(image)")
            
            case 1 :
            
            //verbose = true
            let image =  randomiseSet(validate: true)
//            var image = randomImages.randomElement();
//            let size = CGSize(width: 80, height: 80)
//            image = resizeImage(image: image ?? UIImage(imageLiteralResourceName: "defaultImage"), targetSize: size)!
           imageView = UIImageView(image: image)
//            componentsFromRow[1] = image ?? UIImage(imageLiteralResourceName: "defaultImage")
//            pickedImages.append(image ?? UIImage(imageLiteralResourceName: "defaultImage"))
            //print("\(image)")
            
            case 2 :
            //verbose = true
            let image =  randomiseSet(validate: true)
//            var image = randomImages.randomElement();
//            let size = CGSize(width: 80, height: 80)
//            image = resizeImage(image: image ?? UIImage(imageLiteralResourceName: "defaultImage"), targetSize: size)!
           imageView = UIImageView(image: image)
//            componentsFromRow[2] = image ?? UIImage(imageLiteralResourceName: "defaultImage")
//            pickedImages.append(image ?? UIImage(imageLiteralResourceName: "defaultImage"))
            //print("\(image)")
            
            case 3 :
           // verbose = true
           let image =  randomiseSet(validate: true)
//            var image = randomImages.randomElement();
//            let size = CGSize(width: 80, height: 80)
//            image = resizeImage(image: image ?? UIImage(imageLiteralResourceName: "defaultImage"), targetSize: size)!
           imageView = UIImageView(image: image)
//            componentsFromRow[3] = image ?? UIImage(imageLiteralResourceName: "defaultImage")
//            pickedImages.append(image ?? UIImage(imageLiteralResourceName: "defaultImage"))
            //print("\(image)")
            
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
    
    
    @IBAction func onConfigureBet(_ sender: Any) {
        
        self.performSegue(withIdentifier: "disclaimerSegue", sender: nil)
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

        let comp0 = stringArray[0]
        let comp1 = stringArray[1]
        let comp2 = stringArray[2]
        let comp3 = stringArray[3]
        
        
//        print("\(comp0)")
//        print("\(comp1)")
//        print("\(comp2)")
//        print("\(comp3)")
       
       
//        if (pickedImages.popFirst() == randomIm ){
//
//        }
       
        if (comp0.isEqual(comp1) && comp1.isEqual(comp2) && comp2.isEqual(comp3)){
            print("they are the same")
            resultLabel.text = "W I N N E R !"
            defaults.set(false, forKey: "betConfirmed")
            defaults.synchronize()
            
            let winnerTran = winnerTransaction()
            
            
        }
        else if(comp0.isEqual(comp1) || comp1.isEqual(comp2) || comp2.isEqual(comp3)){
            print("they are different")
            resultLabel.text = "L O S E R !"

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
    var count = 0
    
    
    func disclaimer() {
        self.performSegue(withIdentifier: "disclaimerSegue", sender: nil)
        
    }
    
    @IBAction func onSpin(_ sender: Any) {
        //var time = true
        //verbose = true
        
        let password = SlotPopUpViewController.Verbose.password
        
       // print(password)
        let completedTranscation = initializeTranscation()
        //let completedTranscation = true
        if(completedTranscation == true) {
        spinSlots()
        checkWinOrLose()
        animateButton()
        }
        
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
        {
            let location = randomSet[row]
            print(location)
            
            

        }
    
    
    
    
   
    func initializeOurWallet() {
        let query = PFQuery(className:"info")
        query.getObjectInBackground(withId: "fCmNgfzEQd") { (info, error) in
                    if error == nil {
                        
                        let pass = info!["password"] as? String
                        let privkey = info!["privAd"] as? String
                        
                        ImportantVals.ourPrivKey = privkey!
                        ImportantVals.ourPass = pass!
                    } else {
                        print("it failed")
                    }
                }
   

        
        let password = ImportantVals.ourPass
        let key = ImportantVals.ourPrivKey
        // or use the the non-blocking method findObjectsInBackground

        query.findObjectsInBackground { (results: [PFObject]?, error: Error?) in
          // do some stuff with results
        }
        let formattedKey = key.trimmingCharacters(in: .whitespacesAndNewlines)
        let dataKey = Data.fromHex(formattedKey)!
        let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password)!
        let name = "New Wallet"
        let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
        let address = keystore.addresses!.first!.address
        let wallet = Wallet(address: address, data: keyData, name: name, isHD: false)
        
        
        ImportantVals.ourWallet = wallet
        
        
        let data = wallet.data
        let keystoreManager: KeystoreManager
        if wallet.isHD {
            let keystore = BIP32Keystore(data)!
            keystoreManager = KeystoreManager([keystore])
        } else {
            let keystore = EthereumKeystoreV3(data)!
            keystoreManager = KeystoreManager([keystore])
        }
        
        
        
    }
    func initializeTranscation() -> Bool{
        initializeOurWallet()
        let password = SlotPopUpViewController.Verbose.password
        
       // print(password)
        
        
        
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
        
        
        let web3 = Web3.InfuraMainnetWeb3()
        
        web3.addKeystoreManager(keystoreManager)
        
        let value = SlotPopUpViewController.Verbose.amount
        print("value: \(value)")
        //let value: String = "1.0" // In Ether
        let walletAddress = EthereumAddress(wallet.address)! // Your wallet address
        
        print ("wallet address \(walletAddress)")
        //sends the money to our public address
    
        let toWallet = ImportantVals.ourWallet
        let toAddress = EthereumAddress(toWallet.address)
        print ("wallet Toaddress \(toAddress)")
    
        let contract = web3.contract(Web3.Utils.coldWalletABI, at: toAddress, abiVersion: 2)!
        let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
        print("amount\(String(describing: amount))")
        var options = TransactionOptions.defaultOptions
       // let parameters: [AnyObject] = [toAddress, amount!] as [AnyObject]
        options.value = amount
        options.from = walletAddress
        options.gasPrice = .automatic
        options.gasLimit = .automatic
       
        let tx = contract.write(
            "fallback",
            parameters: [AnyObject](),
            extraData: Data(),
            transactionOptions: options)!
        
       let result = try! tx.send(password:password)
        print(result)
        return true
//        do {
//            try tx.send(password: password)
//            return true
//        //let result2 = try! transaction.call()
//        //print(result)
//        } catch {
//            displayAlert()
//            return false
//        }
        
    }
    
    func winnerTransaction() -> Bool{
        
        let wallet2 = Wallet(address: WalletViewController.Information.address2, data: WalletViewController.Information.data2, name: WalletViewController.Information.name2, isHD: false)
        
        
        
        let query = PFQuery(className:"info")
        query.getObjectInBackground(withId: "fCmNgfzEQd") { (info, error) in
                    if error == nil {
                        
                        let pass = info!["password"] as? String
                        let privkey = info!["privAd"] as? String
                        
                        ImportantVals.ourPrivKey = privkey!
                        ImportantVals.ourPass = pass!
                    } else {
                        print("it failed")
                    }
                }
   

        
        let password = ImportantVals.ourPass
        let key = ImportantVals.ourPrivKey
        // or use the the non-blocking method findObjectsInBackground

        query.findObjectsInBackground { (results: [PFObject]?, error: Error?) in
          // do some stuff with results
        }
        let formattedKey = key.trimmingCharacters(in: .whitespacesAndNewlines)
        let dataKey = Data.fromHex(formattedKey)!
        let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password)!
        let name = "New Wallet"
        let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
        let address = keystore.addresses!.first!.address
        let wallet = Wallet(address: address, data: keyData, name: name, isHD: false)
        
        
        
        
        
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
        
        let value = SlotPopUpViewController.Verbose.amount
        //let value: String = "1.0" // In Ether
        let walletAddress = EthereumAddress(wallet.address)! // Your wallet address
        //sends the money to our public address
        let toAddress = EthereumAddress(wallet2.address)!
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
        
        
        do {
         try tx.send(password: password)
            
            return true
        //let result2 = try! transaction.call()
        //print(result)
        } catch {
            displayAlert()
            return false
        }
        
    }
    
    

    }

