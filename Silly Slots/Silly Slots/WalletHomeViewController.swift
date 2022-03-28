//
//  ActualWalletViewController.swift
//  Silly Slots
//
//  Created by Rayven Perkins on 3/25/22.
//

import UIKit
import web3swift

class WalletHomeViewController: UIViewController {
    
    
    //intializing the ethereum address
    let coldWalletAddress = EthereumAddress("0x6394b37Cf80A7358b38068f0CA4760ad49983a1B")!
    let contractAddress = EthereumAddress("0xe22b8979739D724343bd002F9f432F5990879901", ignoreChecksum: true)!

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeWeb3()
        displayBalance()

        // Do any additional setup after loading the view.
    }
    
    func displayBalance() {
//    let ethAdd = EthereumAddress(address)
//    let balancebigint = web3Rinkeby?.eth.getBalance(address: ethAdd).value
//    print("Ether Balance :\(String(describing: Web3.Utils.formatToEthereumUnits(balancebigint ?? 0)!))")
        
        
//        let walletAddress = EthereumAddress(wallet.address)! // Address which balance we want to know
//        let balanceResult = try! web3.eth.getBalance(address: walletAddress)
//        let balanceString = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3)!
        
//        print(balanceString)
//        print("balanceString should have been printed")
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
