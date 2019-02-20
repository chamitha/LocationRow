// Copyright © 2019 Chamitha Wijesekera. All rights reserved.

import Eureka
import Foundation
import MapKit

public final class LocationViewController: UIViewController, TypedRowControllerType {
    public var row: RowOf<CLPlacemark>!
    public var onDismissCallback: ((UIViewController) -> Void)?

    public var placeholder: String?

    @IBOutlet var tableView: UITableView!

    private let searchController = UISearchController(searchResultsController: nil)
    private var searchResults: [MKMapItem] = []

    public override func viewDidLoad() {
        super.viewDidLoad()

        searchController.searchResultsUpdater = self

        searchController.dimsBackgroundDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false

        searchController.searchBar.placeholder = placeholder ?? "Enter Location"

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false

        tableView.delegate = self
        tableView.dataSource = self

        definesPresentationContext = true
    }

    private func address(for placemark: MKPlacemark) -> String {
        let address: [String?] = [
            [placemark.subThoroughfare, placemark.thoroughfare].compactMap { $0 }.joined(separator: " "),
            [placemark.locality, placemark.administrativeArea, placemark.postalCode].compactMap { $0 }.joined(separator: " "),
            placemark.country,
        ]

        return address.compactMap {
            if $0 == nil { return $0 }
            if $0!.isEmpty { return nil }
            return $0
        }.joined(separator: ", ")
    }
}

// MARK: - UISearchResultsUpdating Delegate

extension LocationViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        guard let searchString = searchController.searchBar.text?.trimmingCharacters(in: CharacterSet.whitespaces) else { return }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchString

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, _ in
            guard let response = response else { return }

            self?.searchResults = response.mapItems
            self?.tableView.reloadData()
        }
    }
}

extension LocationViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")

        let placemark = searchResults[indexPath.row].placemark

        cell.textLabel?.text = placemark.name
        cell.detailTextLabel?.text = address(for: placemark)

        return cell
    }

    public func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return searchResults.count
    }
}

extension LocationViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row.value = searchResults[indexPath.row].placemark

        navigationController?.popViewController(animated: true)
    }
}
