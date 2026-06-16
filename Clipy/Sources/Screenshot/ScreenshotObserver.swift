import AppKit

protocol ScreenShotObserverDelegate: AnyObject {
    func screenShotObserver(_ observer: ScreenShotObserver, addedItem item: NSMetadataItem)
}

/// Detects new screenshots using Spotlight metadata queries.
/// Drop-in replacement for the archived Screeen library.
final class ScreenShotObserver: NSObject {

    weak var delegate: ScreenShotObserverDelegate?
    var isEnabled = false

    private var query: NSMetadataQuery?

    func start() {
        guard query == nil else { return }

        let metadataQuery = NSMetadataQuery()
        metadataQuery.predicate = NSPredicate(format: "%K == YES", "kMDItemIsScreenCapture")
        metadataQuery.searchScopes = [NSMetadataQueryUserHomeScope]
        metadataQuery.notificationBatchingInterval = 1.0

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(queryDidUpdate(_:)),
            name: .NSMetadataQueryDidUpdate,
            object: metadataQuery
        )

        query = metadataQuery
        metadataQuery.start()
    }

    func stop() {
        guard let activeQuery = query else { return }
        NotificationCenter.default.removeObserver(self, name: .NSMetadataQueryDidUpdate, object: activeQuery)
        activeQuery.stop()
        query = nil
    }

    @objc private func queryDidUpdate(_ notification: Notification) {
        guard isEnabled,
              let addedItems = notification.userInfo?[NSMetadataQueryUpdateAddedItemsKey] as? [NSMetadataItem]
        else { return }

        addedItems.forEach { delegate?.screenShotObserver(self, addedItem: $0) }
    }
}
