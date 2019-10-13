func checkHavingTests(for type: String) {
  let createdFiles = danger.git.createdFiles
  let viewModels = createdFiles.filter { $0.hasSuffix("\(type).swift") }
  let viewModelTests = createdFiles.filter { $0.hasSuffix("\(type)Tests.swift") }
  for viewModel in viewModels {
      // Check if the file doesn't require test
      let isRequiredTest = !danger.utils.readFile(viewModel).contains("// danger:notest")
      guard isRequiredTest else {
          return
      }

      let baseViewModelFileName = ((viewModel as NSString).lastPathComponent as NSString).deletingPathExtension
      let foundTest = viewModelTests.filter { (($0 as NSString).lastPathComponent as NSString).deletingPathExtension.hasPrefix(baseViewModelFileName) }
      guard foundTest.count == 0 else {
          return
      }
      warn("You have created `\(viewModel)` but there is no test `\(baseViewModelFileName)Tests.swift` found.")
  }
}
