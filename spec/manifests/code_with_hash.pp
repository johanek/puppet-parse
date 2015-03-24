# = Class: code with hash
#
# A class for testing puppet-parse
#
# == Requirements
#
# None
#
# == Parameters
#
# [*param_one*]
#    Param1 documentation text
class code_with_hash ( 
  $param_one = true,
  $param_two = '',
  $param_three = $::fqdn,
  $param_four
) {
  $myhash = { key       => "some value" }
#              other_key => "some other value" }
}
