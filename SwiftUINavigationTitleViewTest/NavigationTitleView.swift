
import SwiftUI

extension View {

    func navigationBarTitleView<V: View>(
        displayMode: NavigationBarItem.TitleDisplayMode = .automatic,
        @ViewBuilder view: () -> V
    ) -> some View {
        background(NavigationTitleViewController(displayMode: displayMode, titleView: view()))
    }
}

// This is a hack to set the parent's navigation item's title view.
private final class NavigationTitleViewController<V: View>: UIViewController {

    let titleView: V
    let displayMode: NavigationBarItem.TitleDisplayMode

    init(displayMode: NavigationBarItem.TitleDisplayMode, titleView: V) {
        self.displayMode = displayMode
        self.titleView = titleView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func willMove(toParent parent: UIViewController?) {

        switch displayMode {
        case .automatic: parent?.navigationItem.largeTitleDisplayMode = .automatic
        case .inline: parent?.navigationItem.largeTitleDisplayMode = .never
        case .large: parent?.navigationItem.largeTitleDisplayMode = .always
        @unknown default: parent?.navigationItem.largeTitleDisplayMode = .automatic
        }

        let uiTitleView = UIHostingController(rootView: titleView).view!
        uiTitleView.backgroundColor = .clear
        parent?.navigationItem.titleView = uiTitleView

        super.willMove(toParent: parent)
    }
}

extension NavigationTitleViewController: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationTitleViewController>) -> UIViewController { self }
    func updateUIViewController(_ viewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationTitleViewController>) {}
}
