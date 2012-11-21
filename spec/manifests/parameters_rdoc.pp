# = Class: test
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
class test (
  $param_one = true,
  $param_two = '',
  $param_three = $::fqdn,
  $param_four
) {
  # no content
}
