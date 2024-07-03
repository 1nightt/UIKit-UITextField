import UIKit

/// Пустой экран
final class SettingsViewController: UIViewController {
    
    enum Constants {
        static let backgroundColor: UIColor = .darkGray
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        createUI()
    }
    
    // MARK: - Private Methods
    private func createUI() {
        navigationItem.setHidesBackButton(true, animated: true)
    }
}
