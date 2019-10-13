import Danger
import Foundation

let danger = Danger()

// Check swiftlint.
SwiftLint.lint(configFile: "Tools/.swiftlint.yml")

// Check for big PR.
if danger.git.createdFiles.count + danger.git.modifiedFiles.count - danger.git.deletedFiles.count > 300 {
    warn("Big PR, try to keep changes smaller if you can")
}

// Check if there are new ViewModels/Services/Managers but no unit tests.
// fileImport: Tools/DangerExtensions/UnitTestsCheck.swift
checkHavingTests(for: "ViewModel")
checkHavingTests(for: "Service")
checkHavingTests(for: "Manager")

// Check if signing settings in project files are changed
// fileImport: Tools/DangerExtensions/SigningSettingsCheck.swift
checkChangingSigningSettings()
