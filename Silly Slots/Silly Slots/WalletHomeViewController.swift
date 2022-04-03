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

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeWeb3()
        displayBalance()

        // Do any additional setup after loading the view.
    }
    
    
    func displayBalance() {
        
        let query = PFQuery(className:"walletManagement")
        query.getObjectInBackground(withId: "Z1xpFDAdgz") { (walletManagement, error) in
            if error == nil {
                
                let balance = walletManagement!["balance"] as? String
                self.balanceLabel.text = ("$" + balance! + ".00")
            } else {
                print("it failed")
            }
        }
        
        balanceLabel.text = "$"  //+ balance + "asd"
    }
    
    
    func initializeWeb3() {
        // common Http/Https provider
//        let endpoint = "https://api.blockcypher.com/v1/eth/main"
//        let web3 = web3(provider: Web3HttpProvider(URL(string: endpoint)!)!)
        // precompiled Infura providers
        let web3 = Web3.InfuraMainnetWeb3() // Mainnet Infura Endpoint Provider
//        let web3 = Web3.InfuraRinkebyWeb3() // Rinkeby Infura Endpoint Provider
//        let web3 = Web3.InfuraRopstenWeb3() // Ropsten Infura Endpoint Provider
//
        
       // web3.addKeystoreManager(keystoreManager)
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
