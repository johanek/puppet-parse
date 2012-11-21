# = Define: test
#
# A define for testing puppet-parse
#
# == Requirements
#
# None
#
# == Parameters
#
# [*param_one*]
#    Param1 documentation text
define test (
  $param_one = true,
  $param_two = '',
  $param_three = $::fqdn,
  $param_four
) {
  # no content
}
