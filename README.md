# PR Comment HTML Action

A GitHub action to comment with parts of an html file you specify.  
I use this to comment the body of a coverage report.

## Usage

- Requires the `GITHUB_TOKEN` secret.
- Supports `push` and `pull_request` event types.

### Sample workflow

```
name: example
on: pull_request
jobs:
  example:
    name: example
    runs-on: ubuntu-latest
    steps:
      - name: comment PR
        uses: milafrerichs/pr-comment@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          path: anyhtmlfileinyourrepo.html
					html_path: "body"
```

### ToDo
- [ ] update the comment instead of generating a new one
- [ ] have a template to update the workflow description


### Inspired by
Inspired by a lot of gh actions but mainly these two:
https://github.com/devmasx/coverage-check-action
https://github.com/machine-learning-apps/pr-comment
