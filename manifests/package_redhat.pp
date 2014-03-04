# Class: opendai_java::package_redhat
#
# Implementation class of the Java package
# for redhat based systems.
#
# This class is not meant to be used by the end user
# of the module. It is an implementation class
# of the composite Class[java]
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class opendai_java::package_redhat ($version, $distribution,$url) {
  case $::architecture {
    'X86_64' : {
      exec { "download /tmp/sun-java.bin":
        command => "/usr/bin/wget --quiet --output-document=/tmp/sun-java.bin 'http://${url}/${distribution}-${version}-linux-x64-rpm.bin'",
        creates => "/tmp/sun-java.bin",
        # 			  unless => "/usr/bin/java -version 2>&1 | /bin/grep 'java version' | /bin/awk '{print $3}' | /usr/bin/tr -d
        #      \"|/usr/bin/test '1.6.0_25' ",
        timeout => 900,
      }
      # 		download {
      # 			"/tmp/sun-java.bin" :
      # 				uri =>
      # 				"http://${puppet_master}/${distribution}-${version}-linux-x64-rpm.bin",
      # 				unless => "java -version 2>&1 | grep 'java version' | awk '{print $3}' | tr -d \"|test '1.6.0_25' ",
      # 				timeout => 900 ;
      # 		}
    }
    default  : {
      download { "/tmp/sun-java.bin":
        uri     => "http://${::puppet_master}/${distribution}-${version}-linux-i586-rpm.bin",
        timeout => 900;
      }
    }
  }

  exec { "executable":
    command => "/bin/chmod +x /tmp/sun-java.bin",
    # 		unless => "/usr/bin/java -version 2>&1 | /bin/grep 'java version' | /bin/awk '{print $3}' | /usr/bin/tr -d \"|/usr/bin/test
    #   '1.6.0_25' ",
    require => Exec['download /tmp/sun-java.bin']
  }

  exec { "install-java":
    command => "/tmp/sun-java.bin",
    # 		unless => "/usr/bin/java -version 2>&1 | /bin/grep 'java version' | /bin/awk '{print $3}' | /usr/bin/tr -d \"|/usr/bin/test
    #   '1.6.0_25' ",
    require => Exec['executable']
  }
  
 # exec { "clean":
 #   command => "/bin/rm /tmp/sun-java.bin",
    # 		unless => "/usr/bin/java -version 2>&1 | /bin/grep 'java version' | /bin/awk '{print $3}' | /usr/bin/tr -d \"|/usr/bin/test
    #   '1.6.0_25' ",
 #   require => Exec['install-java']
 # }
}
