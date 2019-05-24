# Lab 3: Preflight Tool & Replicated Installer

- Task 1: Run the Preflight Installer
- Task 2: Run the PTFE Installer
- Task 3: Complete the UI Configuration

## Task 1 : Run the Preflight Installer Tool
PTFE Preflight installer (how to)

The PTFE Preflight installer is installed locally on your instance and should be used for any concerns or considerations for the following install.

Below is an example of the hcl file the preflight tool uses :

```shell
# Hostname should be set to the hostname users use to access PTFE. This could be the instance itself, or a CNAME (or ALIAS) DNS record pointing at
# a load balancer with a certificate on it. It should match what is in the certificate below.
 hostname = "res-ptfe.hashicorp.fun"

# Certificate and Certificate Key should be set to the the location on the machine for each
# of these files. They should match the hostname of the machine defined above and not be password
# protected.
 certificate = "/etc/letsencrypt/live/res-ptfe.hashicorp.fun/fullchain.pem"
 certificate_key = "/etc/letsencrypt/live/res-ptfe.hashicorp.fun/privkey.pem"

# Often clients have their own custom CA they use for internally signed certificates. This can
# be set here if you have one.
# ca_bundle = "/etc/ssl/customCA.pem"

# Proxy settings are setup in the proxy block. While HTTP_PROXY, HTTPS_PROXY,
# and NO_PROXY can be set as an environment variable, we use the ones in the configuration
# over those and throw warnings if they do not match. The addr will be used for both HTTP_PROXY
# and HTTPS_PROXY.
# proxy {
#     http_proxy = "https://proxy.company.co:8888"
#     no_proxy = [
#         "127.0.0.1",
#         "localhost",
#     ]
# }

# In the VCS block we define which VCS servers to test network connectivity with
# For each of these the preflight tool will try to do a simple GET request using
# any SSL cert and proxy settings defined above. To add multiple VCS connections,
# simply add another VCS block.
#
# vcs "GitHub" {
#   addr = "https://github.com"
# }

 vcs "Bitbucket Enterprise - Testing" {
   addr = "http://bitbucket-server.hashicorp.engineering:7990"
 }
 ```

 Once configured, run `./ptfe-preflight example.hcl`

 If you receive `|- ✗ ERROR: unable to listen on res-ptfe.hashicorp.fun:8800: listen tcp :8800: bind: address already in use`, run `sudo pkill nginx` and try again.

## Task 2: Run the PTFE Installer

From a shell on your instance:

To execute the installer directly, run curl https://install.terraform.io/ptfe/stable | sudo bash

The installation will take a few minutes and you'll be presented with a message about how and where to access the rest of the setup via the web. This will be https://<TFE HOSTNAME>:8800.

You will see a security warning when first connecting. Choose "Self-Signed Cert" and continue.

## Task 3: Complete the UI Configuration

Upload the license file provided to you in your setup email.

Choose Online (Non-Airgapped)

Secure access to the installer dashboard. We recommend at least setting up the simple password authentication. If you're so inclined, LDAP authentication can also be configured.

The system will now perform a set of pre-flight checks on the instance and the configuration up to this point and indicate any failures. You can either fix the issues and re-run the checks, or ignore the warnings and proceed.

Set an encryption password used to encrypt the sensitive information at rest. The default value is auto-generated, but we strongly suggest you create your own password. Be sure to retain the value, because you will need to use this password to restore access to the data in the event of a reinstall. See Encryption Password for more information.

Configure the operational mode for this installation. Choose External Services. For more information on the operational modes available visit https://www.terraform.io/docs/enterprise/private/preflight-installer.html#operational-mode-decision.

In your Terraform infrastructure configuration, you were given the information necessary to fill out this section.

Provide the text version of a certificate (or certificates) that will be added to the trusted list for the product. This is used when services the product communicates with do not use globally trusted certificates but rather a private Certificate Authority (CA). This is typically used when Private Terraform Enterprise uses a private certificate (it must trust itself) or a VCS provider uses a private CA.