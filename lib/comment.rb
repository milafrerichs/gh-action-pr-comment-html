
require "json"
require "octokit"
require "nokogiri"

def read_json(path)
  JSON.parse(File.read(path))
end

@event_json = read_json(ENV['GITHUB_EVENT_PATH']) if ENV['GITHUB_EVENT_PATH']
@github_data = {
  sha: ENV['GITHUB_SHA'],
  token: ENV['INPUT_TOKEN'],
  owner: ENV['GITHUB_REPOSITORY_OWNER'] || @event_json.dig('repository', 'owner', 'login'),
  repo: ENV['GITHUB_REPOSITORY_NAME'] || @event_json.dig('repository', 'name')
}

github = Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])

repo = @event_json["repository"]["full_name"]

if ENV["GITHUB_EVENT_NAME"] == "pull_request"
  pr_number = @event_json["number"]
else
  pulls = github.pull_requests(repo, state: "open")

  push_head = @event_json["after"]
  pr = pulls.find { |pr| pr["head"]["sha"] == push_head }

  pr_number = pr["number"]
end

file_path = ENV['INPUT_PATH']
html_path = ENV["INPUT_HTML_PATH"] || "body"

puts Dir.entries(".")

doc = Nokogiri::HTML(File.open(file_path))
message = doc.xpath("//#{html_path}").to_s

github.issue_comments(repo, pr_number)

github.add_comment(repo, pr_number, message)
