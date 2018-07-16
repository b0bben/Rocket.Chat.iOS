//
//  NotificationsSwitchCell.swift
//  Rocket.Chat
//
//  Created by Artur Rymarz on 05.03.2018.
//  Copyright © 2018 Rocket.Chat. All rights reserved.
//

import UIKit

final class NotificationsSwitchCell: UITableViewCell, NotificationsCellProtocol {
    struct SettingModel: NotificationSettingModel {
        let value: Dynamic<Bool>
        var type: NotificationCellType
        let leftTitle: String
        let leftDescription: String
        let rightTitle: String
        let rightDescription: String
    }

    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var leftDescriptionLabel: UILabel!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var rightDescriptionLabel: UILabel!
    @IBOutlet weak var turnSwitch: UISwitch!

    var cellModel: NotificationSettingModel? {
        didSet {
            guard let model = cellModel as? SettingModel else {
                return
            }

            leftTitleLabel.text = model.leftTitle
            leftDescriptionLabel.text = model.leftDescription
            rightTitleLabel.text = model.rightTitle
            rightDescriptionLabel.text = model.rightDescription
            turnSwitch.isOn = model.value.value

            updateCell()
        }
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        guard let model = cellModel as? SettingModel else {
            return
        }

        model.value.value = sender.isOn
        updateCell()
    }

    private func updateCell() {
        guard let model = cellModel as? SettingModel else {
            return
        }

        let currentTheme = theme ?? ThemeManager.theme

        leftTitleLabel.textColor = model.value.value ? currentTheme.auxiliaryText : currentTheme.titleText
        leftDescriptionLabel.textColor = model.value.value ? currentTheme.auxiliaryText : currentTheme.titleText
        rightTitleLabel.textColor = model.value.value ? currentTheme.titleText : .lightGray
        rightDescriptionLabel.textColor = model.value.value ? currentTheme.titleText : currentTheme.auxiliaryText
    }

}
