# Policyfile.rb - Describe how you want Chef to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

name 'cerny-loadbalancer'
run_list 'cerny-loadbalancer::default'

default_source :supermarket
cookbook 'cerny-loadbalancer', path: '..'
