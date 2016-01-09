require 'serverspec'


def windows?
  (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil
end

if !windows?
  set :backend, :exec
else
  set :backend, :cmd
  set :os, :family => 'windows'
  set :architecture, :x86_64
end