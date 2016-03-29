# Don't worry about SSL Certificates when fetching feeds
# Avoids OpenSSL::SSL::SSLError: SSL_connect returned=1 errno=0 state=SSLv3
# read server certificate B: certificate verify failed
# Thank you to https://gist.github.com/siruguri/66926b42a0c70ef7119e

require 'openssl'

prev_setting = OpenSSL::SSL.send(:remove_const, :VERIFY_PEER)
OpenSSL::SSL.const_set(:VERIFY_PEER, OpenSSL::SSL::VERIFY_NONE)
# do my connnection thang!
OpenSSL::SSL.send(:remove_const, :VERIFY_PEER)
OpenSSL::SSL.const_set(:VERIFY_PEER, prev_setting)