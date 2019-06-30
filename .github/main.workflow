workflow "Send email" {
  on = "push"
  resolves = ["SendGrid"]
}

action "SendGrid" {
  uses = "./"
  secrets = ["SENDGRID_API_KEY"]
}
