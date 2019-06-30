# SendGrid

A GitHub Action to send email with [SendGrid](https://sendgrid.com/).

The action simply executes a Node.js script allowing you to customise sending email with the [Node.js API Library](https://github.com/sendgrid/sendgrid-nodejs).

## Usage

```
action "SendGrid" {
  uses = "peter-evans/sendgrid-action@v1.0.0"
  secrets = ["SENDGRID_API_KEY"]
}
```

#### Secrets

Set your SendGrid API key as a secret with the name `SENDGRID_API_KEY`.
If you don't have one you can sign up and get 100 emails per day for free [here](https://sendgrid.com/free/).

#### Optionally specifying the script file path

The action assumes there is a Node.js script located at `.github/sendgrid.js`.
This path can be overridden with an environment variable.

```
action "SendGrid" {
  uses = "peter-evans/sendgrid-action@v1.0.0"
  secrets = ["SENDGRID_API_KEY"]
  env = {
    SCRIPT_FILEPATH = "./some-path/email-sending-script.js"
  }
}
```

#### Example script file

The following example is a very basic use case of sending a single email to a single recipient. For more complicated use cases see the list of examples [here](https://github.com/sendgrid/sendgrid-nodejs/tree/master/use-cases).

```node
#! /usr/bin/env node

const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(process.env.SENDGRID_API_KEY);
const msg = {
    to: 'recipient@example.org',
    from: 'sender@example.org',
    subject: 'Hello world',
    text: 'Hello plain world!',
    html: '<p>Hello HTML world!</p>',
};
sgMail.send(msg);
console.log('Sent.');
```

**Note**: Your script file *must* be executable otherwise it will cause a `permission denied` error. Make it executable with this command.

```bash
chmod +x email-sending-script.js
```

## License

MIT License - see the [LICENSE](LICENSE) file for details
