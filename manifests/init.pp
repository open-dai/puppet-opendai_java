# Class: opendai_java
#
# This module manages opendai_java
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class opendai_java ($distribution = 'jdk', $version = 'present', $repos) {
  validate_re($distribution, '^jdk$|^jre$|^java.*$')
  validate_re($version, 'installed|^[._0-9a-zA-Z:-]+$')

  anchor { 'opendai_java::begin': }

  anchor { 'opendai_java::end': }

  case $::operatingsystem {
    centos, redhat, oel : {
      class { 'opendai_java::package_redhat':
        version      => $version,
        distribution => $distribution,
        url          => $repos,
        require      => Anchor['opendai_java::begin'],
        before       => Anchor['opendai_java::end'],
      }
    }
    debian, ubuntu      : {
      case $::lsbdistcodename {
        squeeze, lucid  : {
          $distribution_debian = $distribution ? {
            jdk => 'openjdk-6-jdk',
            jre => 'openjdk-6-jre-headless',
          } }
        wheezy, precise : {
          $distribution_debian = $distribution ? {
            jdk => 'openjdk-7-jdk',
            jre => 'openjdk-7-jre-headless',
          } }
        default         : {
          fail("operatingsystem distribution ${::lsbdistcodename} is not supported")
        }
      }

      class { 'opendai_java::package_debian':
        version      => $version,
        distribution => $distribution_debian,
        require      => Anchor['opendai_java::begin'],
        before       => Anchor['opendai_java::end'],
      }
    }
    default             : {
      fail("operatingsystem ${::operatingsystem} is not supported")
    }
  }

  file { "/etc/profile.d/java.sh": content => "export JAVA_HOME=/usr/java/default" }
}
