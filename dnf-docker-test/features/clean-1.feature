Feature: DNF/Behave test (clean - host)

Scenario: Ensure that metadata are unavailable after "dnf clean all"
  Given I use the repository "test-1"
  When I create a file "/etc/yum.repos.d/test-1.repo" with content: "[test-1]\nname=test-1\nbaseurl=file:///var/www/html/repo/test-1\nenabled=1\ngpgcheck=0\nskip_if_unavailable=False"
  When I execute "dnf" command "makecache" with "success"
  Then I execute "dnf" command "-y -C install TestB" with "success"
  Then transaction changes are as follows
   | State        | Packages   |
   | installed    | TestB      |
  When I execute "dnf" command "clean all" with "success"
  Then I execute "dnf" command "-y -C install TestC" with "fail"
  Then transaction changes are as follows
   | State        | Packages   |
   | absent       | TestC      |
  # Cleaning after scenario
  When I execute "dnf" command "-y remove TestB" with "success"
  Then transaction changes are as follows
   | State        | Packages   |
   | removed      | TestB      |
