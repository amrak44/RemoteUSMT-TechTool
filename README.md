# RemoteUSMT-TechTool
For creating migration jobs using USMT to backup and restore profiles from network shares.


This was created to manage the user state migration files of multiple users over time.  It includes a logging portion and restores some previously entered values.

This will bypass a double-hop scenario by scheduling the remote computer to send the migration data to the shared directory.  This requires the shared directory to grant modify permissions to the computer account.

This was designed using PowerShell Studio some functions within are contained in this application.  

This hasnt been extensively tested, so if you run into any issues with the code posting the problem would be helpful!

This requires you are a local administrator of the target PC and have remote WMI access to the computer.  Some features require 3rd party programs that arent provided.  Namely 7zip and CMTrace.  

![image](https://github.com/amrak44/RemoteUSMT-TechTool/assets/71808252/db69c199-04ef-4dfd-9e96-f7650039b6b4)

![Screenshot 2023-05-21 053045](https://github.com/amrak44/RemoteUSMT-TechTool/assets/71808252/bd679f2f-3e55-4200-b6a0-c2ca70b44a8a)
