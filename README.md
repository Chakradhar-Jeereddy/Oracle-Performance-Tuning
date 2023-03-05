Practice 1 - Preparing Practice Environment

Preparing Practice Environment
You will build the following virtual machine:
This machine is a Linux 6.7 x64-bit based with Oracle database 12c R2 database installed on it.

VirtualBox.
• Create an Oracle VirtualBox Appliance, Linux-based machine named srv1
• Install Oracle database software (12.2) in srv1 and create an Oracle Database (named ORADB) in it
• Set up Order Entry Schema (soe) in ORADB database
• (optional) Install Swingbench in the hosting PC
• Learn about creating and deleting snapshots in Oracle VirtualBox
• Set up Order Entry Schema (soe)
Practice Environment Requirements
Following are the requirements to prepare the practice environment. All those items must be available before you start with the practice.
Item Type Description
PC machine hardware A PC with Windows 7, 8 or 10 64-bit installed on it to host the

virtual machines.
Following are the required specifications:
Memory: 8 GB or more
Storage free space: 60 GB or more
This PC will be referred to in the course practices as the hosting PC.
Oracle VirtualBox, release 5.1.x
software Software to create virtual machines (called virtual appliances)
Note: You can use Oracle VirtualBox release 5.2.x. But there will be difference between it and the screenshots used in the course practice documents.
Release 5.1 can be downloaded from this link.
Release 5.2 can be downloaded from this link.

Putty software A program which provides a command line prompt to connect toa Linux server from Windows Can be downloaded from this link.
Swingbench 2.5
(optional)
software Download Swingbench from one of the following sources:
• Course downloadable resources section
OR
• Dominic Giles portal
Java Runtime for Windows
(optional)
software Java runtime JRE 1.8 for Windows 64-bit should be installed on your hosting PC. It will be used by the Swingbench software
Can be downloaded from this link.

Oracle Database
12c R2
(12.2.0.1.0) for Linux x86 64-bit software To be installed in the Linux-based VirtualBox Appliance.
link
Oracle Database 12c Client (R1 or R2) for Windows (Only if you need Swingbench)
software To be installed on the hosting PC.
link

