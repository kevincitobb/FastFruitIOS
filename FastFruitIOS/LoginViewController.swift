//
//  LoginViewController.swift
//  FastFruitIOS
//
//  Created by Kevin Hernández on 06/02/23.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    // ==================== Keys ====================
    struct Keys {
        static let EMAIL_KEY = "email_key"
        static let TOKEN_KEY = "access_token"
    }
    
    // ==================== UserData ====================
    struct UserData {
        var email: String = ""
        var password: String = ""
    }
    
    // ==================== General ====================
    private let userDefaults = UserDefaults.standard
    private var userData = UserData()
    
    // ==================== Text fields ====================
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    
    // ==================== Buttons ====================
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    // ==================== Objects ====================
    private var alerts = Alerts()
    var user : LoginUserEmail?
    
    // ==================== Methods ====================
    // MARK: Ciclo de Vida
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCustomElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Si existen datos de usuario almacenados de logeo, se procede con mostrar la ventana Home
        if checkIsNotEmptyDataUserLogin() {
            let email = userDefaults.string(forKey: Keys.EMAIL_KEY)
            user = LoginUserEmail(email: email!, pType: .basic)
            self.showHome()
        }
    }
    
    // MARK: Proceso de inicio de sesión
    @IBAction func loginButtonAction(_ sender: Any) {
        guard var email = emailTextField.text, var password = passTextField.text else {
            alert(title: "Error al capturar los datos", message: "Por favor vuelva a ingresar todos los campos")
            return
        }
        userData.email = email
        userData.password = password
        
        if validateFields() == true {
            login()
        }
    }
    
    @IBAction func signupButtonAction(_ sender: Any) {
        // Cambio de vista a "Sign Up"
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "signUp") as! SigninViewController
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    private func initCustomElements() {
        let borderColor = UIColor(named: "GradientPurpleColor")
        
        signUpButton.layer.borderWidth = 2.0
        signUpButton.layer.borderColor = borderColor?.cgColor
    }
    
    private func validateFields() -> Bool {
        let email = userData.email
        let pass = userData.password
        
        if email.isEmpty == true || pass.isEmpty == true {
            if email.isEmpty == true && pass.isEmpty == true {
                alert(title: "Email y contraseña no ingresados", message: "Por favor ingrese todos los campos")
            }
            else if email.isEmpty == true {
                alert(title: "Email no ingresado", message: "Por favor ingrese un email")
            }
            else {
                alert(title: "Contraseña no ingresada", message: "Por favor ingrese una contraseña")
            }
            return false
        }
        return true
    }
    
    private func login() {
        // Definicion de los datos del usuario a ingresar al sistema
        let email = userData.email
        let password = userData.password
        
        user = LoginUserEmail(email: email, pType: .basic)
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            //[weak self] authResult
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self.alert(title: "Email o contraseña inválida", message: "Verifique los datos ingresados y vuelva a intentarlo.")
            }
            else {
                self.savedLoginPreferences(email: email)
                self.showHome()
            }
        }
    }
    
    // MARK: Gestionamiento de credenciales de inicio de sesión
    private func savedLoginPreferences(email: String) {
        // Obtener el token de acceso
        Auth.auth().currentUser?.getIDToken { firebaseToken, error in
            let token = firebaseToken
            // Guardar el token en UserDefaults
            let defaults = UserDefaults.standard
            defaults.set(token, forKey: "access_token")
            defaults.set(email, forKey: "email_key")
            defaults.synchronize()
        }
    }
    
    private func checkIsNotEmptyDataUserLogin() -> Bool {
        guard let email = userDefaults.string(forKey: Keys.EMAIL_KEY),
              let token = userDefaults.string(forKey: Keys.TOKEN_KEY) else { return false }
        //print("Email valido: \(email)")
        //print("Token valido: \(token)")
        return true
    }
    
    // MARK: Cambio de vista a inicial (Map)
    private func showHome() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "HomeID")
        vc.modalPresentationStyle = .fullScreen
        //vc.userReceived = user
        present(vc, animated: true, completion: nil)
    }
    
    // MARK: Mensajes de alerta
    private func alert(title: String, message: String) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(
            title: "Aceptar",
            style: .default)
        )
        self.present(alertController, animated: true, completion: nil)
    }
    
}
