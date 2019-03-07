// Copyright © 2019 Chamitha Wijesekera. All rights reserved.

import CoreLocation
import Eureka
import Foundation

public final class LocationCell: PushSelectorCell<CLPlacemark> {
    @IBOutlet public weak var clearButton: UIButton!

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let clearButton = UIButton(frame: CGRect(x: 0, y: 0, width: 18, height: 18))
        clearButton.setImage(UIImage(named: "Clear", in: Bundle.current, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = .lightGray

        self.clearButton = clearButton

        accessoryView = clearButton
        editingAccessoryView = accessoryView
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    deinit {
        clearButton?.removeTarget(self, action: nil, for: .allEvents)
    }

    public override func setup() {
        super.setup()

        clearButton.addTarget(self, action: #selector(LocationCell.clear), for: .touchUpInside)
    }

    public override func update() {
        super.update()

        detailTextLabel?.text = nil
        accessoryType = .none

        guard let row = self.row as? LocationRow else { return }

        textLabel?.text = row.value?.name ?? row.placeholder
        textLabel?.textColor = row.value?.name != nil ? .black : UIColor(red: 198 / 255, green: 198 / 255, blue: 204 / 255, alpha: 1)

        clearButton.isHidden = isEmpty
        clearButton.isEnabled = !row.isDisabled
    }

    @objc
    func clear() {
        row.value = nil
        update()
    }
}

public final class LocationRow: Row<LocationCell>, RowType, PresenterRowType {
    public typealias PresenterRow = LocationNavigationController

    public var presentationMode: PresentationMode<PresenterRow>?
    public var onPresentCallback: ((FormViewController, PresenterRow) -> Void)?

    public var placeholder: String = "Location"

    public required init(tag: String?) {
        super.init(tag: tag)
    }

    public override func customDidSelect() {
        super.customDidSelect()

        guard !isDisabled else { return }

        presentationMode = PresentationMode.presentModally(controllerProvider: ControllerProvider.callback {
            let bar = LocationViewController(nibName: "LocationViewController", bundle: Bundle.current)
            return LocationNavigationController(rootViewController: bar)
            }, onDismiss: { viewController in
                viewController.presentingViewController?.dismiss(animated: true)
        })

        guard let presentationMode = presentationMode, !isDisabled else { return }

        if let controller = presentationMode.makeController() {
            controller.row = self

            onPresentCallback?(cell.formViewController()!, controller)

            controller.topViewController?.title = controller.title

            presentationMode.present(controller, row: self, presentingController: cell.formViewController()!)
        } else {
            presentationMode.present(nil, row: self, presentingController: cell.formViewController()!)
        }
    }
}

private extension Bundle {
    class var current: Bundle {
        let bundle = Bundle(for: LocationRow.self)

        guard let url = bundle.url(forResource: "LocationRow", withExtension: "bundle") else {
            return bundle
        }

        return Bundle(url: url)!
    }
}
