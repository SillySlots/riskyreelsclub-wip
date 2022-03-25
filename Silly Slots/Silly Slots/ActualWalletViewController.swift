//
//  ActualWalletViewController.swift
//  Silly Slots
//
//  Created by Rayven Perkins on 3/25/22.
//

import UIKit
import web3swift

class ActualWalletViewController: UIViewController {

    @IBOutlet weak var balanceField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayBalance()

        // Do any additional setup after loading the view.
    }
    
    func displayBalance() {
//    let ethAdd = EthereumAddress(address)
//    let balancebigint = web3Rinkeby?.eth.getBalance(address: ethAdd).value
//    print("Ether Balance :\(String(describing: Web3.Utils.formatToEthereumUnits(balancebigint ?? 0)!))")
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
