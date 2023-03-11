# New Package for Stacked

Created from the `package-template`.

After creating the repository, proceed with the following instructions:

- Update the repository settings to adhere to the conventions:
  - Allow squash&merge commits.
  - Suggest update.
  - Require linear history.
- Add branch protection rules:
  - Require pull request reviews before merging.
  - Require status checks to pass before merging.
  - Allow the user with the DEPLOY token secret to overwrite pull request.
- Create the flutter package with `flutter create -t package --project-name NAME .`
- Update the content in the `README` file.
