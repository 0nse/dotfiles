# Encrypts a file and appends the "gpg"-extension to the encrypted output.
# First parameter:  file name.
# Second parameter: recipient email address.
# The public key of $2 must be known; see gpg --list-keys.
# If the second parameter is missing, the first mail address with an
# associated secret key will be used for encryption.
function encrypt {
  recipient=$2
  if [[ -z $2 ]]; then
    # retrieve the first mail address for which there is a secret key:
    mailAddress=`gpg -K | sed -n 4p | awk '{print $5}'`
    # truncate: "<mailAddress>" => "mailAddress":
    recipient=${mailAddress:1:-1}
  fi
  gpg --output $1.gpg --encrypt --armor --recipient $recipient $1
}

# Decrypts a file and removes the "gpg"-extension, if any.
# Prompts for the password.
# Use gpg-agent --daemon if you want a GUI and passphrase caching.
function decrypt {
  output=$1
  if [[ $1 == *.gpg ]]; then
    output=${output%.gpg}
  fi
  if [[ $1 == *.pgp ]]; then
    output=${output%.pgp}
  fi
  gpg --output $output --decrypt $1
}
