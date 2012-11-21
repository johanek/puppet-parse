# = Class: parameters_rdoc
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
class parameters_rdoc (
  $param_one = true,
  $param_two = '',
  $param_three = $::fqdn,
  $param_four
) {
  # no content
}
