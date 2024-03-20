
import UIKit

class InfoViewController: UIViewController {
    
    //MARK: Subviews
    
    private lazy var infoScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        
        return contentView
    }()
    
    

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubview()
        setupConstraints()
        
        setupContentOfScrollView()
    }
    
    
    //MARK: Setup method
    
    private func setupView() {
        view.backgroundColor = UIColor(named: "LigthGray2")
        navigationItem.title = "Информация"
        navigationItem.titleView?.backgroundColor = UIColor(named: "GrayHeader")
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func addSubview() {
        view.addSubview(infoScrollView)
        
        infoScrollView.addSubview(contentView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            infoScrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            infoScrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            infoScrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 22),
            infoScrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: infoScrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: infoScrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: infoScrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: infoScrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: infoScrollView.bottomAnchor),
        ])
    }
    
    private func setupContentOfScrollView() {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor.black
        label.text = "Привычка за 21 день"
        
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22)
        ])
        
        let labelText = UITextView(frame: contentView.frame)
        
        labelText.translatesAutoresizingMaskIntoConstraints = false
        labelText.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        labelText.textColor = UIColor.black
        labelText.text = """
Прохождение этапов, за которые за 21
 день вырабатывается привычка,
 подчиняется следующему алгоритму:
"""
        
        contentView.addSubview(labelText)
        
        NSLayoutConstraint.activate([
            labelText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            labelText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            labelText.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
        ])
    }
    
}