Practice 1 - Preparing Practice Environment Page | 3
Create Oracle VirtualBox Appliance
A. Install the Software on the Hosting PC
1. Install the following software in the hosting PC:
• Oracle VirtualBox, release 5.1.
• Putty
• Java Runtime 1.8
• Oracle Database Client (R1 or R2) for Windows (only if you want to use Swingbench)
In the course code examples, it is assumed that Oracle Database client is installed in the
directory D:\oracle\product\12.1.0\client_1. In the course code examples, you need to
change that directory to the Oracle Database client home directory in your PC.
B. Create an Oracle Linux 6.7 64-bit VirtualBox appliance
In the following steps, you will create an Oracle VirtualBox Linux appliance.
2. Create a Linux-based VirtualBox appliance with the specifications as shown in the table below.
• You can download pre-built appliance from my website at this link (its size is 3.3 GB). This is
an Oracle VirtualBox appliance which has a fresh installation of Oracle Linux 6.7 installed on it.
Please read the readme file on my web site to obtain details about the appliance including
the root password.
OR
• You can create the VirtualBox appliance from scratch. The procedure to create it from scratch
is documented here, or you can watch it in my channel at YouTube here.
Item Value
Hostname srv1
Memory 4 GB
Operating system Oracle Linux 6.7
3. If you use the pre-built VirtualBox appliance, make sure to disable the Linux Automatic Update by
performing the following: login as root -> System -> Preferences -> Software updates:
Check for updates: Never, Automatically install: Nothing
Linux Automatic Update makes an update on the virtual machine that conflicts with downloaded
Oracle software release.
Practice 1 - Preparing Practice Environment Page | 4
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
4. If you are using a pre-built copy of the virtual machine (like the one available in my web site),
make sure the Guest Additions version is upgraded to the version of the VirtualBox you are using.
The pre-built virtual machine that is available in my site was created using version 5.1.12. If you
are using a later version of Oracle VirtualBox, you should update its VirtualBox Guest Additions.
To Update the VirtualBox Guest Additions in the virtual machine, perform the following steps:
a. In the VirtualBox window, login as root and click on Devices menu | Insert Guest Additions
CD image.
b. When the following window pops up, click on OK button
c. Wait for the installation to finish.
d. Reboot the machine and login to it as root.
e. Right click on the VirtualBox Additions CD icon and select Eject option.
Practice 1 - Preparing Practice Environment Page | 5
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
5. Shutdown srv1 and click on Settings -> click on "Network" link from the left hand side pane ->
click on "Adapter 1" tab -> set "Attached to" to "Bridged Adapter".
6. Proceed with making more modifications on the settings of srv1 as follows:
a. Click on "General", "Advanced" tab, and set the "Shared Clipboard" to "Bidirectional".
b. Disable the audio card using "Audio" link (optional). Then press "OK" button.
Practice 1 - Preparing Practice Environment Page | 6
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
7. If you have a firewall software installed into your hosting PC, configure it to allow the traffic to go
to and come from Oracle VirtualBox application or disable it.
8. Start srv1, login to it as root
9. Make sure the firewall is disabled: Linux Main menu | System | Administration | Firewall. Click
on Disable icon, then on Apply button.
10. Obtain the IP address assigned to srv1 by performing the following:
a. In the VirtualBox appliance window, open the Network Connections window
System | Preferences | Network Connections
b. Click on eth0, Edit button, make sure the "Connect automatically" check box is marked,
Change its “Connection Name” to eth0.
c. Click on IPv4 Settings tab, make sure the method is set to "Automatic (DHCP)". This
adapter will take its IP address from your network and it should get the connection to the
Internet through this connection.
d. Click on Apply button and click on Close button.
e. Open a terminal window and obtain the IP address assigned to eth0 and take a note of it.
ifconfig
f. Make sure that the VM machine is connected to the Internet, ping google.com
ping -c 3 google.com
11. In srv1 appliance, configure the /etc/hosts file as follows. Replace the IP addresses in the code
with the IP addresses of your environment.
vi /etc/hosts
127.0.0.1 localhost localhost.localdomain
192.168.1.163 srv1.localdomain srv1
To test the configuration:
ping -c 3 srv1
12. In the hosting PC, make sure srv1 replies to the ping command.
ping 192.168.1.163
Practice 1 - Preparing Practice Environment Page | 7
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
C. Configure Putty
13. Open PuTTY then configure a connection to srv1.
14. Set the KeepAlive setting to 9 seconds.
15. Save the connection configuration.
16. Open the connection and test it.
Practice 1 - Preparing Practice Environment Page | 8
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
D. Create and Set Staging Directory
In the following steps you will create a staging directory in the hosting PC. This directory will be used
by the VirtualBox appliance srv1.
Staging directories is useful for the appliances to save temporary files in them. This approach is better
than saving the files directly in the appliances themselves because it saves disk space in the
appliance.
17. Shutdown srv1.
18. In your hosting machine, under the disk drive letter that has the most free disk space, create a
staging directory.
The code examples in the practice document assumes that the staging directory is as follows.
Whenever you see in the practice steps a reference to this directory, replace it with the one that
you created in your PC.
D:\staging\Linux
19. In VirtualBox Manager, open the "Settings" of srv1, click on "Shared Folders" link in the
right-hand pane. Add shared folder by pressing "plus" icon. Then select path to
D:\staging\Linux, and mark the "Auto-mount" box. Change the "Folder Name" to "extdisk"
20. Start srv1 and add oracle to vboxsf group. This group has privilege to access the shared folder.
a. In the VirtualBox window, login as root
b. Open a terminal window and execute the following command to make sure the shared folder
is seen by the appliance:
ls -ld /media/sf_extdisk/
c. Add oracle to vboxsf group.
usermod -a -G vboxsf oracle
Note: In all the course practices, the directory that you created in this section is referred to as the
staging directory.
Practice 1 - Preparing Practice Environment Page | 9
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
Create an Oracle Database in srv1
In the following steps, you will create an Oracle 12c R2 in srv1 machine.
E. Configure the Oracle software owner
21. Open Putty and login to srv1 as oracle user
22. Set the OS environment variables in the oracle user profile:
su – oracle
mv ~/.bash_profile ~/.bash_profile_bk
vi ~/.bash_profile
# .bash_profile
if [ -f ~/.bashrc ]; then
. ~/.bashrc
fi
ORACLE_SID=ORADB; export ORACLE_SID
ORACLE_BASE=/u01/app/oracle; export ORACLE_BASE
ORACLE_HOME=$ORACLE_BASE/product/12.2.0/db_1; export ORACLE_HOME
ORACLE_TERM=xterm; export ORACLE_TERM
NLS_DATE_FORMAT="DD-MON-YYYY HH24:MI:SS"; export NLS_DATE_FORMAT
TNS_ADMIN=$ORACLE_HOME/network/admin; export TNS_ADMIN
PATH=.:${PATH}:$ORACLE_HOME/bin
PATH=${PATH}:/usr/bin:/bin:/usr/local/bin
export PATH
LD_LIBRARY_PATH=$ORACLE_HOME/lib
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$ORACLE_HOME/oracm/lib
LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/lib:/usr/lib:/usr/local/lib
export LD_LIBRARY_PATH
export TEMP=/tmp
export TMPDIR=/tmp
export EDITOR=vi
umask 022
Practice 1 - Preparing Practice Environment Page | 10
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
F. Install Oracle Database software in srv1
23. Extract the installation file into the Linux staging directory D:\staging\Linux
24. In the VirtualBox window of srv1, login as oracle, open a terminal window, change the current
directory to the staging directory, and start the installer. If you are already logged on as oracle
source the bash file before you run the installer.
cd
source .bash_profile
cd /media/sf_extdisk/12.2/database
./runInstaller
25. Respond to the Installer windows as follows:
Window Response
Configure Security
Updates
• Unmark "I wish to receive security updates.." checkbox.
• Click on Next
• Confirmation Window pops up
• Click on Yes
Installation Option • Select “Install Database Software only”
Database Installation
Options
• Select “Single instance database installation”
Database Edition • Select “Enterprise Edition”
Installation Location • Keep it to the default
Oracle base: /u01/app/oracle
Oracle Home: /u01/app/oracle/product/12.2.0.1/db_1
Create Inventory • Keep the inventory directory to its default value
• Set the groups to oinstall
Operating System Groups • Make sure dba is selected to all OS groups. It is OK to
keep OSOPER blank.
Summary • Click on Install button
• When prompted, run scripts as root
• When prompted, Install Oracle Trace File Analyzer
Finish • Click on Close button
Practice 1 - Preparing Practice Environment Page | 11
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
G. Create an Oracle Database in srv1
In the following steps you will create a database (named ORADB) in srv1.
26. Start the Oracle Net Configuration Assistant and create a default listener
netca
Listener Configuraiotn -> Add -> LISTENER -> Next -> Next -> No -> Next -> Finish
27. Start the dbca and respond to its windows as follows:
Window Response
Database Operation Create Database
Creation Mode Advanced Configuration
Deployment Type General Purpose or Transaction processing
Database
Identification
Global Database Name: ORADB.localdomain
Sid: ORADB
UnMark "Create as Database Container"
Storage Option Select "Use following for the storage attributes"
Database files storage type: File System
Database files location:
{ORACLE_BASE}/oradata/{DB_UNIQUE_NAME}
Mark "Use Oracle-Managed Files (OMF)"
Fast Recovery Option Mark "Specify the Fast Recovery Area"
Set the "Fast Recovery Area" to:
{ORACLE_BASE}/fra/{DB_UNIQUE_NAME}
Fast Recovery Area size (approx): 40960 MB
Make sure "Enable Archiving" is unmarked.
Network Configuration Make sure the LISTENER is selected
Data Vault Option Make sure the check boxes are unmarked
Configuration Options Memory tab:
Select "Use Automatic Shared Memory Management"
SGA size: 1652
PGA size: 552
Sizing tab:
Processes: 300
Character Sets tab:
Practice 1 - Preparing Practice Environment Page | 12
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
select "Use Unicode AL32UTF8"
Connection mode tab:
Make sure the "Dedicated server mode" is selected
Sample Schemas
Keep the option "Add sample schemas to the database"
unmarked
Management Options Make sure "Configure Enterprise Manager (EM) database
express" is marked.
Use Credentials Select "User the same administrative password for all
accounts"
Set the password (it has been set to "oracle" in my
demonstrations)
Creation Option Make sure "Create database" is selected.
Summary click on Finish
28. Test the created database by connecting to it using sqlplus:
sqlplus system/oracle@ORADB
29. Exit from the Putty session.
Practice 1 - Preparing Practice Environment Page | 13
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
H. Automating Database Startup and Shutdown
In the following steps you will configure srv1 so that the database automatically starts up when you
start the appliance and automatically shuts down when you shut down the appliance.
Note: this procedure is applicable in our case because the Oracle Restart has not been configured. If
the Oracle Restart was configured, you would have followed different procedure.
30. Open Putty and login as root to srv1
31. Edit the oratab file
vi /etc/oratab
32. Change the last field for the database line to Y
ORADB:/u01/app/oracle/product/12.2.0/db_1:Y
33. Create the file /etc/init.d/dbora and add the following code in it:
vi /etc/init.d/dbora
#! /bin/sh
# description: Oracle auto start-stop script.
ORA_HOME=/u01/app/oracle/product/12.2.0/db_1
ORA_OWNER=oracle
case "$1" in
'start')
 # Start the Oracle databases:
 # Remove "&" if you don't want startup as a background process.
 su - $ORA_OWNER -c "$ORA_HOME/bin/dbstart $ORA_HOME" &
 touch /var/lock/subsys/dbora
 ;;
