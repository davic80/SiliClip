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

        let q = NSMetadataQuery()
        q.predicate = NSPredicate(format: "%K == YES", "kMDItemIsScreenCapture")
        q.searchScopes = [NSMetadataQueryUserHomeScope]
        q.notificationBatchingInterval = 1.0

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(queryDidUpdate(_:)),
            name: .NSMetadataQueryDidUpdate,
            object: q
        )

        query = q
        q.start()
    }

    func stop() {
        guard let q = query else { return }
        NotificationCenter.default.removeObserver(self, name: .NSMetadataQueryDidUpdate, object: q)
        q.stop()
        query = nil
    }

    @objc private func queryDidUpdate(_ notification: Notification) {
        guard isEnabled,
              let addedItems = notification.userInfo?[NSMetadataQueryUpdateAddedItemsKey] as? [NSMetadataItem]
        else { return }

        addedItems.forEach { delegate?.screenShotObserver(self, addedItem: $0) }
    }
}
