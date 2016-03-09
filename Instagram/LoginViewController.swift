//
//  LoginViewController.swift
//  Instagram
//
//  Created by Michael Gonzales on 3/7/16.
//  Copyright © 2016 mkgo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func signIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!){
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("Logged In")
                self.performSegueWithIdentifier("loginSegue" , sender: nil)
            }
            
        }
    }
    @IBAction func signUp(sender: AnyObject) {
        let newUser = PFUser()
        print(usernameField.text)
        print(passwordField.text)
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackgroundWithBlock { ( success: Bool, error: NSError?) -> Void in
            if success{
                print("User Created")
                self.performSegueWithIdentifier("loginSegue" , sender: nil)
            } else{
                print(error?.localizedDescription)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