'stop')
 # Stop the Oracle databases:
 su - $ORA_OWNER -c "$ORA_HOME/bin/dbshut $ORA_HOME" &
 rm -f /var/lock/subsys/dbora
 ;;
esac
34. Change the group of the dbora file to dba, and set its permissions to 750
chgrp dba /etc/init.d/dbora
chmod 750 /etc/init.d/dbora
35. Create symbolic links to the dbora script in the appropriate run-level script directories
ln -s /etc/init.d/dbora /etc/rc.d/rc0.d/K01dbora
ln -s /etc/init.d/dbora /etc/rc.d/rc3.d/S99dbora
ln -s /etc/init.d/dbora /etc/rc.d/rc5.d/S99dbora
Practice 1 - Preparing Practice Environment Page | 14
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
36. Restart srv1 and wait for a few minutes to allow the database to automatically start up.
37. Login as oracle to srv1 and verify that the database has automatically started.
ps -ef | grep pmon
sqlplus / as sysdba
Note: If you successfully reached to this point of the practice, I recommend taking a snapshot of the
virtual appliance at this stage. It helps you to recover back in case you faced any issue in the
upcoming steps. If you do not know how to create a snapshot in Oracle VirtualBox, do not worry. You
will learn about it soon in this practice.
Practice 1 - Preparing Practice Environment Page | 15
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
I. Set the tns Naming configuration
38. In srv1, enable the tnsnaming and easy connect methods in the sqlnet.ora file.
vi $ORACLE_HOME/network/admin/sqlnet.ora
# add the following to the file:
NAMES.DIRECTORY_PATH= (TNSNAMES, EZCONNECT)
39. Make sure connection to ORADB is configured in the tnsnames.ora file.
cat $TNS_ADMIN/tnsnames.ora
40. In your hosting PC, configure the connection to ORADB in the tnsnames.ora file. Replace the IP
address below with the IP address in your environment.
Do not copy the configuration from the PDF file. Copy it from the attached tnsnames.ora file.
Observe that it uses the IP address for defining the hostname. We have to use the IP address
because srv1 hostname is not defined in your hosting PC.
notepad D:\oracle\product\12.1.0\client_1\network\admin\tnsnames.ora
# add the following:
ORADB=
 (DESCRIPTION=
 (ADDRESS=
 (PROTOCOL=TCP)
 (HOST=192.168.1.159)
 (PORT=1521)
 )
 (CONNECT_DATA=
 (SERVER=dedicated)
 (SERVICE_NAME=ORADB.localdomain)
 )
 )
