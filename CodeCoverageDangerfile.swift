import Danger
import DangerSwiftCoverage
import Foundation

// Gather coverage for modified files
Coverage.xcodeBuildCoverage(.derivedDataFolder("./.build/DerivedData"),
                            minimumCoverage: 50,
                            excludedTargets: [])
