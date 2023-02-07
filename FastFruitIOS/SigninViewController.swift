//
//  SigninViewController.swift
//  FastFruitIOS
//
//  Created by Kevin Hernández on 06/02/23.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SigninViewController: UIViewController {
    
    // ==================== Keys ====================
    struct Keys {
        static let EMAIL_KEY = "email_key"
        static let TOKEN_KEY = "access_token"
    }
    
    // ==================== UserData ====================
    struct UserData {
        var email: String = ""
        var password: String = ""
        var name: String = ""
    }

    // ==================== General ====================
    var user : LoginUserEmail?
    var userCreated : User?
    private var alerts = Alerts()
    private let userDefaults = UserDefaults.standard
    private var userData = UserData()
    private let database = Firestore.firestore()
    
    // ==================== Text fields ====================

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordRepeatTextField: UITextField!
    
    // ==================== Buttons ====================
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var logInButton: UIButton!
    
    // ==================== Propierties ====================
    private var email : String?
    private var provider : ProviderType? = .basic
    
    // ==================== Methods ====================
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initCustomElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // Creacion de cuenta
    @IBAction func signupButtonAction(_ sender: Any) {
        if validateFields() == true {
            signUp()
        }
    }
    
    private func initCustomElements() {
        let borderColor = UIColor(named: "GradientPurpleColor")
        
        logInButton.layer.borderWidth = 2.0
        logInButton.layer.borderColor = borderColor?.cgColor
    }
    
    func validateFields() -> Bool {
        let email = emailTextField.text
        let pass = passwordTextField.text
        let passRepeat = passwordRepeatTextField.text
        
        
        if email?.isEmpty == true || pass?.isEmpty == true || passRepeat?.isEmpty == true {
            if email?.isEmpty == true && pass?.isEmpty == true && passRepeat?.isEmpty == true {
                alert(title: "Información vacía", message: "Por favor ingrese todos los campos")
            }
            if email?.isEmpty == true {
                alert(title: "Email no ingresado", message: "Por favor ingrese un email")
            }
            else if pass?.isEmpty == true {
                alert(title: "Contraseña no ingresada", message: "Por favor ingrese una contraseña")
            }
            else if passRepeat?.isEmpty == true {
                alert(title: "Contraseñas distintas", message: "Por favor ingrese ambas contraseñas iguales")
            }
            return false
        }
        else if (!validateEmail(candidate: email!)) {
            alert(title: "Email inválido", message: "Por favor verifique el email ingresado ya que no cuenta con un formato válido.")
            return false
        }
        else if (pass != passRepeat) {
            alert(title: "Contraseñas distintas", message: "Por favor ingrese ambas contraseñas iguales")
            return false
        }
        return true
    }
    
    private func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
     }
    
    func signUp() {
        // Definicion de los datos del usuario a ingresar al sistema
        let email = emailTextField.text
        let password = passwordTextField.text
        
        user = LoginUserEmail(email: email!, pType: .basic)
        
        Auth.auth().createUser(withEmail: email!, password: password!) { [weak self] authResult, error in
            //guard let strongSelf = self else { return }
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self!.alert(title: "Error con la creacion de su cuenta", message: "Por el momento contamos con dificultades para iniciar sesión, por favor intentelo más tarde")
            }
            else {
                print("Email = \(email!)")
                print("Password = \(password!)")
              
                
                self!.userData.email = email!
                self!.userData.password = password!
                self!.setData(email: self!.user!.email)
                self!.login()
            }
        }
    }
    
    private func login() {
        // Definicion de los datos del usuario a ingresar al sistema
        let email = userData.email
        let password = userData.password
        
        user = LoginUserEmail(email: email, pType: .basic)
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                self.alert(title: "Error de Inicio de Sesión", message: "Por el momento contamos con dificultades para iniciar sesión en su cuenta, por favor reinicie la app y vuelva a intentarlo.")
            }
            else {
                self.savedLoginPreferences(email: email)
                self.checkUserInfo()
            }
        }
    }
    
    func checkUserInfo() {
        if Auth.auth().currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "HomeID") //as! HomeViewController
            vc.modalPresentationStyle = .fullScreen
            //vc.userReceived = user
            present(vc, animated: true, completion: nil)
        }
    }
    
    private func setData(email: String?) {
        if (!userData.email.isEmpty) {
            let COLLECTION = "users"
            

            let EMAIL = "email"
            let _EMAIL = userData.email
            let data : [String : String] = [ EMAIL :  _EMAIL]
            
            database.collection(COLLECTION).document(email!).getDocument { (document, error) in
                self.database.collection(COLLECTION).document(self.userData.email).setData(data) { (error) in
                    if let error = error {
                        print("Error al agregar el documento: \(error)")
                        self.alert(
                            title: "Error de servicio - Problema con registro de cuenta",
                            message: "Se detecto un problema con su cuenta, por favor reinicie la app y vuelva a intentarlo."
                        )
                    } else {
                        print("Documento agregado con éxito")
                    }
                }
            }
        } else {
            self.alert(
                title: "Error de servicio - Problema con cuenta de email",
                message: "Se detecto un problema con su cuenta, por favor cierre sesión y reinicie la app."
            )
        }
    }
    
    @IBAction func loginButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