41. In the hosting PC, test the configuration
sqlplus system/oracle@ORADB
Practice 1 - Preparing Practice Environment Page | 16
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
Setup soe Schema
In this section of the practice, you will create and populate an Order Entry schema named soe. This
schema is the sample application data that will be used in this course practices.
You will download a data pump dump file that contains the soe schema and import it into ORADB.
Caution: If you already have soe schema in your database, the script below will drop it and replace it
with the new schema.
42. Download the script create_soe.sql from the downloadable resources section of the lecture.
The script creates a tablespace (SOETBS), the user (soe), and the schema objects.
43. Copy the script to the staging directory.
44. Open Putty and login to srv1 as oracle user.
45. Invoke SQL*Plus and login to ORADB as sysdba.
sqlplus / as sysdba
46. Execute the script.
@/media/sf_extdisk/create_soe.sql
47. Download the data pump dump file (its size is 88 MB) from any of the following links. The file is
compressed in zip format.
Download Link1 - The Downloadable Resources section of this lecture
48. Extract the file. The password to extract it is Ahmed@Baraka
After extraction, the file size is about 330MB.
49. Copy the extracted file (soe.dmp) to the staging directory.
50. Move the dump file to the default data pump directory
host mv /media/sf_extdisk/soe.dmp /u01/app/oracle/admin/ORADB/dpdump/
51. Import the data pump dump file into soe schema.
host impdp soe/soe directory=DATA_PUMP_DIR dumpfile=soe.dmp
52. If the import succeeds, delete the dump file and the script file.
host rm /u01/app/oracle/admin/ORADB/dpdump/soe.dmp
host rm /media/sf_extdisk/create_soe.sql
53. Verify the schema and its objects were successfully created. 79 objects should be imported.
conn soe/soe
SELECT SUM(BYTES/1024/1024) MB FROM USER_SEGMENTS;
Note: the ERD diagram of the soe schema is available in the downloadable resources section.
Practice 1 - Preparing Practice Environment Page | 17
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
(Optional) Install Swingbench
In this section of the practice, you will install Swingbench 2.5. The connects to soe schema that you
created earlier.
Note: At the time of this writing, the latest version of Swingbench is 2.6. Personally, I faced issues
with it and therefore prefer to use the stable version 2.5 in the course practices.
Note: If you could not manage to run the Swingbench in your hosting PC, you do not have to worry
much about it. You can go on with the course practices without the Swingbench application.
54. In your hosting PC, copy the software zip file to the disk drive where you want to install the
software. In my case, I copied it to the D: drive.
55. Extract the zip file. The files will be automatically extracted to the following path. This folder will
be referred to as $SWINGHOME folder.
<disk drive letter>:\swingbench
56. In the hosting PC, open a command prompt window and change the directory to
$SWINGHOME\winbin
cd D:\swingbench\winbin
Caution: Do not start the “Order Entry Wizard” (oewizard). soe schema has already be setup in the
preceding section.
57. Start Swingbench by issuing the following command:
set PATH=D:\oracle\product\12.1.0\client_1\jdk\jre\bin;%PATH%
swingbench.bat
58. Under the User Details tab, you define the connection details to the database. Set its fields to
the values as in the following screenshot:
Practice 1 - Preparing Practice Environment Page | 18
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
59. Click on "Test Connection" button to test the database connection settings. You should see a
message indicating that the connection is successful.
60. Under the Load tab, change the Number of Users to 20. This value sets the number of sessions
that the utility will create when you start the benchmark run.
61. Click on Save button
When you click on Save button, the settings that you have set in Swingbench interface will be
saved in swingconfig.xml. The next time you start Swingbench, it reads its settings from the
file.
Practice 1 - Preparing Practice Environment Page | 19
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
62. Click on the "Start Benchmark run" button.
Gradually, Swingbench kicks off connection sessions to the database and executes the selected
operations.
63. Observe that the "Transactions Per Minute" chart is increasing by time and it eventually gets
saturated.
64. Stop the Benchmark Run by clicking on its button.
65. Exit Swingbench: File menu | Exit
Practice 1 - Preparing Practice Environment Page | 20
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
Creating and Deleting Snapshots in VirtualBox
In Oracle VirtualBox, you can create snapshots of the appliances. You use snapshots to roll
back the state of the appliance to its state at the time at which the snapshot was created.
In all the course practices, start with creating a snapshot of the appliance. If everything
goes well with implementing the practice, delete the snapshot by the end of the practice.
Caution: If you create a snapshot at the beginning of a practice, do not forget to delete the
snapshot after finishing the practice. Otherwise, the folder that contains the appliance
rapidly grows up and eventually leaves you out of free disk space.
66. To create the snapshot, perform the following:
a. Machine -> Take Snapshot. “Take Snapshot of Virtual Machine” window pops up.
b. In the Snapshot Name field, type any description like "Before Oracle installation"
c. Click on OK
Practice 1 - Preparing Practice Environment Page | 21
Oracle Database 12c the Ultimate Guide to SQL Tuning, a course by Ahmed Baraka
67. If implementing the practice was successful, you can delete the snapshot. Perform the
ste
