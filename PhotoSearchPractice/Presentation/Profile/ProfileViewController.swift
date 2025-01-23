//
//  ProfileViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit
import Then

final class ProfileViewController: BaseViewController, PassBirthdayDelegate {
    
    private let nicknameButton = UIButton()
    private let birthdayButton = UIButton()
    private let levelButton = UIButton()
    
    private let nicknameLabel = UILabel()
    private let birthdayLabel = UILabel()
    private let levelLabel = UILabel()
        
    @objc private func okButtonTapped() {
        print(#function)
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let window = scene.windows.first else { return }
        window.rootViewController = UINavigationController(rootViewController: OnboardingViewController())
        window.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNotificationCenter()
    }
    
    override func configHierarchy() {
        view.addSubview(nicknameButton)
        view.addSubview(birthdayButton)
        view.addSubview(levelButton)
    
        view.addSubview(nicknameLabel)
        view.addSubview(birthdayLabel)
        view.addSubview(levelLabel)
    }
    
    override func configLayout() {
        nicknameButton.snp.makeConstraints { make in
            make.leading.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        birthdayButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(nicknameButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        levelButton.snp.makeConstraints { make in
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.top.equalTo(birthdayButton.snp.bottom).offset(24)
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(nicknameButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        birthdayLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(birthdayButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayLabel.snp.bottom).offset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.leading.equalTo(levelButton.snp.trailing).offset(24)
            make.height.equalTo(50)
        }
        
    }
    
    override func configView() {
        navigationController?.navigationItem.largeTitleDisplayMode = .inline
        navigationItem.title = "프로필 화면"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "탈퇴하기", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .black
        config.background.backgroundColor = .clear
        
        nicknameButton.do {
            config.title = "닉네임"
            $0.configuration = config
            $0.tag = 0
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        birthdayButton.do {
            config.title = "생일"
            $0.configuration = config
            $0.tag = 1
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        levelButton.do {
            config.title = "레벨"
            $0.configuration = config
            $0.tag = 2
            $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
        
        nicknameLabel.text = "NO NAME"
        nicknameLabel.textColor = .lightGray
        nicknameLabel.textAlignment = .right
        
        birthdayLabel.text = "NO DATE"
        birthdayLabel.textColor = .lightGray
        birthdayLabel.textAlignment = .right
        
        levelLabel.text = "NO LEVEL"
        levelLabel.textColor = .lightGray
        levelLabel.textAlignment = .right
    }
    
    func configNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(receiveLevelNotification), name: NSNotification.Name("level"), object: nil)
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            let vc = NicknameViewController()
            vc.contents = {
                self.nicknameLabel.text = $0
            }
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case 1:
            let vc = BirthdayViewController()
            vc.contents = self
            self.navigationController?.pushViewController(vc, animated: true)
            return
        case 2:
            let vc = LevelViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            return
        }
    }
    
    @objc private func receiveLevelNotification(notification: NSNotification) {
        print(#function, "신호받음")
        if let level = notification.userInfo!["level"] as? String {
            levelLabel.text = level
        } else {
            levelLabel.text = "레벨 설정 오류! 레벨을 다시 설정해주세요."
        }
    }
    
    // MARK: PassBirthdayDelegate
    func receiveBirthday(value: String) {
        birthdayLabel.text = value
    }
    
}
