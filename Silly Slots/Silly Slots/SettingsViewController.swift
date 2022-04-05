////
////  SettingsViewController.swift
////  Silly Slots
////
////  Created by Rayven Perkins on 3/20/22.
////
//
import UIKit
import Parse

class SettingsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var modeControl: UISwitch!
    @IBOutlet weak var modeControlLabel: UILabel!
    @IBOutlet weak var bettingControl: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        
        if(defaults.bool(forKey: "lightModeEnabled")){
            overrideUserInterfaceStyle = .light
        }
        else if !(defaults.bool(forKey: "lightModeEnabled")){
            overrideUserInterfaceStyle = .dark
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        defaults.set(bettingControl.text!, forKey: "bettingAmount")
       // defaults.synchronize()
    }

    @IBAction func modeSwitchControl(_ sender: Any) {
//        let mode = Int(modeControl.)
        if modeControl.isOn {
//            modeControl.setOn(true, animated:true)
            defaults.set(true, forKey: "lightModeEnabled")
            modeControlLabel.text = "LIGHT MODE"
            overrideUserInterfaceStyle = .light
        }
        else {
//            modeControl.setOn(true, animated:true)
            defaults.set(false, forKey: "lightModeEnabled")
            modeControlLabel.text = "DARK MODE"
            overrideUserInterfaceStyle = .dark
        }
        defaults.synchronize()
        
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOut()
        
        let main =  UIStoryboard(name: "Main", bundle: nil)
       let firstScreenViewController = main.instantiateViewController(withIdentifier: "FirstScreenViewController")
       
       guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
      
       delegate.window?.rootViewController = firstScreenViewController
    }
    
    @IBAction func betAmountUpdated(_ sender: UITextField)
    {
        let betAmount = bettingControl.text
        
        defaults.set(betAmount, forKey:"bettingAmount")
        defaults.set(true, forKey:"betUpdated")
        defaults.synchronize()
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
