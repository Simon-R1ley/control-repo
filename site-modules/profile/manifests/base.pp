# The base profile should include component modules that will be on all nodes
class profile::base {
  include windows
  include linux
  # Base profile on fact of node if win or lin
  # https://www.puppet.com/docs/puppet/6/lang_conditional.html
  # include base::windows
  # include base::linux
case $notify['kernel'] ['name']

}
