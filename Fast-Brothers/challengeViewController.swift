//
//  challengeViewController.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 25/01/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class challengeViewController: UIViewController, UITableViewDataSource, UITabBarDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate  {
    
    @IBOutlet weak var challengesTableView: UITableView!
    
    var backgroundImage : UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Provas"
        challengesTableView.tableFooterView = UIView()

        if PFUser.current() != nil {
            let newChallenge = Challenge(name: "Desafio FastBrothers", password: "123123", turns: 3, especial: 2, ch: 1, WhoRegistered: PFUser.current()!)
            
            let newChallenge2 = Challenge(name: "Campeonato Brasileiro - Etapa MG", password: "123123", turns: 3, especial: 2, ch: 1, WhoRegistered: PFUser.current()!)
            
            challengesByClass.append(newChallenge)
            challengesByClass.append(newChallenge2)
            self.challengesTableView.reloadData()
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (PFUser.current() == nil){
            showLoginView()
        } else {
            print("Logado como: \(PFUser.current()!.username!)")
            challengesTableView.reloadData()
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        //return self.challenges.count
        return challengesByClass.count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let myCell = tableView.dequeueReusableCell(withIdentifier: "challengeCell", for:  indexPath) as! challengeTableViewCell
    
        myCell.name.text   = challengesByClass[indexPath.row].name
        myCell.status.text = challengesByClass[indexPath.row].status
    
        if challengesByClass[indexPath.row].status == "Em andamento" {
            myCell.status.textColor = UIColor(red: 36/255, green: 185/255, blue: 90/255, alpha: 1)
        }

        return myCell as UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor(red: 252/255, green: 245/255, blue: 85/255, alpha: 1)
        //240,255,80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Provas, veja os resultados"
    }
    
    private func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.red
        
        return vw
    }
    
    
    //MARK: Login methods
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
    
    @IBAction func logout(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Atenção", message: "Deseja sair da sua conta", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel)
        
        let destroyAction = UIAlertAction(title: "Sair", style: .destructive) { action in
            PFUser.logOut()
            _ = PFUser.current()
            self.showLoginView()
        }
        
        alertController.addAction(destroyAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true)
    }

}
