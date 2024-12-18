// This Source Code Form is subject to the terms of the Mozilla Public
// License, v. 2.0. If a copy of the MPL was not distributed with this
// file, You can obtain one at http://mozilla.org/MPL/2.0/

import Foundation
import Common

final class BookmarksFolderEmptyStateView: UIView, ThemeApplicable {
    private struct UX {
        static let a11yTopMargin: CGFloat = 16
        static let TitleTopMargin: CGFloat = 16
        static let BodyTopMargin: CGFloat = 8
        static let ContentLeftRightMargins: CGFloat = 16
        static let StackViewWidthMultiplier: CGFloat = 0.9
        static let imageWidth: CGFloat = 200
    }

    private lazy var logoImage: UIImageView = .build { imageView in
        imageView.contentMode = .scaleAspectFit
    }

    private lazy var titleLabel: UILabel = .build { label in
        label.textAlignment = .center
        label.font = FXFontStyles.Bold.headline.scaledFont()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
    }

    private lazy var bodyLabel: UILabel = .build { label in
        label.textAlignment = .center
        label.font = FXFontStyles.Regular.body.scaledFont()
        label.numberOfLines = 0
        label.adjustsFontForContentSizeCategory = true
    }

    private lazy var stackViewWrapper: UIStackView = .build { stackView in
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 0
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(isRoot: Bool) {
        titleLabel.text = isRoot ? .Bookmarks.EmptyState.Root.Title : .Bookmarks.EmptyState.Nested.Title
        bodyLabel.text = isRoot ? .Bookmarks.EmptyState.Root.Body : .Bookmarks.EmptyState.Nested.Body
        logoImage.image = UIImage(named: isRoot ? ImageIdentifiers.noBookmarksInRoot : ImageIdentifiers.noBookmarksInFolder)
    }

    private func setupLayout() {
        stackViewWrapper.addArrangedSubview(logoImage)
        stackViewWrapper.setCustomSpacing(UX.TitleTopMargin, after: logoImage)
        stackViewWrapper.addArrangedSubview(titleLabel)
        stackViewWrapper.setCustomSpacing(UX.BodyTopMargin, after: titleLabel)
        stackViewWrapper.addArrangedSubview(bodyLabel)
        addSubview(stackViewWrapper)

        let aspectRatio = (logoImage.image?.size.height ?? 1) / (logoImage.image?.size.width ?? 1)
        NSLayoutConstraint.activate([
            stackViewWrapper.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: UX.a11yTopMargin),
            stackViewWrapper.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            stackViewWrapper.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackViewWrapper.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackViewWrapper.widthAnchor.constraint(equalTo: widthAnchor, multiplier: UX.StackViewWidthMultiplier),

            titleLabel.leadingAnchor.constraint(
                equalTo: stackViewWrapper.leadingAnchor, constant: UX.ContentLeftRightMargins),
            titleLabel.trailingAnchor.constraint(
                equalTo: stackViewWrapper.trailingAnchor, constant: -UX.ContentLeftRightMargins),

            bodyLabel.leadingAnchor.constraint(
                equalTo: stackViewWrapper.leadingAnchor, constant: UX.ContentLeftRightMargins),
            bodyLabel.trailingAnchor.constraint(
                equalTo: stackViewWrapper.trailingAnchor, constant: -UX.ContentLeftRightMargins),

            logoImage.widthAnchor.constraint(equalToConstant: UX.imageWidth),
            logoImage.heightAnchor.constraint(equalTo: logoImage.widthAnchor, multiplier: aspectRatio)
        ])
    }

    // MARK: ThemeApplicable
    func applyTheme(theme: Theme) {
        titleLabel.textColor = theme.colors.textPrimary
        bodyLabel.textColor = theme.colors.textPrimary
    }
}
