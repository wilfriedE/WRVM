WRVM [Windows Ruby Version Management ]
====

NOTE: At this stage, this is only meant to be used for personal environement setup on Windows. Help us improve it for better user experience. 

=Setup

Extract into C:/WRVM
Add C:/WRVM to paths

Run WRVM setup

=Installing Rubies

Run WRVM install rubies
	--A list of options will appear. Choose which one to install

=Updates 

If the list of rubies does not include your version of ruby your looking for:

Run WRVM update
	-- This should update the ruby packages available. From here you should be able to install which ever ruby you want. 
	If the options available does not include your version of ruby, submit a PR (Pull Request with your version). We will get to it as soon as possible

=Selecting default ruby

Run WRVM use
	-- A list of options will appear. Choose which ruby you wish as your current default.

=Using Ruby

Use ruby as you would normaly do from this point.

-------------------------------------------------

Contributions extremely welcomed. 


TODO: 
	-Uninstall
	-Use Yaml file (record.yaml), to check instalation steps
	-Download zip files externaly [remotely from a website.]
	-Make a Wishlist