//
//  SlotPopUpViewController.swift
//  Silly Slots
//
//  Created by Rayven Perkins on 4/2/22.
//

import UIKit
import web3swift

class SlotPopUpViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    struct Wallet {
        let address: String
        let data: Data
        let name: String
        let isHD: Bool
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeTranscation()

        // Do any additional setup after loading the view.
    }
    
    
    func initializeTranscation() {
        let key = WalletViewController().privKeyField.text!
        let password = passwordField.text!
        //let key = "L2HRewdY7SSpB2jjKq6mwLes86umkWBuUSPZWE35Q8Pbbr8wVyss124sf124dfsf" // Some private key
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
        
        //get user balance
        let walletAddress = EthereumAddress(wallet.address)! // Address which balance we want to know
        let balanceResult = try! web3.eth.getBalance(address: walletAddress)
        let balanceString = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3)!
        
        let value: String = "1.0" // In Ether
       // let walletAddress = EthereumAddress(wallet.address)! // Your wallet address
        //sends the money to our public address
        let toAddress = EthereumAddress("0xeBf602Aef3668a37fb3231Bf5Ac56a6b4fD402B4")!
        let contract = web3.contract(Web3.Utils.coldWalletABI, at: toAddress, abiVersion: 2)!
        let amount = Web3.Utils.parseToBigUInt(value, units: .eth)
        var options = TransactionOptions.defaultOptions
        options.value = amount
        options.from = walletAddress
        options.gasPrice = .automatic
        options.gasLimit = .automatic
        let tx = contract.write(
            "fallback",
            parameters: [AnyObject](),
            extraData: Data(),
            transactionOptions: options)!
        
        
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
