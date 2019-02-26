// Copyright © 2019 Chamitha Wijesekera. All rights reserved.

import CoreLocation
import Eureka
import Foundation

public final class LocationCell: PushSelectorCell<CLPlacemark> {
    @IBOutlet public var clearButton: UIButton! {
        didSet {
            clearButton.setImage(UIImage(named: "Clear", in: Bundle.current, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
            clearButton.tintColor = .lightGray
        }
    }

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    public override func update() {
        super.update()

        detailTextLabel?.text = nil
        accessoryType = .none

        guard let row = self.row as? LocationRow else { return }

        textLabel?.text = row.value?.name ?? row.placeholder
        textLabel?.textColor = row.value?.name != nil ? .black : UIColor(red: 198 / 255, green: 198 / 255, blue: 204 / 255, alpha: 1)

        clearButton.isHidden = row.value?.name == nil
    }

    @IBAction func clear(_: Any) {
        row.value = nil
        update()
    }
}

public final class LocationRow: Row<LocationCell>, RowType, PresenterRowType {
    public typealias PresenterRow = LocationViewController

    public var presentationMode: PresentationMode<PresenterRow>?
    public var onPresentCallback: ((FormViewController, PresenterRow) -> Void)?

    public var placeholder: String = "Location"

    public required init(tag: String?) {
        super.init(tag: tag)

        cellProvider = CellProvider<LocationCell>(nibName: "LocationCell", bundle: Bundle.current)
    }

    public override func customDidSelect() {
        super.customDidSelect()

        guard let controller = makeController() else { return }

        presentationMode = PresentationMode.show(controllerProvider: ControllerProvider.callback {
            controller
        }, onDismiss: { viewController in
            _ = viewController.navigationController?.popViewController(animated: true)
        })

        guard let presentationMode = presentationMode, !isDisabled else { return }

        if let controller = presentationMode.makeController() {
            controller.row = self
            onPresentCallback?(cell.formViewController()!, controller)
            presentationMode.present(controller, row: self, presentingController: cell.formViewController()!)
        } else {
            presentationMode.present(nil, row: self, presentingController: cell.formViewController()!)
        }
    }

    private func makeController() -> LocationViewController? {
        return LocationViewController(nibName: "LocationViewController", bundle: Bundle.current)
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
