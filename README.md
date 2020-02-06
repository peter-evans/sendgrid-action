# SendGrid Action
[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-SendGrid%20Action-blue.svg?colorA=24292e&colorB=0366d6&style=flat&longCache=true&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAYAAAAfSC3RAAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAAM6wAADOsB5dZE0gAAABl0RVh0U29mdHdhcmUAd3d3Lmlua3NjYXBlLm9yZ5vuPBoAAAERSURBVCiRhZG/SsMxFEZPfsVJ61jbxaF0cRQRcRJ9hlYn30IHN/+9iquDCOIsblIrOjqKgy5aKoJQj4O3EEtbPwhJbr6Te28CmdSKeqzeqr0YbfVIrTBKakvtOl5dtTkK+v4HfA9PEyBFCY9AGVgCBLaBp1jPAyfAJ/AAdIEG0dNAiyP7+K1qIfMdonZic6+WJoBJvQlvuwDqcXadUuqPA1NKAlexbRTAIMvMOCjTbMwl1LtI/6KWJ5Q6rT6Ht1MA58AX8Apcqqt5r2qhrgAXQC3CZ6i1+KMd9TRu3MvA3aH/fFPnBodb6oe6HM8+lYHrGdRXW8M9bMZtPXUji69lmf5Cmamq7quNLFZXD9Rq7v0Bpc1o/tp0fisAAAAASUVORK5CYII=)](https://github.com/marketplace/actions/sendgrid-action)

A GitHub Action to send email with [SendGrid](https://sendgrid.com/).

The action executes a Node.js script allowing you to customise sending email with the [Node.js API Library](https://github.com/sendgrid/sendgrid-nodejs).

## Usage

```yml
    - name: SendGrid
      uses: peter-evans/sendgrid-action@v1
      env:
        SENDGRID_API_KEY: ${{ secrets.SENDGRID_API_KEY }}
```

#### Secrets

Set your SendGrid API key as a secret with the name `SENDGRID_API_KEY`.
If you don't have one you can sign up and get 100 emails per day for free [here](https://sendgrid.com/free/).

#### Optionally specifying the script file path

The action assumes there is a Node.js script located at `.github/sendgrid.js`.
This path can be overridden with an environment variable.

```yml
    - name: SendGrid
      uses: peter-evans/sendgrid-action@v1
      env:
        SENDGRID_API_KEY: ${{ secrets.SENDGRID_API_KEY }}
        SCRIPT_FILEPATH: ./some-path/email-sending-script.js
```

#### Example script files

The following examples are quite basic use cases. For more complicated use cases see the list of examples [here](https://github.com/sendgrid/sendgrid-nodejs/tree/master/use-cases).

Sending a single email to a single recipient:
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

sgMail
    .send(msg)
    .then(() => console.log('Mail sent successfully'))
    .catch(error => console.error(error.toString()));
```

Sending an attachment:
```node
#! /usr/bin/env node

const sgMail = require('@sendgrid/mail');
sgMail.setApiKey(process.env.SENDGRID_API_KEY);

const fs = require('fs'),
    filename = 'hello-world.pdf',
    fileType = 'application/pdf',
    data = fs.readFileSync('attachments/' + filename);

const msg = {
    to: 'recipient@example.org',
    from: 'sender@example.org',
    subject: 'Hello world',
    text: 'Hello plain world!',
    html: '<p>Hello HTML world!</p>',
    attachments: [
        {
            content: data.toString('base64'),
            filename: filename,
            type: fileType,
            disposition: 'attachment',
        },
    ],
};

sgMail
    .send(msg)
    .then(() => console.log('Mail sent successfully'))
    .catch(error => console.error(error.toString()));
```

**Note**: Your script file *must* be executable otherwise it will cause a `permission denied` error. Make it executable with this command.

```bash
chmod +x email-sending-script.js
```

## License

[MIT](LICENSE)
