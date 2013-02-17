directory '/var/lib/stud' do
  owner 'root'
  group 'root'
  mode '700'
end

# Force the owner and permissions to be safe
file '/etc/ssl/private/python.org.pem' do
  owner 'root'
  group 'root'
  mode '600'
  only_if { ::File.exists?('/etc/ssl/private/python.org.pem') }
end

stud 'stud' do
  version '19a7f1'
  pem_file '/etc/ssl/private/python.org.pem'
  frontend '[*]:443'
  tls false
  ssl true
  ciphers 'ECDHE-RSA-RC4-SHA:ECDHE-RSA-AES128-SHA256:AES128-GCM-SHA256:RC4:HIGH:!MD5:!aNULL:!EDH'
  prefer_server_ciphers true
  user 'nobody'
  group 'nogroup'
  chroot '/var/lib/stud'
  syslog true
  write_proxy true
end
