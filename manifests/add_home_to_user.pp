define opendai_java::add_home_to_user() {
file{
  "/etc/profile.d/java.sh":
  content => "export JAVA_HOME=/usr/java/default"
}

/*
	exec {
		"add_java_home_${name}" :
			command =>
			'echo -e "\nJAVA_HOME=/usr/java/default\nexport JAVA_HOME" > /etc/profile.bash_profile',
			cwd => "/root",
			provider => 'shell',
			unless => "grep JAVA_HOME /root/.bash_profile |grep -v '^#'"
	}
	
	exec {
    "reload_${name}_env" :
      command => "source ~/.bash_profile",
      cwd => "/root",
      provider => 'shell',
      require => Exec["add_java_home_${name}"]
  }
  
  */
}
