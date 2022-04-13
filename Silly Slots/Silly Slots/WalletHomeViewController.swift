//
//  ActualWalletViewController.swift
//  Silly Slots
//
//  Created by Rayven Perkins on 3/25/22.
//

import UIKit
import web3swift
import Parse

class WalletHomeViewController: UIViewController {
    
    @IBOutlet weak var balanceLabel: UILabel!
    
    //intializing the ethereum address
    
    struct Wallet {
        let address: String
        let data: Data
        let name: String
        let isHD: Bool
    }
    

    let coldWalletAddress = EthereumAddress("0x6394b37Cf80A7358b38068f0CA4760ad49983a1B")!
    let contractAddress = EthereumAddress("0xe22b8979739D724343bd002F9f432F5990879901", ignoreChecksum: true)!
    let web3 = Web3.InfuraMainnetWeb3()

    override func viewDidLoad() {
        super.viewDidLoad()
        displayBalance()

        // Do any additional setup after loading the view.
    }
    
    
    func displayBalance() {
        
       print( WalletViewController.Information.address2 )
        
        
        let wallet = Wallet(address: WalletViewController.Information.address2, data: WalletViewController.Information.data2, name: WalletViewController.Information.name2, isHD: false)
        
        
        
        let walletAddress = EthereumAddress(wallet.address)!
        
        
        
        let balanceResult = try! web3.eth.getBalance(address: walletAddress)
        let balanceString = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3)!
        
        
        
        print(balanceString + " is the balance string")
        self.balanceLabel.text = (balanceString + "")
        
        
//        let query = PFQuery(className:"walletManagement")
//        query.getObjectInBackground(withId: "Z1xpFDAdgz") { (walletManagement, error) in
//            if error == nil {
//
//                let balance = walletManagement!["balance"] as? String
//                self.balanceLabel.text = ("$" + balance! + ".00")
//            } else {
//                print("it failed")
//            }
//        }
//
//        balanceLabel.text = "$"  //+ balance + "asd"
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
