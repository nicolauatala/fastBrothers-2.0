//
//  settingsTableViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 21/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class settingsTableViewController: UITableViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var useremail: UILabel!
    @IBOutlet weak var userchallenges: UILabel!
    
    var backgroundImage : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Informações"
        tableView.tableFooterView = UIView()
        
        username.text = PFUser.current()?.username
        useremail.text = PFUser.current()?.email
        
        let getChallenges = Challenges()
        getChallenges.countChallengesByThisUser(completionHandler: { (result) -> Void in
            if result == 0 {
                self.userchallenges.text = "Nenhuma prova registrada"
            } else if result == 1 {
                self.userchallenges.text = "1 prova registrada"
            } else {
                self.userchallenges.text = "\(result) provas registradas"
            }
        })
        
    }

    @IBAction func logout(_ sender: Any) {
        let alertController = UIAlertController(title: "Atenção", message: "Deseja sair da sua conta", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        let destroyAction = UIAlertAction(title: "Sair", style: .destructive) { action in
            PFUser.logOut()
            _ = PFUser.current()
            self.showLoginView()
            _ = self.navigationController?.popToRootViewController(animated:true)
        }
        
        alertController.addAction(destroyAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)

    }
    
    var logInViewController:   PFLogInViewController! = PFLogInViewController()
    var signUpViewController: PFSignUpViewController! = PFSignUpViewController()
    
    func showLoginView(){
        backgroundImage = UIImageView(image: UIImage(named: "bgLogin.jpg"))
        backgroundImage.contentMode = UIViewContentMode.scaleToFill
        self.logInViewController.logInView?.insertSubview(backgroundImage, at: 0)
        
        self.logInViewController.fields = [PFLogInFields.usernameAndPassword, PFLogInFields.logInButton, PFLogInFields.signUpButton, PFLogInFields.passwordForgotten, PFLogInFields.dismissButton]
        
        let logoView = UIImageView(image: UIImage(named:"logo-fastBrothers-text-2.png"))
        logoView.contentMode = UIViewContentMode.scaleAspectFit
        self.logInViewController.logInView?.logo = logoView
        
        
        
        self.logInViewController.logInView!.usernameField?.placeholder = "Usuário"
        self.logInViewController.logInView!.passwordField?.placeholder = "Senha"
        self.logInViewController.logInView!.logInButton?.setTitle("Entrar", for: UIControlState.normal)
        self.logInViewController.logInView!.passwordForgottenButton?.setTitle("Esqueceu a senha?", for: UIControlState.normal)
        self.logInViewController.logInView!.signUpButton!.setTitle("Cadastra-se", for: UIControlState.normal)
        customizeButton(button: self.logInViewController.logInView!.signUpButton!)
        
        self.logInViewController.delegate = self
        
        let signUpLogoTitle = UILabel()
        signUpLogoTitle.text = "Cadastre-se para acessar o aplicativo"
        self.signUpViewController.signUpView!.logo = signUpLogoTitle
        self.signUpViewController.signUpView!.usernameField?.placeholder = "Usuário"
        self.signUpViewController.signUpView!.emailField?.placeholder = "E-mail"
        self.signUpViewController.signUpView!.passwordField?.placeholder = "Senha"
        self.signUpViewController.signUpView!.signUpButton?.setTitle("Cadastrar-se", for: UIControlState.normal)
        self.signUpViewController.delegate = self
        self.logInViewController.signUpController = self.signUpViewController
        
        self.present(self.logInViewController, animated: true, completion: nil)
    }
    
    func customizeButton(button: UIButton!) {
        button.setBackgroundImage(nil, for: .normal)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
    }
    
    //MARK: Login Parse
    func log(_ logInController: PFLogInViewController, shouldBeginLogInWithUsername username: String, password: String) -> Bool {
        if(!username.isEmpty || !password.isEmpty){
            return true
        } else {
            return false
        }
    }
    
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func log(_ logInController: PFLogInViewController, didFailToLogInWithError error: Error?) {
        let alertController = UIAlertController(title: "Atenção", message: "Usuário ou senha incorreta. Tente novamente.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in }
        alertController.addAction(OKAction)
        logInViewController.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: SignUp Parse
    func signUpViewController(_ signUpController: PFSignUpViewController, didSignUp user: PFUser) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @nonobjc func signUpViewController(_ signUpController: PFSignUpViewController, didFailToSignUpWithError error: NSError?) {
    }
    
    func signUpViewControllerDidCancelSignUp(_ signUpController: PFSignUpViewController) {
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

}
