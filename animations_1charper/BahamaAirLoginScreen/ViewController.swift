/*
 * Copyright (c) 2014-present Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

// A delay function
func delay(_ seconds: Double, completion: @escaping ()->Void) {
  DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class ViewController: UIViewController, UITextFieldDelegate {
  
  // MARK: IB outlets
  
  @IBOutlet var loginButton: UIButton!
  @IBOutlet var heading: UILabel!
  @IBOutlet var username: UITextField!
  @IBOutlet var password: UITextField!
  
  @IBOutlet var cloud1: UIImageView!
  @IBOutlet var cloud2: UIImageView!
  @IBOutlet var cloud3: UIImageView!
  @IBOutlet var cloud4: UIImageView!
  
  // MARK: further UI
  
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
  let status = UIImageView(image: UIImage(named: "banner"))
  let label = UILabel()
  let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
 
  var statusPosition = CGPoint.zero
  
  // MARK: view controller methods
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //set up the UI
    loginButton.layer.cornerRadius = 8.0
    loginButton.layer.masksToBounds = true
    
    spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
    spinner.startAnimating()
    spinner.alpha = 0.0
    loginButton.addSubview(spinner)
    
    status.isHidden = true
    status.center = loginButton.center
    view.addSubview(status)
    
    label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
    label.font = UIFont(name: "HelveticaNeue", size: 18.0)
    label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
    label.textAlignment = .center
    status.addSubview(label)
    
    statusPosition = status.center
    
    
    //my setups
    username.delegate = self
    password.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    colocarForaDaTela()
    cloudsHide()
    
    loginButton.center.y += 30.0
    loginButton.alpha = 0.0
    
    }
  
    
    
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    // Cabeçalho
    UIView.animate(withDuration: 0.5) {
        self.heading.center.x += self.view.bounds.width
    }
    
    //Login
//    UIView.animate(withDuration: 0.5, delay: 0.3, options: [],
//                   animations: {
//                    self.username.center.x += self.view.bounds.width
//    },completion: nil)
    
    //Senha
//    UIView.animate(withDuration: 0.5, delay: 0.4, options: [], animations: {
//        self.password.center.x += self.view.bounds.width
//    },completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 0.7, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
        self.username.center.x += self.view.bounds.width
    }, completion: nil)
    
    UIView.animate(withDuration: 0.5, delay: 1.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: [], animations: {
        self.password.center.x += self.view.bounds.width
    }, completion: nil)
    
    //Nuvens
    UIView.animate(withDuration: 1, delay: 0.5, options:[.curveEaseOut], animations:{
        self.cloud1.alpha = 1
    }, completion: nil)
    UIView.animate(withDuration: 1, delay: 0.9, options:[.curveEaseOut], animations:{
        self.cloud2.alpha = 1
    }, completion: nil)
    UIView.animate(withDuration: 1, delay: 1.3, options:[.curveEaseOut], animations:{
        self.cloud3.alpha = 1
    }, completion: nil)
    UIView.animate(withDuration: 1, delay: 1.7, options:[.curveEaseOut], animations:{
        self.cloud4.alpha = 1
    }, completion: nil)
    
    //Log In -- Butao ( 0.5, delay: 0.5,)
//    UIView.animate(withDuration:0.5, delay: 0.5, usingSpringWithDamping: 0.5,
//                               initialSpringVelocity: 0.0, options: [], animations: {
//                                self.loginButton.center.y -= 30.0
//                                self.loginButton.alpha = 1.0
//    }, completion: nil)
    UIView.animate(withDuration: 0.5,
                   delay: 0.5,
                   usingSpringWithDamping: 0.5,
                   initialSpringVelocity: 0.0,
                   options: [],
                   animations: {
                        self.loginButton.center.y -= 30.0
                        self.loginButton.alpha = 1.0
                   }, completion: nil)
    
  }
  
  // MARK: further methods
  
  @IBAction func login() {
    view.endEditing(true)
    UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2,
                               initialSpringVelocity: 0.0, options: [], animations: {
                                self.loginButton.bounds.size.width += 80.0
    }, completion: {_ in
        self.showMessage(index: 0)
    })
    
    UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping:
        0.7, initialSpringVelocity: 0.0, options: [], animations: {
            self.loginButton.center.y += 60.0
            self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
            
            self.spinner.center = CGPoint(x: 40.0,
                                          y: self.loginButton.frame.size.height/2)
            self.spinner.alpha = 1.0
    }, completion: nil)
  }
  
    // MARK: My functions
    func colocarForaDaTela() {
        heading.center.x  -= view.bounds.width
        username.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
    }
    func cloudsHide() {
        self.cloud1.alpha = 0
        self.cloud2.alpha = 0
        self.cloud3.alpha = 0
        self.cloud4.alpha = 0
        
        animateCloud(cloud: cloud1)
        animateCloud(cloud: cloud2)
        animateCloud(cloud: cloud3)
        animateCloud(cloud: cloud4)
        
    }
    
    func resetForm() {
        UIView.transition(with: self.status, duration: 0.2, options: [.transitionCurlUp], animations: {
            self.status.isHidden = true
            self.status.center = self.statusPosition
        }, completion: nil)
        
        UIView.animate(withDuration: 2, delay: 1, options: [], animations: {
            self.spinner.center = CGPoint(x: -20.0, y: 16.0)
            self.spinner.alpha = 0
            self.loginButton.bounds.size.width -= 80.0
            self.loginButton.center.y -= 60.0
            self.loginButton.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
        }, completion: nil)
    }
    
    func showMessage(index: Int) {
        
        label.text = messages[index]
        UIView.transition(with: status,
                          duration: 0.33,
                          options: [.curveEaseOut, .transitionCurlDown],
                          animations: {
                                self.status.isHidden = false
                        },completion: {_ in
                            delay(2.0) {
                                if index < self.messages.count-1 {
                                    self.removeMessage(index: index) } else {
                                    //reset form
                                    self.resetForm()
                                } }
                        })
    }
    
    func removeMessage(index: Int) {
        UIView.animate(withDuration: 0.33, delay: 0.0, options: [], animations:{
            self.status.center.x += self.view.frame.size.width
        }, completion: {_ in
            self.status.isHidden = true
            self.status.center = self.statusPosition
            self.showMessage(index: index+1) })
    }
    
    func animateCloud(cloud: UIImageView) {
        let cloudSpeed = 60.0 / self.view.frame.size.width //Cuzar a tela toda em 60 segundos
        let avgSpeed = (self.view.frame.size.width - cloud.frame.origin.x) * cloudSpeed // Velocidade Media
        
        UIView.animate(withDuration: TimeInterval(avgSpeed), delay: 0, options: [.repeat, .curveLinear], animations: {
            //Duracao vai fazer andar de vagar ate o total
            //Qndo chegar vai pro completion , qndo a ponta direita da nuvem bater no edge no lado esquerdo.
            cloud.frame.origin.x = self.view.frame.size.width
        }, completion:{ _ in
            cloud.frame.origin.x -= cloud.frame.size.width
            //self.animateCloud(cloud: cloud) //colorei option repeate.
        })
    }
    
  // MARK: UITextFieldDelegate
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if (textField === username){
        password.returnKeyType = .go
        password.becomeFirstResponder()
        
    } else {
        self.login()
    }
    return true
  }
  
}
