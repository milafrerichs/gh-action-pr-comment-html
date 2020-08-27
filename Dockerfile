FROM ruby:2.7-alpine

LABEL "com.github.actions.name"="PR Comment"
LABEL "com.github.actions.description"="Leaves a comment on an open PR based on the contents of a file."
LABEL "com.github.actions.repository"="https://github.com/milafrerichs/pr-comment-html-body"
LABEL "com.github.actions.maintainer"="Mila Frerichs <awmatheson@github.com>"
LABEL "com.github.actions.icon"="message-square"
LABEL "com.github.actions.color"="black"

RUN gem install octokit
RUN gem install nokogiri

COPY lib /action/lib

CMD ["ruby", "/action/lib/comment.rb"]
