include jenkins

jenkins::plugin {
  "git": ;
}

jenkins::plugin {
  "mercurial": ;
}

jenkins::plugin {
  "xunit": ;
}

package {'mercurial':
  ensure => installed
}

package {'git':
  ensure => installed
}
