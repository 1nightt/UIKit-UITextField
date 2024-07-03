import UIKit

/// Экран регистрации
final class LoginViewController: UIViewController {
    enum Constants {
        static let backgroundColor: UIColor = .white
        static let imageSize = CGSize(width: 30, height: 30)
        static let nameImage = UIImageView(image: UIImage(systemName: "person.fill"))
        static let emailImage = UIImageView(image: UIImage(systemName: "mail.fill"))
        static let numberImage = UIImageView(image: UIImage(systemName: "phone.fill"))
        static let passwordImage = UIImageView(image: UIImage(systemName: "lock.fill"))
    }
    
    // MARK: - Private Properties
    private var helloLabel = UILabel()
    private var nameTextField = UITextField()
    private var emailTextField = UITextField()
    private var numberTextField = UITextField()
    private var passwordTextField = UITextField()
    private var enterButton = UIButton(type: .system)
    private var haveAccountButton = UIButton(type: .system)
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        createHelloLabel()
        createNameTextField()
        createEmailTextField()
        createNumberTextField()
        createPasswordTextField()
        createEnterButton()
        createHaveAccountButton()
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = -200
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { (nc) in
            self.view.frame.origin.y = 0
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private Methods
    private func createHelloLabel() {
        helloLabel.frame = CGRect(x: 0, y: 50, width: 300, height: 40)
        helloLabel.center.x = view.center.x
        helloLabel.text = "Добро пожаловать"
        helloLabel.textAlignment = .center
        helloLabel.font = UIFont.boldSystemFont(ofSize: 25)
        view.addSubview(helloLabel)
    }
        
    private func createNameTextField() {
        Constants.nameImage.contentMode = .scaleAspectFit
        Constants.nameImage.frame = CGRect(origin: .zero, size: Constants.imageSize)
        Constants.nameImage.tintColor = .lightGray
        
        nameTextField.delegate = self
        nameTextField.frame = CGRect(x: 0, y: 250, width: 250, height: 40)
        nameTextField.center.x = view.center.x
        nameTextField.borderStyle = .roundedRect
        nameTextField.placeholder = "Введите ваше имя"
        nameTextField.keyboardType = .default
        nameTextField.leftViewMode = .always
        nameTextField.leftView = Constants.nameImage
        nameTextField.clearButtonMode = .whileEditing
        view.addSubview(nameTextField)
    }
        
    private func createEmailTextField() {
        Constants.emailImage.contentMode = .scaleAspectFit
        Constants.emailImage.frame = CGRect(origin: .zero, size: Constants.imageSize)
        Constants.emailImage.tintColor = .lightGray
        
        emailTextField.delegate = self
        emailTextField.frame = CGRect(x: 0, y: 325, width: 250, height: 40)
        emailTextField.center.x = view.center.x
        emailTextField.borderStyle = .roundedRect
        emailTextField.placeholder = "Введите ваш email"
        emailTextField.leftViewMode = .always
        emailTextField.leftView = Constants.emailImage
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.keyboardType = .emailAddress
        view.addSubview(emailTextField)
    }
        
    private func createNumberTextField() {
        Constants.numberImage.contentMode = .scaleAspectFit
        Constants.numberImage.frame = CGRect(origin: .zero, size: Constants.imageSize)
        Constants.numberImage.tintColor = .lightGray
        
        numberTextField.delegate = self
        numberTextField.frame = CGRect(x: 0, y: 400, width: 250, height: 40)
        numberTextField.center.x = view.center.x
        numberTextField.borderStyle = .roundedRect
        numberTextField.placeholder = "Введите ваш номер"
        numberTextField.keyboardType = .numberPad
        numberTextField.leftViewMode = .always
        numberTextField.leftView = Constants.numberImage
        numberTextField.clearButtonMode = .whileEditing
        view.addSubview(numberTextField)
    }
        
    private func createPasswordTextField() {
        Constants.passwordImage.contentMode = .scaleAspectFit
        Constants.passwordImage.frame = CGRect(origin: .zero, size: Constants.imageSize)
        Constants.passwordImage.tintColor = .lightGray
        
        passwordTextField.delegate = self
        passwordTextField.frame = CGRect(x: 0, y: 475, width: 250, height: 40)
        passwordTextField.center.x = view.center.x
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.placeholder = "Введите пароль"
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.leftViewMode = .always
        passwordTextField.leftView = Constants.passwordImage
        passwordTextField.clearButtonMode = .whileEditing
        view.addSubview(passwordTextField)
    }
    
    private func createEnterButton() {
        enterButton.frame = CGRect(x: 0, y: 600, width: 200, height: 50)
        enterButton.center.x = view.center.x
        enterButton.setTitle("Регистрация", for: .normal)
        enterButton.setTitleColor(.white, for: .normal)
        enterButton.backgroundColor = .systemBlue
        enterButton.layer.cornerRadius = 15
        view.addSubview(enterButton)
        enterButton.addTarget(self, action: #selector(nextScreen), for: .touchUpInside)
    }
        
    private func createHaveAccountButton() {
        haveAccountButton.frame = CGRect(x: 0, y: 670, width: 200, height: 20)
        haveAccountButton.center.x = view.center.x
        haveAccountButton.setTitle("Уже есть аккаунт!", for: .normal)
        haveAccountButton.setTitleColor(.black, for: .normal)
        view.addSubview(haveAccountButton)
        haveAccountButton.addTarget(self, action: #selector(haveAccount), for: .touchUpInside)
    }
        
    @objc private func nextScreen() {
        if emailTextField.text!.isEmpty || nameTextField.text!.isEmpty || numberTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            let alertController = UIAlertController(title: "Ошибка!", message: "Заполните все данные", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okButton)
            self.present(alertController, animated: true)
        }
        let secondVC = SettingsViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    @objc private func haveAccount() {
        let secondVC = SettingsViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
}

/// UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nameTextField: return emailTextField.becomeFirstResponder()
        case emailTextField: return numberTextField.becomeFirstResponder()
        case passwordTextField: return textField.resignFirstResponder()
        default: break
        }
        return true
    }
}
