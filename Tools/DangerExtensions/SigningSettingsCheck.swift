func checkChangingSigningSettings() {
  let changedFiles = danger.git.createdFiles + danger.git.modifiedFiles
  let projectFiles = changedFiles.filter { $0.fileType == .pbxproj}
  guard projectFiles.count == 0 else {
      return
  }

  for projectFile in projectFiles {
      warn("You have changed project file `\(projectFile)`. Are you sure?")
  }
}
