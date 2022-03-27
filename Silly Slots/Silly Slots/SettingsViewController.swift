////
////  SettingsViewController.swift
////  Silly Slots
////
////  Created by Rayven Perkins on 3/20/22.
////
//
import UIKit

class SettingsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var modeControl: UISwitch!
    @IBOutlet weak var modeControlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if(defaults.bool(forKey: "darkModeEnabled")){
            overrideUserInterfaceStyle = .dark
            print("dark mode enabled")
//            modeControl.setOn(false, animated: true)
        }
        else if !(defaults.bool(forKey: "darkModeEnabled")){
            overrideUserInterfaceStyle = .light
            print("dark mode not enabled")
//            modeControl.setOn(true, animated: true)
        }
    }

    @IBAction func modeSwitchControl(_ sender: Any) {
//        let mode = Int(modeControl.)
        if modeControl.isOn {
//            modeControl.setOn(true, animated:true)
            defaults.set(false, forKey: "darkModeEnabled")
            modeControlLabel.text = "LIGHT MODE"
            overrideUserInterfaceStyle = .light
        }
        else {
//            modeControl.setOn(true, animated:true)
            defaults.set(true, forKey: "darkModeEnabled")
            modeControlLabel.text = "DARK MODE"
            overrideUserInterfaceStyle = .dark
        }
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
