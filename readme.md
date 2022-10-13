## A wordle first guess finder

Paste in your wordle results and this app will attempt to establish what word you use for your first guess

Incomplete:
- Needs error handling
- Looks terrible at the moment, lots CSS needed!

### Features to add
- error handling!
- ability to flag up incompatible character lists (ie first-guess has changed from one game to the next)

### Notes
- Running on Elastic Beanstalk, built using CloudFormation via the CDK.
    - git archive -v -o ../schnurdle-elb-infra/gitapp.zip --format=zip HEAD zip package up for deployment
    - npx cdk deploy - push new app version

### Questions / Issues:

- How to update part of the page instead of rendering a new page for every new bit of results