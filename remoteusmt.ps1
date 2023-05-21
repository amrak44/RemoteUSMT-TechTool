#region Source: Startup.pss
#----------------------------------------------
#region Import Assemblies
#----------------------------------------------
#endregion Import Assemblies

#Define a Param block to use custom parameters in the project
#Param ($CustomParameter)

function Main {
<#
    .SYNOPSIS
        The Main function starts the project application.
    
    .PARAMETER Commandline
        $Commandline contains the complete argument string passed to the script packager executable.
    
    .NOTES
        Use this function to initialize your script and to call GUI forms.
		
    .NOTES
        To get the console output in the Packager (Forms Engine) use: 
		$ConsoleOutput (Type: System.Collections.ArrayList)
#>
	Param ([String]$Commandline)

	#--------------------------------------------------------------------------
	$h = Test-Path -Path $env:LOCALAPPDATA\Remote_USMT
	$startMain = $true
	if ($h -eq $false)
	{
		if ((Show-starting_psf) -eq 'OK')
		{
			$usmtpath = $($starting_usmtpath)
			$profileDirectory = $($starting_profileLocation.text)
		}
		else { $startMain = $false }
		
	}
	
	#--------------------------------------------------------------------------
	if ($startMain -eq $true)
	{
		if ((Show-USMT-Remote-Gui_PSF) -eq 'OK')
		{
			
		}
	}
	else
	{
		
		Add-Type -AssemblyName PresentationFramework
		if (([System.Windows.MessageBox]::Show('Do you want to try entering values again?','Error','YesNoCancel')) -eq 'Yes')
			{
				Main
			}
			else
			{
				$script:ExitCode = 5
				
			}
			
		}
		
		$script:ExitCode = 0 #Set the exit code for the Packager
}

#endregion Source: Startup.pss

#region Source: HistoryWindow.psf
function Show-HistoryWindow_psf
{
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formMigrationHistory = New-Object 'System.Windows.Forms.Form'
	$panel1 = New-Object 'System.Windows.Forms.Panel'
	$labelDeletionOfTheseObjec = New-Object 'System.Windows.Forms.Label'
	$buttonExitHistory = New-Object 'System.Windows.Forms.Button'
	$labelLoadSelectedForMigra = New-Object 'System.Windows.Forms.Label'
	$buttonOpenDirectory = New-Object 'System.Windows.Forms.Button'
	$historyPath = New-Object 'System.Windows.Forms.LinkLabel'
	$labelThisInformationIsSto = New-Object 'System.Windows.Forms.Label'
	$buttonLoad = New-Object 'System.Windows.Forms.Button'
	$historyGrid = New-Object 'System.Windows.Forms.DataGridView'
	$contextmenustrip1 = New-Object 'System.Windows.Forms.ContextMenuStrip'
	$RemoveTS = New-Object 'System.Windows.Forms.ToolStripMenuItem'
	$date = New-Object 'System.Windows.Forms.DataGridViewTextBoxColumn'
	$CMDBLink = New-Object 'System.Windows.Forms.DataGridViewButtonColumn'
	$operation = New-Object 'System.Windows.Forms.DataGridViewTextBoxColumn'
	$target = New-Object 'System.Windows.Forms.DataGridViewTextBoxColumn'
	$destination = New-Object 'System.Windows.Forms.DataGridViewTextBoxColumn'
	$encryptionkey = New-Object 'System.Windows.Forms.DataGridViewTextBoxColumn'
	$username = New-Object 'System.Windows.Forms.DataGridViewTextBoxColumn'
	$migconfig = New-Object 'System.Windows.Forms.DataGridViewTextBoxColumn'
	$Delete = New-Object 'System.Windows.Forms.DataGridViewButtonColumn'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	$formMigrationHistory_Load = {
	start-gridload
	
	}
	
	#	$historyGrid.SelectionMode = 'FullRowSelect'
		#$historyGrid.RowHeadersWidthSizeMode= 'AutoSizeToAllHeaders'
	#	$historyGrid.AllowUserToResizeColumns = $true
	#	$historyGrid.AllowUserToResizeRows = $false
	#	$historyGrid.AutoSizeColumnsMode = 'AllCells'
	#	$historyGrid.DataSource = ConvertTo-DataTable -InputObject $mycsvtext
	#	$historyGrid.Refresh(
	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	$formMigrationHistory_Load = {
		start-gridload
		
	}
	
	#	$historyGrid.SelectionMode = 'FullRowSelect'
	#$historyGrid.RowHeadersWidthSizeMode= 'AutoSizeToAllHeaders'
	#	$historyGrid.AllowUserToResizeColumns = $true
	#	$historyGrid.AllowUserToResizeRows = $false
	#	$historyGrid.AutoSizeColumnsMode = 'AllCells'
	#	$historyGrid.DataSource = ConvertTo-DataTable -InputObject $mycsvtext
	#	$historyGrid.Refresh(
	
	#region Control Helper Functions
	function start-gridload
	{
		$mycsvtext = Import-Csv -Path "$env:LOCALAPPDATA\Remote_USMT\usmtlogs.csv"
		$historyPath.Text = "$env:LOCALAPPDATA\Remote_USMT\usmtlogs.csv"
		$logfile = New-Object System.Collections.ArrayList
		
		foreach ($item in $mycsvtext)
		{
			$newlogfile = { } | Select-Object "date", "operation", "target", "destination", "encryptionkey", "username", "MigConfig", "CMDBLink"
			$newlogfile.Date = $item.date
			$newlogfile.Operation = $item.operation
			$newlogfile.Target = $item.target
			$newlogfile.Destination = $item.destination
			$newlogfile.EncryptionKey = $item.EncryptionKey
			$newlogfile.Username = $item.Username
			$newlogfile.MigConfig = $item.MigConfig
			$newlogfile.CMDBLink = $item.CMDBLink
			$logfile.Add($newlogfile)
		}
		$historyGrid.DataSource = ConvertTo-DataTable -InputObject $logfile
		$historyGrid.Refresh()
	}
	function Update-DataGridView
	{
				<#
				.SYNOPSIS
					This functions helps you load items into a DataGridView.
			
				.DESCRIPTION
					Use this function to dynamically load items into the DataGridView control.
			
				.PARAMETER  DataGridView
					The DataGridView control you want to add items to.
			
				.PARAMETER  Item
					The object or objects you wish to load into the DataGridView's items collection.
				
				.PARAMETER  DataMember
					Sets the name of the list or table in the data source for which the DataGridView is displaying data.
			
				.PARAMETER AutoSizeColumns
				    Resizes DataGridView control's columns after loading the items.
				#>
		Param (
			[ValidateNotNull()]
			[Parameter(Mandatory = $true)]
			[System.Windows.Forms.DataGridView]$historyGrid,
			[ValidateNotNull()]
			[Parameter(Mandatory = $true)]
			$Item,
			[Parameter(Mandatory = $false)]
			[string]$DataMember,
			[System.Windows.Forms.DataGridViewAutoSizeColumnsMode]$AutoSizeColumns = 'None'
		)
		$historyGrid.SuspendLayout()
		$historyGrid.DataMember = $DataMember
		if ($null -eq $Item)
		{
			$historyGrid.DataSource = $null
		}
		elseif ($Item -is [System.Data.DataSet] -and $Item.Tables.Count -gt 0)
		{
			$historyGrid.DataSource = $Item.Tables[0]
		}
		elseif ($Item -is [System.ComponentModel.IListSource]`
			-or $Item -is [System.ComponentModel.IBindingList] -or $Item -is [System.ComponentModel.IBindingListView])
		{
			$historyGrid.DataSource = $Item
		}
		else
		{
			$array = New-Object System.Collections.ArrayList
			
			if ($Item -is [System.Collections.IList])
			{
				$array.AddRange($Item)
			}
			else
			{
				$array.Add($Item)
			}
			$historyGrid.DataSource = $array
			$historyGrid.sort($Date, 'Ascending')
		}
		if ($AutoSizeColumns -ne 'None')
		{
			$historyGrid.AutoResizeColumns($AutoSizeColumns)
		}
		$historyGrid.ResumeLayout()
	}
	function ConvertTo-DataTable
	{
				<#
					.SYNOPSIS
						Converts objects into a DataTable.
				
					.DESCRIPTION
						Converts objects into a DataTable, which are used for DataBinding.
				
					.PARAMETER  InputObject
						The input to convert into a DataTable.
				
					.PARAMETER  Table
						The DataTable you wish to load the input into.
				
					.PARAMETER RetainColumns
						This switch tells the function to keep the DataTable's existing columns.
					
					.PARAMETER FilterCIMProperties
						This switch removes CIM properties that start with an underline.
				
					.EXAMPLE
						$DataTable = ConvertTo-DataTable -InputObject (Get-Process)
				#>
		[OutputType([System.Data.DataTable])]
		param (
			$InputObject,
			[ValidateNotNull()]
			[System.Data.DataTable]$Table,
			[switch]$RetainColumns,
			[switch]$FilterCIMProperties)
		
		if ($null -eq $Table)
		{
			$Table = New-Object System.Data.DataTable
		}
		if ($null -eq $InputObject)
		{
			$Table.Clear()
			return @( ,$Table)
		}
		
		if ($InputObject -is [System.Data.DataTable])
		{
			$Table = $InputObject
		}
		elseif ($InputObject -is [System.Data.DataSet] -and $InputObject.Tables.Count -gt 0)
		{
			$Table = $InputObject.Tables[0]
		}
		else
		{
			if (-not $RetainColumns -or $Table.Columns.Count -eq 0)
			{
				#Clear out the Table Contents
				$Table.Clear()
				
				if ($null -eq $InputObject) { return } #Empty Data
				
				$object = $null
				#find the first non null value
				foreach ($item in $InputObject)
				{
					if ($null -ne $item)
					{
						$object = $item
						break
					}
				}
				if ($null -eq $object) { return } #All null then empty
				#Get all the properties in order to create the columns
				foreach ($prop in $object.PSObject.Get_Properties())
				{
					if (-not $FilterCIMProperties -or -not $prop.Name.StartsWith('__')) #filter out CIM properties
					{
						#Get the type from the Definition string
						$type = $null
						
						if ($null -ne $prop.Value)
						{
							try { $type = $prop.Value.GetType() }
							catch { Out-Null }
						}
						if ($null -ne $type) # -and [System.Type]::GetTypeCode($type) -ne 'Object')
						{
							[void]$table.Columns.Add($prop.Name, $type)
						}
						else #Type info not found
						{
							[void]$table.Columns.Add($prop.Name)
						}
					}
				}
				if ($object -is [System.Data.DataRow])
				{
					foreach ($item in $InputObject)
					{
						$Table.Rows.Add($item)
					}
					return @( ,$Table)
				}
			}
			else
			{
				$Table.Rows.Clear()
			}
			
			foreach ($item in $InputObject)
			{
				$row = $table.NewRow()
				
				if ($item)
				{
					foreach ($prop in $item.PSObject.Get_Properties())
					{
						if ($table.Columns.Contains($prop.Name))
						{
							$row.Item($prop.Name) = $prop.Value
						}
					}
				}
				[void]$table.Rows.Add($row)
			}
		}
		return @( ,$Table)
	}
	#endregion
	##
	# ** ------------------------------- ** #
	##
	
	$buttonExitHistory_MouseClick = [System.Windows.Forms.MouseEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.MouseEventArgs]
		$selectedItem = $historyGrid.SelectedCells.Item.OwningRow
	}
	$contextmenustrip1.add_Click
	{
	}
	
	$historyGrid_CellDoubleClick = [System.Windows.Forms.DataGridViewCellEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.DataGridViewCellEventArgs]
		$itemclicked = $historyGrid.CurrentCellAddress
		$pathCheck = $historyGrid.CurrentRow.Cells[3].Value
		if ($(Test-Path $pathCheck) -eq $true) { $historyGrid.CurrentRow.DefaultCellStyle.BackColor = 'LightGreen' }
		elseif ($(test-path $pathCheck) -eq $false) { $historyGrid.CurrentRow.DefaultCellStyle.BackColor = 'LightPink' }
		
	}
	
	$button1_Click = {
	
		get-process
	}
	
	$textbox1_TextChanged = {
	
		
	}
	
	$buttonOpenDirectory_Click = {
	
		explorer "$env:LOCALAPPDATA\Remote_USMT\"
	}
	
	$historyPath_LinkClicked = [System.Windows.Forms.LinkLabelLinkClickedEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.LinkLabelLinkClickedEventArgs]
	
		explorer "$env:LOCALAPPDATA\Remote_USMT\"
	}
	$historyGrid_MouseDoubleClick = [System.Windows.Forms.MouseEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.MouseEventArgs]
	
		
	}
	$buttonExitHistory_MouseClick=[System.Windows.Forms.MouseEventHandler]{
	#Event Argument: $_ = [System.Windows.Forms.MouseEventArgs]
		$selectedItem = $historyGrid.SelectedCells.Item.OwningRow
	}
	$historyGrid_CellDoubleClick=[System.Windows.Forms.DataGridViewCellEventHandler]{
	#Event Argument: $_ = [System.Windows.Forms.DataGridViewCellEventArgs]
			$itemclicked = $historyGrid.CurrentCellAddress
			$pathCheck = $historyGrid.CurrentRow.Cells[3].Value
			if($(Test-Path $pathCheck ) -eq $true){$historyGrid.CurrentRow.DefaultCellStyle.BackColor= 'LightGreen'}
			elseif($(test-path $pathCheck) -eq $false){$historyGrid.CurrentRow.DefaultCellStyle.BackColor = 'LightPink'}	
	}
	$buttonOpenDirectory_Click={
	
		explorer "$env:LOCALAPPDATA\Remote_USMT\"
	}
	$historyPath_LinkClicked=[System.Windows.Forms.LinkLabelLinkClickedEventHandler]{
	#Event Argument: $_ = [System.Windows.Forms.LinkLabelLinkClickedEventArgs]
	
		explorer "$env:LOCALAPPDATA\Remote_USMT\"
	}
	
	$historygrid.Add_CellMouseClick({ gridClick })
	function gridclick()
	{
		$rowIndex = $historygrid.CurrentRow.Index
		$columnIndex = $historygrid.CurrentCell.ColumnIndex
		if (($columnIndex -eq 8) -and ($historygrid.Rows[$rowIndex].Cells[$columnIndex].value -ne ""))
		{
			#Start-Process $historygrid.Rows[$rowIndex].Cells[$columnIndex].value
			$historyGrid.CurrentRow.Cells.value[3] -match '[0-9]{7}'
			$tagrep = $matches[0]
			$cmdbLink = 'https://mn-itservices.us.onbmc.com/arsys/forms/onbmc-s/SHR%3ALandingConsole/Default%20Administrator%20View/?wait=0&mode=search&F304255500=AST%3AComputerSystem&F1000000076=FormOpen&F303647600=SearchTicketWithQual&F304255610=%27400127400%27=%22BMC.ASSET%22AND%27260100004%27%3D%22' + $tagRep + '%22'
			
			Set-Clipboard $CMDBLink
			Show-MessageBox -Title 'Copied' -Message 'Copied Link To Clipboard!' -Icon Information -Buttons OKOnly
			
		}
		if ($columnIndex -eq 0)
		{
			update-log 'checking this share exists'
			
			$setupTar = $historyGrid.rows[$rowindex].cells['Destination'].Value
			$confirm = Show-MessageBox -Title Confirm -Message 'Do you really want to permenently delete this?' -Icon Critical -Buttons OKCancel
			if ($confirm -eq 'OK')
			{
				update-log -message "Deleting backup located at $setupTar"
				$exists = check -path $setupTar
				if ($exists -eq $true)
				{
					Get-ChildItem $setupTar -Recurse | Remove-Item -Recurse -Force
					
					Update-Log -message $m
					$historyGrid.Rows.removeat($rowIndex)
					update-mylogs -DeleteThis $setupTar
				}
			}
			
		}
		
	}
	#tests for PC being online
	
	function check
	{
		param ($path)
		
		$ps = [powershell]::Create().AddScript("test-path $path")
		
		# execute it asynchronously
		$handle = $ps.BeginInvoke()
		
		# Wait 2500 milliseconds for it to finish
		if (-not $handle.AsyncWaitHandle.WaitOne(2500))
		{
			update-log "this backup is not found"
			return $false
			
		}
		
		# WaitOne() returned $true, let's fetch the result
		$result = $ps.EndInvoke($handle)
		
		return $true
		
	}
	##
	function update-mylogs
	{
		param($DeleteThis)
		$h = Import-Csv $env:LOCALAPPDATA\Remote_USMT\usmtlogs.csv
		$log = new-object system.collections.arraylist
		 foreach($line in $H) {
			 $mylogs= { } | select-object "date", "operation", "Target", "destination", "encryptionkey", "username", "migconfig", "Cmdblink"
			
			$thisdate = $line.date
			$thisop=$line.operation
			 $thistar = $line.target
			 $thisdest = $line.destination
			 $thisencrypt = $line.encryptionkey
			 $thisuser = $line.username
			 $migconfig = $line.migconfig
			 $cmdb = $line.cmdblink
			 if($thisdest -eq $DeleteThis) { }
			 else{
				$mylogs.date = $thisdate
				$mylogs.operation = $thisop
				$mylogs.target = $thistar
				 $mylogs.destination = $thisdest
				 $mylogs.encryptionkey = $thisencrypt
				 $mylogs.username = $thisuser
				 $mylogs.migconfig = $migconfig
				 $mylogs.cmdblink = $cmdb
				 $log += $mylogs
			}
			if ($log.Count -eq ($h.count - 1))
				{
					$log | Export-Csv -Path $env:LOCALAPPDATA\Remote_USMT\usmtlogs.csv -NoTypeInformation -Force
				}
				
			}
		}
		
	$buttonLoad_Click={
		
	}
	
	$historyGrid_CellContentClick=[System.Windows.Forms.DataGridViewCellEventHandler]{
	#Event Argument: $_ = [System.Windows.Forms.DataGridViewCellEventArgs]
		
	}
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$formMigrationHistory.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:HistoryWindow_historyGrid = $historyGrid.SelectedCells
		if ($historyGrid.SelectionMode -eq 'FullRowSelect')
		{ $script:HistoryWindow_historyGrid_SelectedObjects = $historyGrid.SelectedRows | Select-Object -ExpandProperty DataBoundItem }
		else { $script:HistoryWindow_historyGrid_SelectedObjects = $historyGrid.SelectedCells | Select-Object -ExpandProperty RowIndex -Unique | ForEach-Object { if ($_ -ne -1) { $historyGrid.Rows[$_].DataBoundItem } } }
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonExitHistory.remove_MouseClick($buttonExitHistory_MouseClick)
			$buttonOpenDirectory.remove_Click($buttonOpenDirectory_Click)
			$historyPath.remove_LinkClicked($historyPath_LinkClicked)
			$buttonLoad.remove_Click($buttonLoad_Click)
			$historyGrid.remove_CellContentClick($historyGrid_CellContentClick)
			$historyGrid.remove_CellDoubleClick($historyGrid_CellDoubleClick)
			$historyGrid.remove_MouseDoubleClick($historyGrid_MouseDoubleClick)
			$formMigrationHistory.remove_Load($formMigrationHistory_Load)
			$formMigrationHistory.remove_Load($Form_StateCorrection_Load)
			$formMigrationHistory.remove_Closing($Form_StoreValues_Closing)
			$formMigrationHistory.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$formMigrationHistory.SuspendLayout()
	$panel1.SuspendLayout()
	$historyGrid.BeginInit()
	$contextmenustrip1.SuspendLayout()
	#
	# formMigrationHistory
	#
	$formMigrationHistory.Controls.Add($panel1)
	$formMigrationHistory.Controls.Add($historyGrid)
	$formMigrationHistory.AccessibleRole = 'None'
	$formMigrationHistory.AutoScaleDimensions = New-Object System.Drawing.SizeF(10, 24)
	$formMigrationHistory.AutoScaleMode = 'Font'
	$formMigrationHistory.BackColor = [System.Drawing.Color]::DimGray 
	$formMigrationHistory.CancelButton = $buttonExitHistory
	$formMigrationHistory.ClientSize = New-Object System.Drawing.Size(1324, 526)
	$formMigrationHistory.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABNTeXN0
ZW0uRHJhd2luZy5JY29uAgAAAAhJY29uRGF0YQhJY29uU2l6ZQcEAhNTeXN0ZW0uRHJhd2luZy5T
aXplAgAAAAIAAAAJAwAAAAX8////E1N5c3RlbS5EcmF3aW5nLlNpemUCAAAABXdpZHRoBmhlaWdo
dAAACAgCAAAAAAAAAAAAAAAPAwAAAMxcAAACAAABAAUAEBAAAAEAIABoBAAAVgAAABgYAAABACAA
iAkAAL4EAAAgIAAAAQAgAKgQAABGDgAAMDAAAAEAIACoJQAA7h4AAAAAAAABACAANhgAAJZEAAAo
AAAAEAAAACAAAAABACAAAAAAAAAEAADDDgAAww4AAAAAAAAAAAAA+8BCAPvAQgD7wEI6+8BCvfvA
Qjn7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIF+8BC
p/vAQv/7wELI+8BCO/vAQgP7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA
+8BCCPvAQrn7wEL/+8BC//vAQuj7wEKm+8BCe/vAQmj7wEJk+8BCW/vAQin7wEIC+8BCAAAAAAAA
AAAA+8BCAPvAQgD7wEIv+8BCdPvAQrn7wELx+8BC//vAQv/7wEL/+8BC//vAQv77wELi+8BCZ/vA
QgP7wEIAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIK+8BCQfvAQq77wEL5+8BC//vAQv/7wEL/+8BC
//vAQuz7wEJD+8BCAPvAQgAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQgv7wEJb+8BC5fvAQv/7wEL/
+8BC//vAQv/7wEL/+8BCovvAQgP7wEIAAAAAAAAAAAD7wEIA+8BCBfvAQkz7wEK8+8BC9vvAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQtn7wEIb+8BCAAAAAAD7wEIA+8BCDvvAQob7wELx+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL5+8BC3fvAQv37wELx+8BCOPvAQgD7wEIA+8BCC/vAQpT7wEL8+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC5fvAQmD7wEK++8BC//vAQpf7wEIc+8BCAPvAQmv7wEL5
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQrT7wEJ++8BCTfvAQrL7wELG+8BCRfvAQiP7
wELV+8BC//vAQv/7wEL/+8BC//vAQv/7wEL8+8BC6PvAQqj7wEJr+8BCnvvAQgz7wEIL+8BCEPvA
QgH7wEJq+8BC+/vAQv/7wEL/+8BC/fvAQuL7wEKl+8BCXPvAQkj7wEKO+8BC4vvAQpj7wEIA+8BC
AAAAAAAAAAAA+8BCovvAQv/7wEL5+8BCx/vAQm/7wEIl+8BCBPvAQgD7wEIy+8BC6/vAQv/7wEKC
+8BCAPvAQgAAAAAAAAAAAPvAQrf7wELQ+8BCYPvAQhL7wEIA+8BCAAAAAAD7wEIA+8BCBvvAQpz7
wEL/+8BCg/vAQgD7wEIAAAAAAAAAAAD7wEJQ+8BCH/vAQgD7wEIAAAAAAAAAAAAAAAAA+8BCAPvA
QgD7wEIg+8BCwfvAQpv7wEIA+8BCAAAAAAAAAAAA+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAD7wEIA+8BCAPvAQin7wEJ4+8BCCvvAQgAAAAAAAAAAAMf/AACB/wAAgAcAAMADAADwAwAA
+AEAAOABAADAAQAAgAAAAIAAAAAAAAAAAA8AAAEPAAAPDwAAP48AAP/HAAAoAAAAGAAAADAAAAAB
ACAAAAAAAAAJAADDDgAAww4AAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAvvAQmT7wEK1+8BCHvvA
QgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCQ/vAQuj7wEL/+8BCn/vAQhL7wEIA+8BCAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEIC+8BCoPvAQv/7wEL/+8BC/fvAQqv7wEIp+8BCAfvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIE+8BCsfvAQv/7wEL/+8BC
//vAQv/7wELe+8BCkfvAQlr7wEI9+8BCL/vAQin7wEIp+8BCJvvAQhH7wEIB+8BCAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCbfvAQtv7wEL2+8BC//vAQv/7wEL/+8BC//vAQv37
wEL0+8BC7fvAQun7wELp+8BC5/vAQsr7wEJ5+8BCFvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAA
AAD7wEIA+8BCBPvAQhr7wEJH+8BCjfvAQtb7wEL8+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL++8BCtPvAQh37wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA
+8BCAfvAQhv7wEJs+8BC1PvAQv77wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQpv7
wEIH+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCHfvA
QqD7wEL9+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvD7wEJC+8BCAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIR+8BCUPvAQq37wEL7+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEKU+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEIA+8BCC/vAQln7wELC+8BC+PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wELO+8BCE/vAQgAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIq+8BCqPvAQvf7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wELs+8BCL/vAQgAAAAAA
AAAAAAAAAAD7wEIA+8BCAPvAQkf7wELV+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQt77wELT+8BC//vAQv/7wEL6+8BCTvvAQgAAAAAAAAAAAPvAQgD7wEIA+8BCTfvA
QuT7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQpn7wEI0+8BC
xvvAQv/7wEL/+8BCnPvAQg37wEIA+8BCAPvAQgD7wEI1+8BC3PvAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQoD7wEJ2+8BCWPvAQuD7wEL/+8BC+/vAQrP7
wEIt+8BCAPvAQg/7wEK0+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC2vvAQkj7wEK4+8BCJ/vAQkT7wEK8+8BC0PvAQn/7wEIT+8BCAPvAQl37wEL6+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv77wELT+8BCSvvAQnX7wEKy
+8BCCPvAQgD7wEIL+8BCEfvAQgL7wEIA+8BCC/vAQrb7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQvf7wELV+8BCp/vAQmv7wEIz+8BCcPvAQvD7wEKH+8BCAPvAQgAAAAAAAAAAAAAA
AAAAAAAA+8BCNfvAQuj7wEL/+8BC//vAQv/7wEL/+8BC//vAQvr7wELX+8BClPvAQkz7wEIY+8BC
DPvAQnf7wELL+8BC+vvAQv/7wEJj+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCZPvAQvv7wEL/
+8BC//vAQv/7wELv+8BCsfvAQlv7wEIb+8BCAvvAQgD7wEIA+8BCCfvAQrn7wEL/+8BC//vAQvv7
wEJP+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BChPvAQv/7wEL/+8BC7PvAQp37wEI9+8BCCPvA
QgD7wEIAAAAAAAAAAAD7wEIA+8BCAPvAQmj7wEL8+8BC//vAQvn7wEJI+8BCAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCkPvAQvj7wEKq+8BCO/vAQgX7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
+8BCAPvAQhT7wEK8+8BC//vAQvv7wEJP+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCa/vAQmb7
wEIK+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEI2+8BC2PvA
Qv/7wEJl+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCCPvAQgL7wEIAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCPfvAQtT7wEKN+8BCAPvAQgAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAD7wEIA+8BCAPvAQjL7wEJ3+8BCCPvAQgAAAAAAAAAAAAAAAAAAAAAA4f//AOD/
/wDAP/8AwAA/AOAAHwDgAA8A/AAHAP+ABwD/AAcA/AADAPgAAwDwAAMA4AABAMAAAACAAAAAgAAR
AAAAPwAAAD8AADA/AAH4PwAH+D8AH/w/AD/+PwD//x8AKAAAACAAAABAAAAAAQAgAAAAAAAAEAAA
ww4AAMMOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCDPvAQob7wEKg+8BCDfvAQgAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgX7wEKF+8BC
+fvAQvn7wEJ2+8BCBPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEIA+8BCSfvAQvH7wEL/+8BC//vAQvL7wEJw+8BCBvvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCAPvAQgD7wEKU+8BC//vAQv/7wEL/+8BC//vAQvX7wEKP+8BCHfvAQgD7wEIA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAfvAQqL7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv77wELR+8BCfPvAQkH7wEIi+8BCEvvAQgv7wEIH+8BCBvvAQgb7wEIG+8BCAfvAQgAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCgvvAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC9fvAQuL7wELQ+8BCwvvAQrn7wEK2+8BCt/vAQrf7
wEKZ+8BCW/vAQhf7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvA
QgD7wEIk+8BCe/vAQrL7wELi+8BC/PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL7+8BCyfvAQkv7wEIC+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCBvvAQiX7wEJh+8BCsPvAQu37wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC6vvAQln7wEIA+8BCAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIH+8BC
OfvAQpn7wELs+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC4PvAQjT7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAD7wEIA+8BCBPvAQkD7wEK8+8BC/fvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BCpfvAQgf7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQh37wEK0+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wELu+8BCOvvAQgAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhP7wEJY+8BCq/vA
Quj7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEKE+8BC
APvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhD7wEJi
+8BCx/vAQvn7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQsD7wEIM+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvA
QgP7wEJB+8BCuvvAQvr7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC5fvAQib7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAPvAQgD7wEIN+8BCefvAQuv7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL3+8BCRfvAQgAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQgD7wEIA+8BCGPvAQqD7wEL7+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvn7wEKy+8BC2PvAQv/7wEL/+8BC//vAQv/7wEJn
+8BCAPvAQgAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhn7wEKu+8BC/vvAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC8fvAQjn7wEI0+8BC0/vA
Qv/7wEL/+8BC//vAQqv7wEIM+8BCAAAAAAAAAAAAAAAAAPvAQgD7wEIO+8BCovvAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wELm
+8BCRfvAQlT7wEJQ+8BC7fvAQv/7wEL/+8BC+fvAQqD7wEI1+8BCCAAAAAD7wEIA+8BCAfvAQnv7
wEL8+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQrr7wEI4+8BC0PvAQjP7wEJv+8BC8/vAQv/7wEL/+8BC//vAQrj7wEId+8BC
APvAQgD7wEI8+8BC6PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wELz+8BCU/vAQlf7wELa+8BCIvvAQgT7wEJa+8BCvfvAQs/7
wEKW+8BCKPvAQgD7wEIA+8BCCPvAQqn7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC7vvAQnL7wEIV+8BCuvvAQrD7wEIF+8BC
APvAQgD7wEIL+8BCEfvAQgP7wEIAAAAAAPvAQgD7wEI8+8BC7/vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL6+8BC5fvAQqj7wEI/+8BCEfvAQo/7
wEL++8BCevvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQoj7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvH7wELG+8BChvvAQk/7wEIo+8BC
F/vAQkf7wEK2+8BC/PvAQvv7wEJQ+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIQ
+8BCxPvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC9vvAQsr7wEKD+8BCPPvAQg/7
wEIA+8BCAPvAQl77wELN+8BC9fvAQv/7wEL/+8BC8PvAQjX7wEIAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQi77wELm+8BC//vAQv/7wEL/+8BC//vAQv/7wEL++8BC4/vAQp37wEJK+8BC
EvvAQgD7wEIAAAAAAPvAQgD7wEIA+8BCbfvAQv/7wEL/+8BC//vAQv/7wELm+8BCJfvAQgAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCTPvAQvX7wEL/+8BC//vAQv/7wEL8+8BC1PvAQnz7
wEIp+8BCA/vAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIt+8BC5vvAQv/7wEL/+8BC//vA
QuD7wEIe+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEJg+8BC+vvAQv/7wEL++8BC
1PvAQnH7wEIc+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgP7wEKV
+8BC//vAQv/7wEL/+8BC4PvAQh77wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQmb7
wEL8+8BC6PvAQoP7wEIe+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAA+8BCAPvAQij7wELW+8BC//vAQv/7wELm+8BCJvvAQgAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCXvvAQrj7wEI7+8BCAvvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQlD7wELq+8BC//vAQvH7wEI3+8BCAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIZ+8BCFvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAfvAQl77wELr+8BC
/fvAQlX7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7
wEIA+8BCAvvAQk/7wELb+8BChPvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQjf7wEJ0+8BCB/vAQgAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAD4f///8D////Af///wD///4AAD//AAAP/wAAA//AAAP/+AAB//4AAP//gAD//gAA//
gAAH/gAAB/wAAAf4AAAH8AAAA+AAAADAAAAAwAAAAYAAAGOAAAD/gAAA/wABgP8AD4D/AD+A/wH/
gP8H/8D/D//g/z//4P////D////8fygAAAAwAAAAYAAAAAEAIAAAAAAAACQAAMMOAADDDgAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIu+8BCr/vAQmT7wEIA
+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BC
APvAQj/7wELR+8BC//vAQtr7wEIz+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQgD7wEIA+8BCMPvAQtb7wEL/+8BC//vAQv/7wELC+8BCIvvAQgD7wEIAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIK+8BCq/vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BCt/vAQiH7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEJC+8BC8vvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQsD7wEIx+8BCAPvAQgAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAA+8BCAPvAQgD7wEJz+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wELb+8BCYPvAQgz7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEKA+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC9/vAQrT7wEJX+8BCHvvAQgb7wEIA+8BCAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BC
APvAQgD7wEJu+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL5
+8BC3PvAQrT7wEKO+8BCb/vAQlf7wEJH+8BCPPvAQjX7wEIy+8BCMvvAQjT7wEI4+8BCKvvAQhH7
wEIC+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEJF+8BC9fvAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv37wEL4+8BC9PvAQvH7wELv
+8BC7/vAQvH7wELy+8BC6PvAQsz7wEKT+8BCQ/vAQgn7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIR+8BCf/vA
Qrz7wELj+8BC+/vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC8vvAQqb7wEIt
+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAD7wEIA+8BCAPvAQgn7wEIm+8BCWPvAQpr7wELW+8BC+fvAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wELY+8BCSvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgL7
wEIa+8BCVvvAQqf7wELp+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC4vvAQkT7wEIA+8BC
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgb7wEIy+8BCjPvAQuL7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQs/7wEIk+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA
+8BCAvvAQiz7wEKW+8BC7/vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEKW+8BCBfvAQgAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIF+8BCSfvAQsn7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wELt+8BCPfvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BC
APvAQhz7wEKj+8BC/PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BCm/vAQgP7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQgD7wEIA+8BCC/vAQjn7wEKS+8BC9vvAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC4PvAQiX7wEIA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhn7wEJj+8BCuvvAQvD7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC/fvAQmL7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIZ+8BCcPvAQs/7
wEL7+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQqH7wEIC+8BCAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA
+8BCDfvAQmD7wELN+8BC/PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
QtD7wEIU+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCAPvAQgH7wEI1+8BCr/vAQvj7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQu37wEIy+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCCvvAQmr7wELi+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvv7wEJU+8BCAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIY+8BCmPvA
Qvf7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEJ3+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7
wEIA+8BCAPvAQiX7wEK2+8BC/vvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvv7wEKS+8BC
jfvAQuv7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEKa+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCKfvAQsL7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQvf7wEJE+8BCAPvAQlb7wELp+8BC//vAQv/7wEL/+8BC//vAQv/7wELO+8BC
GPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIi+8BCwPvAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvX7wEI/+8BCJfvAQgz7wEJr+8BC+PvA
Qv/7wEL/+8BC//vAQv/7wEL9+8BCk/vAQhL7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BC
APvAQhP7wEKt+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQuf7
wEIm+8BCd/vAQmz7wEIK+8BCn/vAQv/7wEL/+8BC//vAQv/7wEL/+8BC+/vAQrr7wEJR+8BCFvvA
QgEAAAAAAAAAAAAAAAD7wEIA+8BCBPvAQof7wEL9+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQr77wEIK+8BCkPvAQuf7wEI0+8BCHPvAQr/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL4+8BCg/vAQgUAAAAAAAAAAPvAQgD7wEIA+8BCTvvAQvD7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC/PvAQmj7wEIE+8BCs/vAQvr7wEJH
+8BCAPvAQif7wEK3+8BC/fvAQv/7wEL/+8BC//vAQvf7wEKg+8BCHPvAQgAAAAAAAAAAAPvAQgD7
wEIX+8BCxfvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
tfvAQhD7wEIo+8BC5fvAQtP7wEIX+8BCAPvAQgD7wEIV+8BCb/vAQrr7wELL+8BCrfvAQlj7wEIL
+8BCAAAAAAAAAAAA+8BCAPvAQgD7wEJx+8BC/fvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wELD+8BCKfvAQgD7wEKC+8BC//vAQpz7wEIB+8BCAAAAAAD7wEIA+8BC
APvAQgn7wEIQ+8BCBfvAQgD7wEIAAAAAAAAAAAAAAAAA+8BCAPvAQhr7wELR+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC8vvAQpz7wEIh+8BCAPvAQkj7wELo+8BC//vA
QmT7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BC
APvAQmL7wEL8+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC+fvAQt/7wEKh+8BCRvvAQgf7
wEIB+8BCSfvAQtr7wEL/+8BC8PvAQjj7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAD7wEIA+8BCB/vAQrH7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL8+8BC4vvAQq37wEJ2
+8BCTfvAQiD7wEID+8BCAPvAQh77wEKA+8BC6fvAQv/7wEL/+8BC2vvAQhv7wEIAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCKfvAQuX7wEL/+8BC//vA
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
QhH7wEKh+8BC/vvAQv/7wEL/+8BCxPvAQgz7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAD7wEID+8BCCvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIV+8BCofvAQvz7wEL/+8BC3/vAQiD7wEIAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCEfvAQo37
wEL2+8BC9fvAQkL7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAA+8BCAPvAQgj7wEJl+8BC4fvAQnb7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIB+8BCPvvAQm/7wEIE
+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/j/////8AAP8H////
/wAA/gP/////AAD8Af////8AAPwA/////wAA/AA/////AAD8AAf///8AAPwAAAA//wAA/AAAAA//
AAD8AAAAB/8AAP8AAAAD/wAA/+AAAAH/AAD//AAAAP8AAP//AAAAfwAA///AAAB/AAD///AAAD8A
AP//4AAAPwAA//+AAAA/AAD//gAAAB8AAP/4AAAAHwAA/+AAAAAfAAD/wAAAAB8AAP+AAAAAHwAA
/wAAAAAfAAD+AAAAIA8AAPwAAAAABwAA+AAAAAAAAADwAAAAAAAAAPAAAAAEAQAA4AAAAAYDAADg
AAAAh48AAMAAAAEP/wAAwAAAAA//AACAAAAID/8AAIAAAIAP/wAAgAAHgA//AACAAD+AH/8AAAAB
/8Af/wAAAAf/wB//AAAAH//AH/8AAAB//+Af/wAAAf//8B//AAAH///wD/8AAB////gP/wAAP///
/A//AAD////+D/8AAP////8P/wAA/////4f/AACJUE5HDQoaCgAAAA1JSERSAAABAAAAAQAIBgAA
AFxyqGYAABf9SURBVHja7d19iJ3lmcfxr8v5YwqzMH+MyygpjBAhQizjMrJxN+6OIZakjbuxG5fY
mt3Y6q5ufatirVot2djaVru+1FapukmrW10SMTQRsxh0MAGDhhrsUAMJOmyDHXbDMiwDO+DA7h/X
HGcS55zzvF/3/Ty/D4g6OXPO9Zyc5zr3y3Xf91lrxj9GpIHGgAnglHcgnv7AOwCRii0DXgCeo+E3
PygBSHO0gJuA3wCbgX3eAYWg5R2ASAVWADuAVYt+9op3UCFQC0DqrAXcDrzL6Tf/LHDAO7gQqAUg
dTWM9fVXLfFn41gSaDy1AKSOrsP6+qs6/Plr3gGGQi0AqZMB4ElskK+b170DDYUSgNTFKLALa/p3
MwUc9Q42FOoCSB3cALxF75sfrP8v89QCkJj1Az8Gtqb4nTe8gw6JEoDEahh4GRhJ+XtvewceEnUB
JEarsSb/SMrfm0b9/9MoAUhstmLN+KEMv3vYO/jQKAFITLZjJb1Zu64HvS8gNBoDkBi0sBv/mpzP
8573hYRGCUBC148N9q0t4LkOeV9MaNQFkJANYWW7Rdz8k9ggoCyiFoCEaggb7FtR0PMd9b6gEKkF
ICEq+uYHWxIsZ+iWAAa9g5NGWoHN8Rd584MGAJfULQEcxAouRKrS/uYfLuG5j3lfXIg6JYAWloFf
I//Ui0gS7Zs/S4FPL7MoASypUwJYNv/vPmz31O1owFDKU0affzHd/B10SgBnZuFvA6+icQEpXj+w
l/JufoAT3hcZqk4JoH+Jn63FRlI1LiBFaWE3/2jJr6MWQAedEsC5HX6+DGuq3YO6BJLfDuyEnrId
977QUHUbBKTLn30XGyAc9r4AidZ2qhtg/sD7YkPVaxCwmzGsS7DV+yIkOtdg40pVmfS+4FDlrQQc
wJpxL6MBQklmFHi64tc86X3RoeqUAM5J+TwbgfdRzYB0N4R9WfRV+JqT3hcdsk4JIMtf0CBWM7CX
ZF0IaZYWdlJP1Z8Nfft3UcZioA1Ya+AWNFMgC7ZTzYj/maa8LzxkZa0G7AcewxZ1lD3HK+FbB3zL
6bWVALooeznwKJYEnsQGDKV5BrGBYi//5f0GhKxTAhgo8DVa2Mktx7FDG6VZdlDOAp+kNAbQRRUJ
oG0Qm/55B5UTN8VWbEzI04z3mxCyTgmgzKw5iu018ByaLaizZcAj3kEA/+kdQMg6JYC5Cl77Gqxb
sB2ND9RRKOM+agF04b0nYB9WEvo+Nk6gacN62IR/07/tlHcAIfNOAG1D2DfG+1hVocSrnzCa/pJA
KAmgbTlWKvoOPkUjkt+9hDW2M+kdQMg6JQDv4olRbN+BN1AhUUyWA7d5ByHJdUoA/+sd2LwxrDWQ
5Rx4qd52ql3oIzl1SgChjZxuxPYeUCII1wiw2TuIM1QxmxW1Tgkg1JHTjSgRhOoh7wCWoCrAHjol
gP/xDqyHjSgRhGSMYg7wlIp1SgDT3oEltBFLBHvRrIGnW70DkGw6JYBJ78BS2sDCrEEoBShNMYJq
N6IV2xhAL2NYa+BdrNRYlYXl07d/xLrNAoQ2E5DGCLbY6Di2M5GmpsoxRHgj/5JCt0rAOoygDmM7
E/0eeBDfdel19LeEnVz78z9FvXVLAJPewRVoANuS6kNsg4oR74Bq4kbvAHrQVvU9NCUBtPVhm1S8
iw0YbkTjBFmtRSdDRa9bAqj7eWpjWB3BceB2wli7HpOveAcg+XVLAE05T20Y+BE2TvAksNI7oAj0
YWv+YzDgHUDIuiWAph2p3IdtSvIbrHuwCXUPOllHPANsA94BhKxbAjhBcxdTjAG7gN9hK9xCWt8e
gi96B5CCkngX3RLAHM1rBZxpCNuy7EOswGgD+kBBXNWWSt5d9NoRaMI7wEC0sA/9XiwZ3E9zP1ij
xFVPoYTdRa8E8I53gAFaBmxjoVWwkWZ9yNZ4B5DSud4BhKxXAnjPO8CAtVsFL2NjBQ8CK7yDqsBl
3gGkNOAdQMh6JYAj3gFGYgirNHwfO/Tkq8QzSp7WKu8AUhrwDiBkvRLANBoITGs18Cx2KOVz1Guj
jJXEd0Od5x1AyJJsC37YO8hI9WFLkl9jYTpxuXdQOX3OO4AMtB6giyQJ4C3vIGtgGTadeBx7P/+R
OD+YF3kHkEFTZ2sSSZIA3vQOsmZWAT/BSo/3Al8m7CW1i8U4yBnTlGXlkiSAY/gfFFJH7VmEf2Vh
vGAdYU8pxpoAYkmwlUt6NNi4d6A114+NF7zKwqKk1d5BLWHAO4CM1A3oIGkCeNU70AYZxBYlHcQG
Dx8hnGRw9vw/V2BnAO4njq3jhr0DCNVZa8Y/TvK4ZdiHUfycBJ4H/g046h3MIi2sPHgNsB4b4wit
G/MPwM+8gwhR0hbASbQuwNsyrNjoXWw24UHCaBnMYVPF3wMuBc4BvgYcIJzVpOd7BxCqNMeD7/EO
Vj6xHEsGIXYTTgH/AlyOJYNb8f/yiL3+ojRpEsAr3sHKkpZhR3K3k8HTWPVhCM3wU8DjwIXAJVgX
ZtYhDiWADpKOAbT9Do2oxuIUNkj3EtYcD2Wwbgi4A7iO6mYVZoHPeF94iNK0AAB2ewcsiQ1iU4sv
Y3UGL2OLlLwrEKeAO7Ea/QeopkXQR5w1DKVLmwBe8g5YMunD9i1oL1I6CHwT36bxNHAflgieofwB
QyWAJaTtAoC6AXVzAtiHbXDyATZgN+kQxyhWADVa0vPfBfzQ4bqClmWg6HlsBFrqYTk2iLjYDFZr
cARbvPQm5ZeDH8EGCm8Bvkvx5bsXlxx/lLK0AFZiW2dLsxzDSsJfmf93mYOKK4AXKPYItwlsNkIW
yZIAwPYKLKupJuGbxWYYdgG/opxk0MLqG24q8Dn/sKRYo5V2ELDtae/AxVV7ULG9kvEFil/JOAfc
DFxLcQOEI5W9Q5HImgB+iTKpmD5gM7Zg7Dg2u1DkVONObCPSUwU81x9X/eaELmsCmMEGA0UWGwZ+
wEJ5clHTjIewdQZ5ByI1EHiGrAkAbFcbkaX0YTML7wM7KGZXnmNYSyBPEohtR+PS5UkAE1iJqUgn
LWArVmPwIPlLf/MmgeUFxFAreRIAqBUgyfSxcG7CNTmf6xi2IUnWMagx7zcjJHkTwB6skkwkiSFs
78O95KsmPQJcnfF3/8T7TQhJ3gQAVrUlksYGrJhsc47n2Ad8J8PvjXlffEiKSAAvol2DJb0BrH5g
B9nLfr9H+g1rR3O8Xu0UkQBmsQEekSy2YusNsnQJ5rBCoTTjAS3UCvhEEQkAbMNFtQIkqxGsvHwk
w+9OAnen/J2/8L7gUBSVANQKkLyGsH0Ksuxt+ATpTrIe877YUBSVAAB+imYEJJ9+rKQ4SxL4RorH
jqJ6AKDYBDCHZgQkv6xJ4BDJd65uAZ/3vtAQFJkAwBZuHPW+KIleOwmk3cZrW4rHXu59kSHIuh9A
N2PAG94XJrUwiS3gSbMS8DVsW/ReTgKfdby2Iaw0+VwWpiVngY+wrnQlg+plJACwjSI2VXEBUnsH
sCPHku4JsAGrNEziYtINHuYxCPzl/LWM0XvJ9BTWrXkV23SliOXQn1J0F6DtTnwOgJD6WYvtMZDU
fuzbPYkqxgHGsC/E32O7Mm8i2X4JQ/OPfXb+d/dim64UqqwEMAlsL+m5pXm2kXwp7xzJ96q4ssSY
V2Nd4TewGznPbkktrGXzKnY25MaigiwrAQD8M5oWlGK0sG3okt5ESc+vGKX4Le4HsQVPBymn3mAE
O+TlILZBby5lJoBZ4MYSn1+aZSVwe8LHHiF5N+BLBca4iWKWPCexGmsN3E+O1kWZCQBsAGdnBW+G
NMPdJN9daH/Cx11VQFwt7FCTXVR79FoL6x69Q8bt18pOAGAVWkmzsUg3A9gJP0m8lvBxq8nXDRjC
+vk3+L0tjGCtgdQzb1UkgGnUFZDi3ECyVsDbKZ4zazdgBdnXLxStH2uB3J/ml6pIAGCbN+ys+A2R
euoDbk3wuEmSz51n6QaswL75PQ9YXco2bBAy0bhAVQkArCsw6fCGSP1cR7JNPZIW+awm3Y3cvvmL
2O24DO1j4ft7PbDKBDANbKH8Y6Cl/gZJNhd+LOHzTWGfzyRCv/nb2nUDXZNAlQkArLRRBUJShK8l
eMyHCZ9rC8m6C0PY4GLoN3/banokgaoTANg+boe83hGpjTF6T7n9R4Ln+T7Jzrdor1AsunCobKux
vReXHBPwSABz2JbO2kJM8mgBX+jxmF7f6keA+xK+VtHHlVdpDPjqUn/gkQDA6gI0HiB5re/x593q
T6ax0f8kn8HvYH3qmJwCnsL2PTgb27fzU7wSAFizK8u+7iJtYzl+91qSzUptAL7tfaEJzWLb9K8H
zsHqbw7QZWVuWfsBpKG9AySP8+m+6Oz/lvjZUyQrThvGKuwGvC+yhymsFDn17tyeLYC2a9E2YpLd
51I+/ijJNhBt9/sHvC+wiymsKOo84J/IMK4WQgKYwQ571KCgZHFJisdOY3sAJNms5h7CPU58Fus+
nwc8nvB6lhRCAgAbrLmS7Ce+SnOlqeBL2u9fRbLZAQ8HgAuwb/zcu26FkgAADmN/QZoZkDS6JYDF
c/YPk2zb8H7svMI8O/iUYRa4GRvVnyzqSUO7yN3YX9oj3oFINIa7/Fn78z1O8uPDHiH9duRlm8K6
yYVvYBpSC6DtUSxbiyTRT+eFQYNY9/JqkrUsN2MLjUJyDLiIknYvDjEBgO0qvNM7CIlGt9r8K0k2
wLwS23cwJMeAyxLGn0loXYDFrseyu2oEpJdOi12Sfmu2N9PouXy2QlNYQU+ps2OhtgBgYc3AHu9A
JHh59uFrYTd/aP3+LVSwf0bICQAsCWxBqwelPI9QwoEbOT1FshWKuYWeAMBqA9ajJCDF+xZwk3cQ
Z5imwhqEGBIAKAlI8W4DHvQOYgk7KekcwKXEkgBgIQns9g5EgpO2Iu42wq01+XmVLxZTAgBLAlej
JCCnSzpS3gIeItybf4qKF8aFPA3YSXt2YJrwijbER5Iin/aZfaEN+C1WeRc3thZA2xxWJ6CKQYHe
J09txtb1h3zzMx9jpWJNAG13Ymu7tYCo2Z7k0+v220dqv4Gt649hM8/fVv2CIewIVIRN2AqukCq5
pFozWBN6CisNXkXYm3ks5QKSn2VQiLokALDtj3cRz57tIovNAZ+h4tZs7F2AxQ5hu8NUmkFFCnIC
h65snRIAWO30xSQ/G14kFCfyP0V6dUsAsLDH4APegYik4NJyrWMCAGtK3Ycd/KB9BiUGxz1etK4J
oG03Ni7g0rwSSaHyKUCofwIAmMC2VHrROxCRLtQFKFF7DcGNFLCVskjBTlHhCsDFmpIA2p5CXQIJ
z4TXCzctAYCttroIeMY7EJF5SgAVm8EWE12FU9NLZJH3vV64qQmgbTfWGtjnHYg02q+9XrjpCQBs
KekV2AChagbEg7oAAXgKuJCKdmMVmXcCxy8eJYDTTWKHL16L7TgkUrajni+uBLC0ndjabBUPSdne
8nxxJYDOprDiofVUcEKLNNZ7ni+uBNDbfqw18ACqIpTilXLqb1JKAMnMYqsLL0RThlKcCZzHmpQA
0jmBTRmuRzsPSX6HvQNQAshmP9Ya+DqaLZDsDnoHoASQ3RzwU+A87HwCjQ9IWm97B6AEkN80dj7B
Bdj0oc4okCSmCKAbqQRQnEmsgOgiYI93MBK8ce8AQAmgDBPAlSgRSHeveQcASgBlOooSgXT2uncA
oARQhaMoEcjpThBIdakSQHWOYongQjRY2HTBHFyjBFC9CWyw8DzgUVRH0ESveAfQpgTg5yR2tPl5
wK0E0iSU0s0QyAwAKAGEYBp4HDgf6yJoQ5J6209ARWNKAOGYwwYJL8fGCZ5A3YM6etk7gMWUAMI0
AdwMnAP8HQEsGpFCzAK/8g5iMSWAsM0Cv8AOM7kAW3Mw5R2UZLafwDaeVQKIxzFszcFnseXIzxPY
h0l62uUdwJnOWjP+sXcMkl0f8CXsgJN18/8vYZrBunRBJW21AOI2C/wSmz04G0sEz6PBwxDtIbCb
H5QA6mQGO+loC3bIiYTlWe8AlqIEUD/XAc95ByGnmSSg4p/FlADq5R7gaaDlHYic5knvADrRB6Ue
WtiH7DrvQORT2lO5QVICiN8g8AKw1jsQWdJuAq7dUAKI2whWWjrsHYh09Jh3AN1oDCBeW7FtpYe9
A5GOxnE++acXtQDi0w/8GEsAErYfeQfQixJAXEaw/v4K70Ckp6NEcIycugBxaAHfBN5BN38stnkH
kIRaAOFbAewAVnkHIokdJZINYNUCCFcLuB94F938sbnbO4Ck1AII02qsok/N/fiME9Cuv72oBRCW
IayO/yC6+WM0h230Gg21AMLQB9yCNR0HvIORzHZi/f9oKAH42wQ8CCz3DkRymSaivn+bEoCfMezG
1wBfPdwJnPIOIi0lgOqNYDf+Ou9ApDDjwDPeQWShQcDqjGALd95FN3+dzGBHvUVJLYDyjQL3Ahu9
A5FS3E3Ex7opAZRnLXbjj3kHIqXZg53gFC0lgGK1gM3AHViTX+rrJHC9dxB5KQEUYxD4e+w4ryHv
YKR0c9gW7NGN+p9JCSCfUeDr2Le+DuVojhupyXmNSgDp9QNfxpp/o97BSOWeINIpv6UoASS3Cjup
9xosCUjz7CGyWv9elAC6W4Z921+LFuc03SHs1KU570CKpATwaf3YgZtbsCk8vUcygZ3IHNzZfnnp
w236sOq8rwAb0ICeLDgGXE4Nb35odgLox4p1/hqr0lO/Xs50CDt5Ofrpvk6algAGgc9jc7jr0De9
dHYAu/lr+c3f1oQEsAL4AvaXuaoh1yz57MSmeWs14LeUOt4M/djg3Rexb/lh74AkGnPY4p6HvQOp
Sh0SQAsryFmDDdasQk17SW8Km/k54B1IlWJMAC1gJfDnwGXYQJ4G8CSP/VitR7Cn+JYlhgTQj32r
/ylwCbZltm54KcIM1uSPeklvHqEmgJXAXdiS2pXewUgt7cNWb056B+Ip1ARwB1ZzL1K0E1g9f/AH
d1YhxD0B+7CtskWKNIUt3b4A3fyfCLEFoD6+FOkk8BDwM2DWO5jQhJgA/so7AKmFw8BjwG4aUNCT
VYgJYK13ABKtk8CLwM+xFXzSQ2gJYAitu5d0JrGNOl7CFu9ICqElAB2TJb2cxG70N4A3seW6klFo
CeDPvAOQYJzCvt1PYKcp/RY7efekd2B1EloCUPO/OlPYibZT2M02g91cH8//bHb+Z/89//gZTl8X
P0v20tnhM/5/iIX1G1PzcdR6GW4oQksAqvorxhT27dn+50Pgo/mft28wT5M9/l8qElIC6ENLd9Oa
xJrFx7Bm8gfz/61vT0kkpASwzDuAwJ3CBr/eAn4NHMGa8CKZKQGEawY7d/5V4HU02i0lCCkB/JF3
AAGYxirXXsJufpWuSqlCSgBN3sVnP/AstkhFN71UJqQE0DSzwPPAD7C5bpHKKQFUbw47XHIbDdyC
SsKiBFCt3dgWVPrGlyCElADqvGRzAtt+atw7EJHFQtoR6CPvAEowi+1teBG6+SVAIbUAvMtTi3YY
22pa8/cSrJBaAJPUoxswh33rX4pufglcSAlgjvh3cTmBnV3wQ+qRzKTmQkoAYM3mWO3G+vpHvAMR
SSq0BPDv3gFkMAfciR05rlV4EpWQBgHBDmacJZ6y4Bnsxt/vHYhIFqG1AGawpnQMTgAXo5tfIhZa
AgD4iXcACRxGo/xSAyEmgMOEXTSzH7gc1fFLDYSYAMAWyoRoN3AFGuyTmgg1AYwTXt/6GeBqNL8v
NRJqAgA7wjmUm+1R4PqA4hEpRMgJ4BjwsHcQ2M3/De8gRMoQcgIAGwvwHGl/Ed38UmOhJ4BZbEWd
R9N7N7DF+w0QKVPoCQBsWvDeil/zEBrwkwaIIQGAra7bV9FrHQXWo5tfGiCWBAD2jVz2eMBJ7ObX
PL80QkwJYAa7OcuqwCv7+UWCE1MCANs16DKKv0nnsBZG7BuSiKQSWwIA6wZcRbEHY95HdWMMIsGI
MQGAjdJfQjEtgReB73tfkIiHWBMAWEvgMvINDE5gJb4ijRRzAgC7+S/FdhJKq72bj0b8pbFiTwAA
p7DR+7TrBq5HG3pIw9UhAcDCxpxXYAmhl51Y31+k0eqSANr2ARfQfV/BSeycPpHGq1sCAGsBXAVc
id3si7Xn+9XvF6GeCaBtD9YauIuFmoFHifvwEZFCnbVm/GPvGKowAPwN8AtsibGIAP8PfIUYQezf
itEAAAAASUVORK5CYIIL'))
	#endregion
	$formMigrationHistory.Icon = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$formMigrationHistory.IsMdiContainer = $True
	$formMigrationHistory.Margin = '4, 5, 4, 5'
	$formMigrationHistory.MaximizeBox = $False
	$formMigrationHistory.Name = 'formMigrationHistory'
	$formMigrationHistory.SizeGripStyle = 'Show'
	$formMigrationHistory.Text = 'Migration History'
	$formMigrationHistory.add_Load($formMigrationHistory_Load)
	#
	# panel1
	#
	$panel1.Controls.Add($labelDeletionOfTheseObjec)
	$panel1.Controls.Add($buttonExitHistory)
	$panel1.Controls.Add($labelLoadSelectedForMigra)
	$panel1.Controls.Add($buttonOpenDirectory)
	$panel1.Controls.Add($historyPath)
	$panel1.Controls.Add($labelThisInformationIsSto)
	$panel1.Controls.Add($buttonLoad)
	$panel1.Anchor = 'Bottom, Left'
	$panel1.Location = New-Object System.Drawing.Point(18, 402)
	$panel1.Margin = '4, 5, 4, 5'
	$panel1.Name = 'panel1'
	$panel1.Size = New-Object System.Drawing.Size(1284, 110)
	$panel1.TabIndex = 9
	#
	# labelDeletionOfTheseObjec
	#
	$labelDeletionOfTheseObjec.Anchor = 'None'
	$labelDeletionOfTheseObjec.AutoSize = $True
	$labelDeletionOfTheseObjec.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$labelDeletionOfTheseObjec.ForeColor = [System.Drawing.Color]::DarkOrange 
	$labelDeletionOfTheseObjec.Location = New-Object System.Drawing.Point(942, 8)
	$labelDeletionOfTheseObjec.Margin = '4, 0, 4, 0'
	$labelDeletionOfTheseObjec.Name = 'labelDeletionOfTheseObjec'
	$labelDeletionOfTheseObjec.Size = New-Object System.Drawing.Size(338, 80)
	$labelDeletionOfTheseObjec.TabIndex = 9
	$labelDeletionOfTheseObjec.Text = 'Deletion of these objects is not 100% reliable.
Please take care when using this function and 
verify that the removal of these files was sucessful
in your repository.'
	#
	# buttonExitHistory
	#
	$buttonExitHistory.Anchor = 'None'
	$buttonExitHistory.DialogResult = 'Cancel'
	$buttonExitHistory.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$buttonExitHistory.Location = New-Object System.Drawing.Point(22, 51)
	$buttonExitHistory.Margin = '4, 5, 4, 5'
	$buttonExitHistory.Name = 'buttonExitHistory'
	$buttonExitHistory.Size = New-Object System.Drawing.Size(127, 43)
	$buttonExitHistory.TabIndex = 2
	$buttonExitHistory.Text = 'Exit History'
	$buttonExitHistory.UseVisualStyleBackColor = $True
	$buttonExitHistory.add_MouseClick($buttonExitHistory_MouseClick)
	#
	# labelLoadSelectedForMigra
	#
	$labelLoadSelectedForMigra.Anchor = 'None'
	$labelLoadSelectedForMigra.AutoSize = $True
	$labelLoadSelectedForMigra.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$labelLoadSelectedForMigra.ForeColor = [System.Drawing.Color]::DarkOrange 
	$labelLoadSelectedForMigra.Location = New-Object System.Drawing.Point(298, 10)
	$labelLoadSelectedForMigra.Margin = '4, 0, 4, 0'
	$labelLoadSelectedForMigra.Name = 'labelLoadSelectedForMigra'
	$labelLoadSelectedForMigra.Size = New-Object System.Drawing.Size(238, 24)
	$labelLoadSelectedForMigra.TabIndex = 8
	$labelLoadSelectedForMigra.Text = 'Load Selected For Migration'
	#
	# buttonOpenDirectory
	#
	$buttonOpenDirectory.Anchor = 'None'
	$buttonOpenDirectory.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '9.75')
	$buttonOpenDirectory.Location = New-Object System.Drawing.Point(682, 51)
	$buttonOpenDirectory.Margin = '4, 5, 4, 5'
	$buttonOpenDirectory.Name = 'buttonOpenDirectory'
	$buttonOpenDirectory.Size = New-Object System.Drawing.Size(118, 48)
	$buttonOpenDirectory.TabIndex = 5
	$buttonOpenDirectory.Text = 'Open Directory'
	$buttonOpenDirectory.UseVisualStyleBackColor = $True
	$buttonOpenDirectory.add_Click($buttonOpenDirectory_Click)
	#
	# historyPath
	#
	$historyPath.Anchor = 'None'
	$historyPath.Font = [System.Drawing.Font]::new('Franklin Gothic Medium Cond', '12')
	$historyPath.LinkColor = [System.Drawing.Color]::SkyBlue 
	$historyPath.Location = New-Object System.Drawing.Point(528, 27)
	$historyPath.Margin = '4, 0, 4, 0'
	$historyPath.Name = 'historyPath'
	$historyPath.Size = New-Object System.Drawing.Size(503, 29)
	$historyPath.TabIndex = 6
	$historyPath.TabStop = $True
	$historyPath.Text = 'linklabel1'
	$historyPath.TextAlign = 'TopCenter'
	$historyPath.add_LinkClicked($historyPath_LinkClicked)
	#
	# labelThisInformationIsSto
	#
	$labelThisInformationIsSto.Anchor = 'None'
	$labelThisInformationIsSto.AutoSize = $True
	$labelThisInformationIsSto.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '9.75')
	$labelThisInformationIsSto.ForeColor = [System.Drawing.Color]::DarkOrange 
	$labelThisInformationIsSto.Location = New-Object System.Drawing.Point(656, 10)
	$labelThisInformationIsSto.Margin = '4, 0, 4, 0'
	$labelThisInformationIsSto.Name = 'labelThisInformationIsSto'
	$labelThisInformationIsSto.Size = New-Object System.Drawing.Size(162, 17)
	$labelThisInformationIsSto.TabIndex = 4
	$labelThisInformationIsSto.Text = 'This Information Is Stored at'
	#
	# buttonLoad
	#
	$buttonLoad.Anchor = 'None'
	$buttonLoad.DialogResult = 'Yes'
	$buttonLoad.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$buttonLoad.Location = New-Object System.Drawing.Point(345, 51)
	$buttonLoad.Margin = '4, 5, 4, 5'
	$buttonLoad.Name = 'buttonLoad'
	$buttonLoad.Size = New-Object System.Drawing.Size(157, 43)
	$buttonLoad.TabIndex = 7
	$buttonLoad.Text = 'Load'
	$buttonLoad.UseVisualStyleBackColor = $True
	$buttonLoad.add_Click($buttonLoad_Click)
	#
	# historyGrid
	#
	$historyGrid.AccessibleRole = 'None'
	$historyGrid.AllowUserToAddRows = $False
	$historyGrid.AllowUserToDeleteRows = $False
	$historyGrid.AllowUserToOrderColumns = $True
	$System_Windows_Forms_DataGridViewCellStyle_1 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_1.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$historyGrid.AlternatingRowsDefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_1
	$historyGrid.Anchor = 'Top, Bottom, Left, Right'
	$historyGrid.AutoSizeColumnsMode = 'AllCells'
	$historyGrid.AutoSizeRowsMode = 'AllCells'
	$historyGrid.BackgroundColor = [System.Drawing.Color]::DimGray 
	$historyGrid.BorderStyle = 'Fixed3D'
	$historyGrid.CellBorderStyle = 'SingleVertical'
	$historyGrid.ColumnHeadersBorderStyle = 'Sunken'
	$historyGrid.ColumnHeadersHeight = 30
	[void]$historyGrid.Columns.Add($date)
	[void]$historyGrid.Columns.Add($CMDBLink)
	[void]$historyGrid.Columns.Add($operation)
	[void]$historyGrid.Columns.Add($target)
	[void]$historyGrid.Columns.Add($destination)
	[void]$historyGrid.Columns.Add($encryptionkey)
	[void]$historyGrid.Columns.Add($username)
	[void]$historyGrid.Columns.Add($migconfig)
	[void]$historyGrid.Columns.Add($Delete)
	$historyGrid.ContextMenuStrip = $contextmenustrip1
	$historyGrid.Location = New-Object System.Drawing.Point(18, 24)
	$historyGrid.Margin = '4, 5, 4, 5'
	$historyGrid.MultiSelect = $False
	$historyGrid.Name = 'historyGrid'
	$historyGrid.RowHeadersBorderStyle = 'Sunken'
	$historyGrid.RowHeadersVisible = $False
	$System_Windows_Forms_DataGridViewCellStyle_2 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_2.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$historyGrid.RowsDefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_2
	$historyGrid.RowTemplate.DefaultCellStyle.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$historyGrid.RowTemplate.Resizable = 'True'
	$historyGrid.SelectionMode = 'FullRowSelect'
	$historyGrid.ShowCellErrors = $False
	$historyGrid.ShowCellToolTips = $False
	$historyGrid.ShowEditingIcon = $False
	$historyGrid.ShowRowErrors = $False
	$historyGrid.Size = New-Object System.Drawing.Size(1293, 368)
	$historyGrid.TabIndex = 0
	$historyGrid.VirtualMode = $True
	$historyGrid.add_CellContentClick($historyGrid_CellContentClick)
	$historyGrid.add_CellDoubleClick($historyGrid_CellDoubleClick)
	$historyGrid.add_MouseDoubleClick($historyGrid_MouseDoubleClick)
	#
	# contextmenustrip1
	#
	$contextmenustrip1.ImeMode = 'NoControl'
	[void]$contextmenustrip1.Items.Add($RemoveTS)
	$contextmenustrip1.LayoutStyle = 'Table'
	$contextmenustrip1.Name = 'contextmenustrip1'
	$contextmenustrip1.RenderMode = 'System'
	$contextmenustrip1.ShowCheckMargin = $True
	$contextmenustrip1.Size = New-Object System.Drawing.Size(133, 26)
	#
	# RemoveTS
	#
	$RemoveTS.DisplayStyle = 'Text'
	$RemoveTS.Name = 'RemoveTS'
	$RemoveTS.ShowShortcutKeys = $False
	$RemoveTS.Size = New-Object System.Drawing.Size(132, 22)
	$RemoveTS.Text = 'Remove'
	#
	# date
	#
	$date.AutoSizeMode = 'DisplayedCells'
	$date.DataPropertyName = 'date'
	$System_Windows_Forms_DataGridViewCellStyle_3 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_3.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '9.75')
	$System_Windows_Forms_DataGridViewCellStyle_3.Format = 'g'
	$date.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_3
	$date.Frozen = $True
	$date.HeaderText = 'date'
	$date.MaxInputLength = 15
	$date.Name = 'date'
	$date.Width = 71
	#
	# CMDBLink
	#
	$CMDBLink.AutoSizeMode = 'Fill'
	$CMDBLink.ContextMenuStrip = $contextmenustrip1
	$CMDBLink.DataPropertyName = 'CMDBLink'
	$System_Windows_Forms_DataGridViewCellStyle_4 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_4.Alignment = 'MiddleCenter'
	$System_Windows_Forms_DataGridViewCellStyle_4.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '8.25')
	$System_Windows_Forms_DataGridViewCellStyle_4.ForeColor = [System.Drawing.Color]::Black 
	$System_Windows_Forms_DataGridViewCellStyle_4.NullValue = "$"
	$System_Windows_Forms_DataGridViewCellStyle_4.SelectionForeColor = [System.Drawing.Color]::Lime 
	$CMDBLink.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_4
	$CMDBLink.FillWeight = 1
	$CMDBLink.HeaderText = 'CMDBLink'
	$CMDBLink.MinimumWidth = 100
	$CMDBLink.Name = 'CMDBLink'
	$CMDBLink.Resizable = 'False'
	$CMDBLink.SortMode = 'Automatic'
	$CMDBLink.Text = 'LinkToClipboard'
	$CMDBLink.ToolTipText = 'Copy this to your clipboard to paste in browser.'
	#
	# operation
	#
	$operation.AutoSizeMode = 'ColumnHeader'
	$operation.DataPropertyName = 'operation'
	$System_Windows_Forms_DataGridViewCellStyle_5 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_5.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$operation.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_5
	$operation.HeaderText = 'operation'
	$operation.MaxInputLength = 15
	$operation.MinimumWidth = 65
	$operation.Name = 'operation'
	$operation.Width = 112
	#
	# target
	#
	$target.AutoSizeMode = 'ColumnHeader'
	$target.DataPropertyName = 'target'
	$System_Windows_Forms_DataGridViewCellStyle_6 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_6.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$target.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_6
	$target.HeaderText = 'PCName'
	$target.MaxInputLength = 25
	$target.Name = 'target'
	$target.Width = 106
	#
	# destination
	#
	$destination.AutoSizeMode = 'ColumnHeader'
	$destination.DataPropertyName = 'Destination'
	$System_Windows_Forms_DataGridViewCellStyle_7 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_7.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$destination.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_7
	$destination.FillWeight = 85
	$destination.HeaderText = 'destination'
	$destination.MaxInputLength = 100
	$destination.MinimumWidth = 55
	$destination.Name = 'destination'
	$destination.Width = 126
	#
	# encryptionkey
	#
	$encryptionkey.AutoSizeMode = 'ColumnHeader'
	$encryptionkey.DataPropertyName = 'EncryptionKey'
	$System_Windows_Forms_DataGridViewCellStyle_8 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_8.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$encryptionkey.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_8
	$encryptionkey.HeaderText = 'Key'
	$encryptionkey.MaxInputLength = 50
	$encryptionkey.Name = 'encryptionkey'
	$encryptionkey.Width = 65
	#
	# username
	#
	$username.AutoSizeMode = 'ColumnHeader'
	$username.DataPropertyName = 'Username'
	$System_Windows_Forms_DataGridViewCellStyle_9 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_9.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$username.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_9
	$username.HeaderText = 'username'
	$username.MaxInputLength = 27
	$username.Name = 'username'
	$username.Width = 117
	#
	# migconfig
	#
	$migconfig.AutoSizeMode = 'ColumnHeader'
	$migconfig.DataPropertyName = 'MigConfig'
	$System_Windows_Forms_DataGridViewCellStyle_10 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_10.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$migconfig.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_10
	$migconfig.HeaderText = 'migconfig'
	$migconfig.MaxInputLength = 8
	$migconfig.Name = 'migconfig'
	$migconfig.Width = 117
	#
	# Delete
	#
	$Delete.AutoSizeMode = 'ColumnHeader'
	$Delete.DataPropertyName = 'Delete'
	$System_Windows_Forms_DataGridViewCellStyle_11 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_11.Alignment = 'MiddleCenter'
	$System_Windows_Forms_DataGridViewCellStyle_11.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$Delete.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_11
	$Delete.FillWeight = 41
	$Delete.HeaderText = 'Delete'
	$Delete.Name = 'Delete'
	$Delete.Resizable = 'True'
	$Delete.ToolTipText = 'This will completely erase this migration'
	$Delete.UseColumnTextForButtonValue = $True
	$Delete.Width = 69
	$contextmenustrip1.ResumeLayout()
	$historyGrid.EndInit()
	$panel1.ResumeLayout()
	$formMigrationHistory.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $formMigrationHistory.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$formMigrationHistory.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$formMigrationHistory.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$formMigrationHistory.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $formMigrationHistory.ShowDialog()

}
#endregion Source: HistoryWindow.psf

#region Source: USMT-Remote-Gui.psf
function Show-USMT-Remote-Gui_psf
{
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('sysglobl, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$MainForm = New-Object 'System.Windows.Forms.Form'
	$label200 = New-Object 'System.Windows.Forms.Label'
	$txt_appendUSMT = New-Object 'System.Windows.Forms.TextBox'
	$chkbox_NoShares = New-Object 'System.Windows.Forms.CheckBox'
	$picturebox1 = New-Object 'System.Windows.Forms.PictureBox'
	$labelMouseOverFieldsForHe = New-Object 'System.Windows.Forms.Label'
	$labelCancelJob = New-Object 'System.Windows.Forms.Label'
	$panel_SoloPanel = New-Object 'System.Windows.Forms.Panel'
	$PanelSelectUser = New-Object 'System.Windows.Forms.Panel'
	$combo_userchoice = New-Object 'System.Windows.Forms.ComboBox'
	$HelpButton = New-Object 'System.Windows.Forms.Button'
	$button_GetUsers = New-Object 'System.Windows.Forms.Button'
	$labelSelectUser = New-Object 'System.Windows.Forms.Label'
	$Panel_TargetPC = New-Object 'System.Windows.Forms.Panel'
	$button2 = New-Object 'System.Windows.Forms.Button'
	$button1 = New-Object 'System.Windows.Forms.Button'
	$lb_migrationXMLS = New-Object 'System.Windows.Forms.ListBox'
	$lbl_migconfig = New-Object 'System.Windows.Forms.Label'
	$RadioRestore = New-Object 'System.Windows.Forms.RadioButton'
	$RadioBackup = New-Object 'System.Windows.Forms.RadioButton'
	$labelOFFLINE = New-Object 'System.Windows.Forms.Label'
	$labelTargetPC = New-Object 'System.Windows.Forms.Label'
	$txt_SourceComputer = New-Object 'System.Windows.Forms.TextBox'
	$labelSelectOperation = New-Object 'System.Windows.Forms.Label'
	$Panel_SelectOldPC = New-Object 'System.Windows.Forms.Panel'
	$combo_selectOldPC = New-Object 'System.Windows.Forms.ComboBox'
	$ButtonCheckAvailable = New-Object 'System.Windows.Forms.Button'
	$lbl_oldpc = New-Object 'System.Windows.Forms.Label'
	$panel_Shares = New-Object 'System.Windows.Forms.Panel'
	$buttonSources = New-Object 'System.Windows.Forms.Button'
	$txt_usmtfile = New-Object 'System.Windows.Forms.TextBox'
	$button_proselect = New-Object 'System.Windows.Forms.Button'
	$label_usmtsource = New-Object 'System.Windows.Forms.Label'
	$labelProfilePath = New-Object 'System.Windows.Forms.Label'
	$txt_proselect = New-Object 'System.Windows.Forms.TextBox'
	$panel_noShares = New-Object 'System.Windows.Forms.Panel'
	$btn_noSharesUSMT = New-Object 'System.Windows.Forms.Button'
	$txt_localusmtfiles = New-Object 'System.Windows.Forms.TextBox'
	$btn_nosharesMig = New-Object 'System.Windows.Forms.Button'
	$labelLocalUSMTFilesPath = New-Object 'System.Windows.Forms.Label'
	$labelLocalUSMTmigFile = New-Object 'System.Windows.Forms.Label'
	$txt_localmigfile = New-Object 'System.Windows.Forms.TextBox'
	$labelOldPCName = New-Object 'System.Windows.Forms.Label'
	$buttonAbout = New-Object 'System.Windows.Forms.Button'
	$txt_usmtString = New-Object 'System.Windows.Forms.TextBox'
	$labelX = New-Object 'System.Windows.Forms.Label'
	$txt_keyItem = New-Object 'System.Windows.Forms.TextBox'
	$lbl_operationSelection = New-Object 'System.Windows.Forms.Label'
	$labelEncryptionKey = New-Object 'System.Windows.Forms.Label'
	$label202 = New-Object 'System.Windows.Forms.Label'
	$labelMultipleJobsDisabled = New-Object 'System.Windows.Forms.Label'
	$buttonShowHistory = New-Object 'System.Windows.Forms.Button'
	$checkboxVerboseLogging = New-Object 'System.Windows.Forms.CheckBox'
	$buttonshowC = New-Object 'System.Windows.Forms.Button'
	$DGV_jobstatus = New-Object 'System.Windows.Forms.DataGridView'
	$buttonCMTraceLog = New-Object 'System.Windows.Forms.Button'
	$buttonQuit = New-Object 'System.Windows.Forms.Button'
	$button_begin = New-Object 'System.Windows.Forms.Button'
	$panel_batchBox = New-Object 'System.Windows.Forms.GroupBox'
	$buttonGoBackSingle = New-Object 'System.Windows.Forms.Button'
	$RadioBatchRestore = New-Object 'System.Windows.Forms.RadioButton'
	$RadioBatchBackup = New-Object 'System.Windows.Forms.RadioButton'
	$labelCsvWillLoadHere = New-Object 'System.Windows.Forms.Label'
	$labelOldPCAndNewPCRelates = New-Object 'System.Windows.Forms.Label'
	$labelRunMigrationProcedur = New-Object 'System.Windows.Forms.Label'
	$labelTheCSVMustContainOld = New-Object 'System.Windows.Forms.Label'
	$buttonRunBatch = New-Object 'System.Windows.Forms.Button'
	$datagridview1 = New-Object 'System.Windows.Forms.DataGridView'
	$labelUSMTRemoteMigrationG = New-Object 'System.Windows.Forms.Label'
	$logtextbox = New-Object 'System.Windows.Forms.RichTextBox'
	$Dialog_OpenMultiCSV = New-Object 'System.Windows.Forms.OpenFileDialog'
	$dialog_savefile = New-Object 'System.Windows.Forms.SaveFileDialog'
	$tooltip1 = New-Object 'System.Windows.Forms.ToolTip'
	$dialog_usmtSources = New-Object 'System.Windows.Forms.OpenFileDialog'
	$timer1 = New-Object 'System.Windows.Forms.Timer'
	$timerJobTracker = New-Object 'System.Windows.Forms.Timer'
	$filesystemwatcher1 = New-Object 'System.IO.FileSystemWatcher'
	$timer2 = New-Object 'System.Windows.Forms.Timer'
	$helpprovider1 = New-Object 'System.Windows.Forms.HelpProvider'
	$bindingsource1 = New-Object 'System.Windows.Forms.BindingSource'
	$notifyicon1 = New-Object 'System.Windows.Forms.NotifyIcon'
	$timer3 = New-Object 'System.Windows.Forms.Timer'
	$num = New-Object 'System.Windows.Forms.DataGridViewTextBoxColumn'
	$JobName = New-Object 'System.Windows.Forms.DataGridViewButtonColumn'
	$State = New-Object 'System.Windows.Forms.DataGridViewTextBoxColumn'
	$jobStart = New-Object 'System.Windows.Forms.DataGridViewTextBoxColumn'
	$JobEnd = New-Object 'System.Windows.Forms.DataGridViewTextBoxColumn'
	$result = New-Object 'System.Windows.Forms.DataGridViewTextBoxColumn'
	$Cancel = New-Object 'System.Windows.Forms.DataGridViewButtonColumn'
	$AddXMLS = New-Object 'System.Windows.Forms.OpenFileDialog'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
		
	[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
	[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
	Import-Module PoshRSJob
	#region Globals
	
	$JobTrackerList = New-Object System.Collections.ArrayList
	$JobTrackerLog = New-Object System.Collections.ArrayList
	##
	# ** ------------------------------- ** #
	##
	#region RemoteTests
	##
	#This looks in the profile directory for profiles that are available for restoration
	function check-AvailableMigs
	{	
		$h = [System.Timers.Timer]
		$timer = [Diagnostics.Stopwatch]::StartNew()
		$done = $false
		$oldtargetpc = $null
		$timeout= 10
		$pcsPresent = $($txt_proselect.Text)
		$oldtargetpc = Get-ChildItem $($txt_proselect.text) -Name -Directory
		
			foreach ($mig in $oldtargetpc)
			{
				Update-ComboBox $combo_selectOldPC $mig -append
			}
			$combo_selectOldPC.displaymember = $combo_selectOldPC.items[0]
			$combo_selectOldPC.valuemember = $combo_selectOldPC.items[0]
			$combo_selectOldPC.selectedItem = $combo_selectOldPC.items[0]
		}
	
	#quick test to see if PC is online.
	#tests for PC being online
	function testport ($hostname = $targetPC, $port = 445, $timeout = 100)
	{
		$requestCallback = $state = $null
		$client = New-Object System.Net.Sockets.TcpClient
		$beginConnect = $client.BeginConnect($hostname, $port, $requestCallback, $state)
		Start-Sleep -milli $timeOut
		if ($client.Connected) { return 'Online'}
		else { return 'fail'}
		$client.Close()
		
	}
	
	function check-computer
	{
		Update-Log "`nVerifying to be sure $Source is actually online`n"
		
		$delay = 0
		$count = 1
		$ok = $false
		$c = 0
		$isOnline = $false
		$pc = $Source
		try
		{
			do
			{
				$c++
				if ($c -gt $Count)
				{
					# count exceeded
					break
				}
				$start = Get-Date
				
				$tcpobject = [system.Net.Sockets.TcpClient]::new()
				$connect = $tcpobject.BeginConnect($pc, 445, $null, $null)
				$wait = $connect.AsyncWaitHandle.WaitOne(1000, $false)
				Update-Log "testing $pc"
				if (!$wait)
				{
					# no response from port
					$tcpobject.Close()
					$tcpobject.Dispose()
					Update-Log "PC specified is not online!!PC must be online!"
					$button_begin.Enabled = $false
					$ok=$true
				}
				else
				{
					try
					{
						# port is reachable
						[void]$tcpobject.EndConnect($connect)
						$tcpobject.Close()
						$tcpobject.Dispose()
						$ErrorActionPreference = 'SilentlyContinue'
						Update-Log "$source is online and reachable `n"
						$txt_SourceComputer.BackColor = [System.Drawing.Color]::PaleGreen
						$targetUsers = Get-ChildItem \\$source\c$\users -Attributes !hidden -Exclude *Administrator*, *defaultuser0*, *Public*, *.net*, *'$'*  -name
						foreach ($user in $targetusers)
						{
							Update-ComboBox $combo_userchoice "$user" -append
						}
						$combo_userchoice.displaymember = $combo_userchoice.items[0]
						$combo_userchoice.valuemember = $combo_userchoice.items[0]
						$combo_userchoice.SelectedItem = $combo_userchoice.items[0]
						$button_begin.Enabled=$true
						$ok = $true
					}
					catch
					{
						# access to port restricted
						Update-Log "You are using the wrong account or DNS is incorrect for target PC."
					}
				}
				$stop = Get-Date
				$timeUsed = ($stop - $start).TotalMilliseconds
			}
			until ($ok)
		}
		finally
		{
			# dispose objects to free memory
			if ($tcpobject)
			{
				$tcpobject.Close()
				$tcpobject.Dispose()
			}
		}
		
	}
	##
	#endregion remotetests
	##
	# ** ------------------------------- ** #
	##
	#region RemoteActions
	##
	#pop open the remote CM Trace file of the current operation
	function Open-CMTracefile
	{
		param ($job)
		$targetshare = '\\' + $source + '\c$\'
		switch ($job)
		{
			"Backup" { $file = "backup.log" }
			"Restore" { $file = "restore.log" }
		}
		if ($(get-command cmtrace.exe) -ne $null)
		{
			if ($RadioBackup.Checked)
			{
				if ($(Test-Path $targetshare\windows\temp\usmtfiles\$file) -eq $TRUE)
				{
					Start-Process -FilePath "cmtrace.exe" -ArgumentList $targetshare\windows\temp\usmtfiles\$file -PassThru -ErrorAction SilentlyContinue
				}
				else { Update-Log "File not yet created, please wait." }
			}
			else
			{
				if ($(Test-Path "$targetShare\windows\temp\usmtfiles\$file") -eq $true)
				{
					Start-Process -FilePath "cmtrace.exe" -ArgumentList $targetshare\windows\temp\usmtfiles\$file -PassThru -ErrorAction SilentlyContinue
				}
				else { Update-Log "File not yet created, please wait." }
			}
		}
		else { Update-Log "You need CMTrace present in your path for this feature to work" }
	}
	#open remote C: drive to check status of migration
	function open-cdrive
	{
		if ($(Test-Path "C:\Program Files\7-Zip\7zFM.exe") -eq $true)
		{
			$targetshare = '\\' + $source + '\c$\'
			Start-Process -FilePath "C:\Program Files\7-Zip\7zFM.exe" -ArgumentList $targetShare -PassThru -ErrorAction SilentlyContinue
		}
		else { Update-Log 'This requires 7zip installed' }
	}
	##
	#endregion RemoteActions
	##
	# ** ------------------------------- ** #
	##
	#region FormManipulation
	##
	#combobox helper function to update it
	function Update-ComboBox
	{
		param
		(
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			[System.Windows.Forms.ComboBox]$ComboBox,
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			$Items,
			[Parameter(Mandatory = $false)]
			[string]$DisplayMember,
			[Parameter(Mandatory = $false)]
			[string]$ValueMember,
			[switch]$Append
		)
		if (-not $Append)
		{
			$ComboBox.Items.Clear()
		}
		if ($Items -is [Object[]])
		{
			$ComboBox.Items.AddRange($Items)
		}
		elseif ($Items -is [System.Collections.IEnumerable])
		{
			$ComboBox.BeginUpdate()
			foreach ($obj in $Items)
			{
				$ComboBox.Items.Add($obj)
			}
			$ComboBox.EndUpdate()
		}
		else
		{
			$ComboBox.Items.Add($Items)
		}
		$ComboBox.DisplayMember = $DisplayMember
		$ComboBox.ValueMember = $ValueMember
	}
	#helper function to update log with current activities
	
	function Update-Log
	{
		[CmdletBinding()]
		param ($message, $color)
		if ($message -like $(Get-Date -UFormat %Y))
			{
				$nmsg = $message.length
				$message = $message.substring(40, $($nmsg - 40))
		}
		
		$logtextbox.AppendText("`r`n")
		if ($color -ne $null)
		{
			$logtextbox.Select()
			$logtextbox.SelectionColor = "$color"
		 }
		
		$logtextbox.AppendText("-- [ $message")
		$logtextbox.Refresh()
	
		$logtextbox.ScrollToCaret()
		$logtextbox.selectioncolor='Black'
	}
	#helper function to keep GUI updated with current command that will be run remotely
	function reset-usmtstring
	{
		#determine operation to be performed (backup)
		$Global:source = $($txt_SourceComputer.Text)
		$global:key = $($txt_keyitem.text)
		$global:proselectdir = $($txt_proselect.text)
		$global:userchoiceitem = $($combo_userchoice.SelectedItem)
		$global:oldpc = $($combo_selectOldPC.SelectedItem)
		if ($checkboxVerboseLogging.Checked -eq $true)
		{
			$labelMultipleJobsDisabled.Visible = $true
		}
		else { $labelMultipleJobsDisabled.Visible = $false }
		
		if ($radioBackup.Checked -eq $true)
		{
			#check status of restore radio
			$RadioRestore.Checked = $false
			$xmls = $lb_migrationXMLS.Items
			$xmlstring=$null
			foreach ($xml in $xmls)
			{
				$xmlstring += ' /i:' + $xml.tostring() + ' '
			}
			$userTarget = $($combo_userchoice.SelectedItem)
			#update usmt string displayed (this is also what is copied to the script that is ran on remote PC)
			$txt_usmtString.text = " /ui:$userchoiceitem /progress:C:\Windows\Temp\usmtfiles\backup.log /encrypt:AES_192 /l:C:\windows\temp\usmtfiles\scanstate.log /ue:* /o /localonly /c /key:$global:key $xmlstring"
			#update the form to show either a restore or backup relevent panel
			$PanelSelectUser.visible = $true
			#hide irrelevent panel
			$Panel_SelectOldPC.Visible = $false
		}
		#determine operation to be performed (restore)
		elseif ($RadioRestore.Checked -eq $true)
		{
			#check status of backup radio
			$RadioBackup.Checked = $false
			$xmls = $lb_migrationXMLS.Items
			$xmlstring = $null
			foreach ($xml in $xmls)
			{
				$xmlstring += ' /i:' + $xml.tostring() + ' '
			}
			#update usmt string displayed (this is also what is copied to the script for remote computer task)
			$txt_usmtString.text = " /decrypt:AES_192 /c /v:9 /key:$global:key /l:C:\windows\temp\usmtfiles\restore.log $xmlstring"
			#update the form to show either a restore or backup relevent panel
			$Panel_SelectOldPC.Visible = $true
			#hide irrelevent panel
			$PanelSelectUser.Visible = $false
		}
		#update the form to reflect changes
		$MainForm.Refresh()
		#update log
		$logtextbox.refresh()
		#shoot global variable
		$global:TheArgs = $($txt_usmtString.text)
		#if all required values are filled - operation can start | otherwise 100% failure
		$button_begin.Enabled = $true
		#enable the button to start
	}
	function Update-Log-Alt
	{
		[CmdletBinding()]
		param ($message)
		$logtextbox.AppendText("$message")
		$logtextbox.AppendText("`r`n")
		$logtextbox.ScrollToCaret()
	}
	
	$labelX_Click = {
		
		Update-Log 'attempting to end your current job...'
		$endcommand = & C:\Windows\System32\schtasks.exe /end  /s $($txt_SourceComputer.text) /TN $operation
		Update-Log -message $endcommand
		
	}
	
	$HelpButton_Click = {
		Add-Type -AssemblyName PresentationCore, PresentationFramework
		
		$msgBody = @"
Multiple Users needed?  You can manually add these to the"USMT Command Args +" field below.  Formatting would be as /ui:<username> for each new user.

"@
	
		$msgTitle = 'Multiple Users'
		$msgButton = 'OK'
		$msgImage = 'Question'
		$Result = [System.Windows.MessageBox]::Show($msgBody, $msgTitle, $msgButton, $msgImage)
		
	}
	
	$DGV_jobstatus_CellContentClick = [System.Windows.Forms.DataGridViewCellEventHandler]{
		#Event Argument: $_ = [System.Windows.Forms.DataGridViewCellEventArgs]
		$rowIndex = $DGV_jobstatus.CurrentRow.Index
		$columnIndex = $DGV_jobstatus.CurrentCell.ColumnIndex
		if ($columnIndex -eq 6)
		{
			$stopjobTar = $DGV_jobstatus.rows[$rowindex].cells['jobname'].Value.ToString().replace("_$operation", "")
			Update-Log "Canceling job on $stopjobTar"
			$m = & C:\Windows\System32\schtasks.exe /end /s $stopjobTar /TN $operation /hresult
			Update-Log -message $m
			$button_begin.Enabled = $true
			
		}
		if ($columnIndex -eq 1)
		{
			$jobn = $DGV_jobstatus.rows[$rowindex].cells['jobname'].Value.ToString().replace("_$operation", "")
			Update-Log -message "Checking Status of Migration running on $jobn.text"
			$checkstatus = schtasks /query /s $jobn  /tn $operation /hresult /fo csv /v | convertfrom-csv
			Update-Log -message '-------[[   STATUS  $jobn ]] -------'
			$logtextbox.AppendText($checkstatus)
		}
	}
	
	$button_getusers_Click = {
		
		$combo_userchoice.Items.Clear()
		if ($txt_SourceComputer.TEXT -ne $null)
		{
			check-computer
		}
		
	}
	
	$txt_SourceComputer_Validating = [System.ComponentModel.CancelEventHandler]{
		#Event Argument: $_ = [System.ComponentModel.CancelEventArgs]
		
	}
	
	$txt_usmtfile_Validated = {
		$testUSMTFILE = Test-Path "$($txt_usmtfile.text)\scanstate.exe"
		if ($testUSMTFILE -eq $False)
		{
			$txt_usmtfile.text = "ERROR - USMT files not found in this directory"
			Update-Log "USMT Source files not found in this location"
			$txt_usmtfile.BackColor = 'Pink'
		}
		elseif ($testUSMTFILE -eq $true)
		{
			$txt_usmtfile.BackColor = 'LightGreen'
			Update-Log "USMT Source Files Confirmed"
	
		}
		
		$MainForm.Refresh()
	}
	
	Function Show-InputBox
	{
		Param ([string]$message = $(Throw "You must enter a prompt message"),
			[string]$title = "Input",
			[string]$default
		)
		[reflection.assembly]::loadwithpartialname("microsoft.visualbasic") | Out-Null
		[microsoft.visualbasic.interaction]::InputBox($message, $title, $default)
	}
	#helper class to use the modern folder browser when selecting source paths
	function get-folderdialogs
	{
		$AssemblyFullName = 'System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089'
		$Assembly = [System.Reflection.Assembly]::Load($AssemblyFullName)
		$OpenFileDialog = New-Object System.Windows.Forms.OpenFileDialog
		$OpenFileDialog.AddExtension = $false
		$OpenFileDialog.CheckFileExists = $false
		$OpenFileDialog.DereferenceLinks = $false
		$OpenFileDialog.InitialDirectory = 'C:\'
		$OpenFileDialog.Filter = "Folders|`n"
		$OpenFileDialog.Multiselect = $false
		$OpenFileDialog.Title = "Select folder"
		$OpenFileDialogType = $OpenFileDialog.GetType()
		$FileDialogInterfaceType = $Assembly.GetType('System.Windows.Forms.FileDialogNative+IFileDialog')
		$IFileDialog = $OpenFileDialogType.GetMethod('CreateVistaDialog', @('NonPublic', 'Public', 'Static', 'Instance')).Invoke($OpenFileDialog, $null)
		$null = $OpenFileDialogType.GetMethod('OnBeforeVistaDialog', @('NonPublic', 'Public', 'Static', 'Instance')).Invoke($OpenFileDialog, $IFileDialog)
		[uint32]$PickFoldersOption = $Assembly.GetType('System.Windows.Forms.FileDialogNative+FOS').GetField('FOS_PICKFOLDERS').GetValue($null)
		$FolderOptions = $OpenFileDialogType.GetMethod('get_Options', @('NonPublic', 'Public', 'Static', 'Instance')).Invoke($OpenFileDialog, $null) -bor $PickFoldersOption
		$null = $FileDialogInterfaceType.GetMethod('SetOptions', @('NonPublic', 'Public', 'Static', 'Instance')).Invoke($IFileDialog, $FolderOptions)
		$VistaDialogEvent = [System.Activator]::CreateInstance($AssemblyFullName, 'System.Windows.Forms.FileDialog+VistaDialogEvents', $false, 0, $null, $OpenFileDialog, $null, $null).Unwrap()
		[uint32]$AdviceCookie = 0
		$AdvisoryParameters = @($VistaDialogEvent, $AdviceCookie)
		$AdviseResult = $FileDialogInterfaceType.GetMethod('Advise', @('NonPublic', 'Public', 'Static', 'Instance')).Invoke($IFileDialog, $AdvisoryParameters)
		$AdviceCookie = $AdvisoryParameters[1]
		$Result = $FileDialogInterfaceType.GetMethod('Show', @('NonPublic', 'Public', 'Static', 'Instance')).Invoke($IFileDialog, [System.IntPtr]::Zero)
		$null = $FileDialogInterfaceType.GetMethod('Unadvise', @('NonPublic', 'Public', 'Static', 'Instance')).Invoke($IFileDialog, $AdviceCookie)
		if ($Result -eq [System.Windows.Forms.DialogResult]::OK)
		{
			$FileDialogInterfaceType.GetMethod('GetResult', @('NonPublic', 'Public', 'Static', 'Instance')).Invoke($IFileDialog, $null)
		}
		Write-Output $OpenFileDialog.FileName
	}
	##
	#endregion FormManipulation
	##
	# ** ------------------------------- ** #
	##
	#region HelperFunctions
	##
	function Show-MessageBox
	{
		[CmdletBinding()]
		param (
			[parameter(Mandatory = $true, Position = 0)]
			[string]$Message,
			[parameter(Mandatory = $false)]
			[string]$Title = 'MessageBox in PowerShell',
			[ValidateSet("OKOnly", "OKCancel", "AbortRetryIgnore", "YesNoCancel", "YesNo", "RetryCancel")]
			[string]$Buttons = "OKCancel",
			[ValidateSet("Critical", "Question", "Exclamation", "Information")]
			[string]$Icon = "Information"
		)
		Add-Type -AssemblyName Microsoft.VisualBasic
		
		[Microsoft.VisualBasic.Interaction]::MsgBox($Message, "$Buttons,SystemModal,$Icon", $Title)
	}
	
	#function used to save text fields for faster execution
	#several variables are saved to an XML located in the localappdata of user executing script
	function Update-Config
	{
		#Creates a new Config hash table with the current preferences set by the user
		$Config = @{
			'usmtsource' = $($txt_usmtfile.text)
			'usmtdest'   = $($txt_proselect.text)
			'key'	     = $($txt_keyiTEM.text)
		}
		#Export the updated config
		$Config | Export-Clixml -Path "$env:LOCALAPPDATA\Remote_USMT\config.xml"
	}
	Function ConvertTo-Base64
	{
	    <#
	        .SYNOPSIS
	        Encode strings to Base64 format
	 
	        .DESCRIPTION
	        Helper function to manage base64 encoded strings
	    #>
		param (
			[Parameter(ValueFromRemainingArguments)]
			[String]$Input,
			[Parameter(ValueFromPipeline)]
			[String]$PipelineInput
		)
		begin
		{
			if ($Input) { return $Input | ConvertTo-Base64 }
		}
		process
		{
			$b = [System.Text.Encoding]::UTF8.GetBytes($PipelineInput)
			return [System.Convert]::ToBase64String($b)
		}
	}
	
	#function to output the date and time after log outputs
	function Get-datesortable
	{
		$global:datesortable = Get-Date -Format "yyyyMMdd-HH':'mm':'ss"
		return $global:datesortable
	}
	#helper function to update a datagrid view
	function Update-DataGridView
	{
				        <#
		       .SYNOPSIS
		       This functions helps you load items into a DataGridView.
		       .DESCRIPTION
		       Use this function to dynamically load items into the DataGridView control.
		       .PARAMETER DataGridView
		       The DataGridView control you want to add items to.
		       .PARAMETER Item
		       The object or objects you wish to load into the DataGridView's items collection.
		       .PARAMETER DataMember
		       Sets the name of the list or table in the data source for which the DataGridView is displaying data.
		       .PARAMETER AutoSizeColumns
		         Resizes DataGridView control's columns after loading the items.
		       #>
		Param (
			[ValidateNotNull()]
			[Parameter(Mandatory = $true)]
			[System.Windows.Forms.DataGridView]$DataGridView,
			[ValidateNotNull()]
			[Parameter(Mandatory = $true)]
			$Item,
			[Parameter(Mandatory = $false)]
			[string]$DataMember,
			[System.Windows.Forms.DataGridViewAutoSizeColumnsMode]$AutoSizeColumns = 'None'
		)
		$DataGridView.SuspendLayout()
		$DataGridView.DataMember = $DataMember
		if ($null -eq $Item)
		{
			$DataGridView.DataSource = $null
		}
		elseif ($Item -is [System.Data.DataSet] -and $Item.Tables.Count -gt 0)
		{
			$DataGridView.DataSource = $Item.Tables[0]
		}
		elseif ($Item -is [System.ComponentModel.IListSource]`
			-or $Item -is [System.ComponentModel.IBindingList] -or $Item -is [System.ComponentModel.IBindingListView])
		{
			$DataGridView.DataSource = $Item
		}
		else
		{
			$array = New-Object System.Collections.ArrayList
			if ($Item -is [System.Collections.IList])
			{
				$array.AddRange($Item)
			}
			else
			{
				$array.Add($Item)
			}
			$DataGridView.DataSource = $array
		}
		if ($AutoSizeColumns -ne 'None')
		{
			$DataGridView.AutoResizeColumns($AutoSizeColumns)
		}
		$DataGridView.ResumeLayout()
	}
	#helper function to convert a csv to a datatable
	function ConvertTo-DataTable
	{
				        <#
		       .SYNOPSIS
		                       Converts objects into a DataTable.
		       .DESCRIPTION
		                       Converts objects into a DataTable, which are used for DataBinding.
		       .PARAMETER InputObject
		                       The input to convert into a DataTable.
		       .PARAMETER Table
		                       The DataTable you wish to load the input into.
		       .PARAMETER RetainColumns
		                       This switch tells the function to keep the DataTable's existing columns.
		       .PARAMETER FilterCIMProperties
		                       This switch removes CIM properties that start with an underline.
		       .EXAMPLE
		                       $DataTable = ConvertTo-DataTable -InputObject (Get-Process)
		       #>
		[OutputType([System.Data.DataTable])]
		param (
			$InputObject,
			[ValidateNotNull()]
			[System.Data.DataTable]$Table,
			[switch]$RetainColumns,
			[switch]$FilterCIMProperties)
		if ($null -eq $Table)
		{
			$Table = New-Object System.Data.DataTable
		}
		if ($null -eq $InputObject)
		{
			$Table.Clear()
			return @( , $Table)
		}
		if ($InputObject -is [System.Data.DataTable])
		{
			$Table = $InputObject
		}
		elseif ($InputObject -is [System.Data.DataSet] -and $InputObject.Tables.Count -gt 0)
		{
			$Table = $InputObject.Tables[0]
		}
		else
		{
			if (-not $RetainColumns -or $Table.Columns.Count -eq 0)
			{
				#Clear out the Table Contents
				$Table.Clear()
				if ($null -eq $InputObject) { return } #Empty Data
				$object = $null
				#find the first non null value
				foreach ($item in $InputObject)
				{
					if ($null -ne $item)
					{
						$object = $item
						break
					}
				}
				if ($null -eq $object) { return } #All null then empty
				#Get all the properties in order to create the columns
				foreach ($prop in $object.PSObject.Get_Properties())
				{
					if (-not $FilterCIMProperties -or -not $prop.Name.StartsWith('__'))
					{
						#filter out CIM properties
						#Get the type from the Definition string
						$type = $null
						if ($null -ne $prop.Value)
						{
							try { $type = $prop.Value.GetType() }
							catch { Out-Null }
						}
						if ($null -ne $type)
						{
							# -and [System.Type]::GetTypeCode($type) -ne 'Object')
							[void]$table.Columns.Add($prop.Name, $type)
						}
						else
						{
							#Type info not found
							[void]$table.Columns.Add($prop.Name)
						}
					}
				}
				if ($object -is [System.Data.DataRow])
				{
					foreach ($item in $InputObject)
					{
						$Table.Rows.Add($item)
					}
					return @( , $Table)
				}
			}
			else
			{
				$Table.Rows.Clear()
			}
			foreach ($item in $InputObject)
			{
				$row = $table.NewRow()
				if ($item)
				{
					foreach ($prop in $item.PSObject.Get_Properties())
					{
						if ($table.Columns.Contains($prop.Name))
						{
							$row.Item($prop.Name) = $prop.Value
						}
					}
				}
				[void]$table.Rows.Add($row)
			}
		}
		return @( , $Table)
	}
	function add-logjob
	{
		param ($num,
			$jobName,
			$jobstate,
			$jobstart,
			$jobend,
			$Result
		)
		[void]$DGV_jobstatus.Rows.Add($job.num, $job.name, $job.state, $job.psbegintime.toshorttimestring(), $job.psendtime, $job.result)
		
	}
	#used to track jobs
	function Add-JobTracker
	{
				        <#
		       .SYNOPSIS
		       Add a new job to the JobTracker and starts the timer.
		       .DESCRIPTION
		       Add a new job to the JobTracker and starts the timer.
		       .PARAMETERName
		       The name to assign to the job.
		       .PARAMETERJobScript
		       The script block that the job will be performing.
		       Important: Do not access form controls from this script block.
		       .PARAMETER ArgumentList
		       The arguments to pass to the job.
		       .PARAMETERCompletedScript
		       The script block that will be called when the job is complete.
		       The job is passed as an argument. The Job argument is null when the job fails.
		       .PARAMETERUpdateScript
		       The script block that will be called each time the timer ticks.
		       The job is passed as an argument. Use this to get the Job's progress.
		       .EXAMPLE
		       Tracker -Name 'JobName' `
		       -JobScript {        
		       Param($Argument1)#Pass any arguments using the ArgumentList parameter
		       #Important: Do not access form controls from this script block.
		       Get-CIMInstance Win32_Process -Namespace "root\CIMV2"
		       }`
		       -CompletedScript {
		       Param($Job)                    
		       $results = Receive-Job -Job $Job
		       }`
		       -UpdateScript {
		       Param($Job)
		       #$results = Receive-Job -Job $Job -Keep
		       }
		       .LINK
		       #>
		Param (
			[ValidateNotNull()]
			[Parameter(Mandatory = $true)]
			[string]$Name,
			[ValidateNotNull()]
			[Parameter(Mandatory = $true)]
			[ScriptBlock]$JobScript,
			$ArgumentList = $null,
			[ScriptBlock]$CompletedScript,
			[ScriptBlock]$UpdateScript,
			[string]$TargetPath)
		#Start the Job
		$job = Start-Job -Name $Name -ScriptBlock $JobScript -ArgumentList $ArgumentList
		$result = 'pending'
			<#$logjobMembers = @{
				'JobName'  = $job.Name;
				'jobState' = $job.State;
				'jobStart' = $job.PSBeginTime;
				'jobend'   = $job.PSEndTime;
				'result' = $result
			}#>
		
		Set-Content -Path $targetpath -Encoding Ascii -Value '' -Force
		$jobnumber = $DGV_jobstatus.Rows.Count
		#only start this job if they want verbose logging
		if ($checkboxVerboseLogging.Checked -eq $TRUE)
		{
			$job2 = Start-Job -Name $name_ -ScriptBlock {
				Start-Sleep 5
				Get-Content -Path $using:targetpath -Encoding Ascii -Wait
			} -ArgumentList $targetpath
		}
		if ($null -ne $job)
		{
			#Create a Custom Object to keep track of the Job & Script Blocks
			$members = @{
				'Job'		     = $Job;
				'Job2'		     = $job2;
				'CompleteScript' = $CompletedScript;
				'UpdateScript'   = $UpdateScript;
				'TargetPath'	 = $targetPath;
				'num'		     = [int]$DGV_jobstatus.Rows.Count
				'Result'		 = 'pending';
				'Source'		 = $($txt_SourceComputer.Text);
				}
			$psObject = New-Object System.Management.Automation.PSObject -Property $members
			#$pslogobj = New-Object System.Management.Automation.psobject -Property $logjobMembers
			[void]$JobTrackerList.Add($psObject)
			#                $DGV_jobstatus.Rows.add($($JobTrackerList.job | select name), $($JobTrackerList.job | select state), $($jobtrackerlist.job | select psbegintime), $($JobTrackerList.job | select psendtime))
			[void]$JobTrackerLog.add($psobject)
			#$rows =
			$namelink = '\\' + $psObject.job.name + '\C$\windows\temp\usmtfiles\' + $operation.log
			$DGV_jobstatus.Rows.add($psObject.num, $psObject.job.name, $psobject.job.state, $psObject.Job.psbegintime.toshorttimestring(), $psObject.Job.psendtime.toshorttimestring, $psObject.Result)
			#Start the Timer
			if (-not $timerJobTracker.Enabled)
			{
				$timerJobTracker.Start()
			}
		}
		elseif ($null -ne $CompletedScript)
		{
			#Failed
			Invoke-Command -ScriptBlock $CompletedScript -ArgumentList $null
		}
	}
	#this is called based on a timer to perform async operations.
	function Update-JobTracker
	{
				        <#
		       .SYNOPSIS
		       Checks the status of each job on the list.
		       #>
		#Poll the jobs for status updates
		
		$timerJobTracker.Stop() #Freeze the Timer
		for ($index = 0; $index -lt $JobTrackerList.Count; $index++)
		{
			$psObject = $JobTrackerList[$index]
			
			if ($null -ne $psObject)
			{
				if ($null -ne $psObject.Job)
				{
					if ($psObject.Job.State -eq 'Blocked')
					{
						#Try to unblock the job
						Receive-Job $psObject.Job -Keep | Out-Null
					}
					elseif ($psObject.Job.State -ne 'Running')
					{
						#Call the Complete Script Block
						if ($null -ne $psObject.CompleteScript)
						{
							#Produce Realtime logs on UI only if verbose logging is enabled
							if ($checkboxVerboseLogging.Checked -eq $true)
							{
							#	$current = Receive-Job $psObject.job2 | Out-String	
							}
							Invoke-Command -ScriptBlock $psObject.completescript -ArgumentList $psObject, $psObject.targetpath
							#Call the Update Script Block
							#	$updateText = $JobTrackerLog | Where-Object name -EQ $psObject.job.name
							$updateText = $JobTrackerList.job
							
						}
	
						$JobTrackerList.RemoveAt($index)
	
						if ($checkboxVerboseLogging.Checked -eq $TRUE)
						{
							Stop-Job $psObject.job2
							$lastlog = Receive-Job -Job $psObject.Job2 |out-string
							Update-Log -message $lastlog
							
						}
						Remove-Job -Job $psObject.Job
						$index-- #Step back so we don't skip a job
					}
					elseif ($null -ne $psObject.UpdateScript)
					{
						Invoke-Command -ScriptBlock $psObject.UpdateScript -ArgumentList $psObject, $psObject.TargetPath
					}
				}
			}
			else
			{
				$JobTrackerList.RemoveAt($index)
				$index-- #Step back so we don't skip a job
			}
		}
		if ($JobTrackerList.Count -gt 0)
		{
			$timerJobTracker.Start() #Resume the timer
		}
		
		function update-jobstatus
		{
			$ErrorActionPreference = 'SilentlyContinue'
			$jobName = $source + '_' + $operation
			$global:source = $($txt_SourceComputer.Text)
			$global:targetpath = '\\' + $source + '\c$\windows\temp\usmtfiles\' + $operation + '.log'
			
			#this job will track the status of your operation
			Add-JobTracker -Name ($jobname) `
						   -JobScript {
				Param ($source,
					$operation,
					$targetpath)
				
				$newop = $using:operation
				$newsource = $using:source
				do
				{
					$ErrorActionPreference = 'SilentlyContinue'
					$done = C:\Windows\System32\schtasks.exe /s $newsource /query /tn $newop /fo csv | ConvertFrom-Csv
				}
				while ($done.status -ne 'Ready')
				
			}`
						   -CompletedScript {
				#This is called when the job has completed
				Param ($psobject,
					$targetPath)
			C:\Windows\System32\schtasks.exe /end  /s $source /tn $operation
				$tsetup = Get-Item $targetpath
				if ($tsetup.basename -eq 'Backup')
				{
					$testSuccess = Join-Path -Path $tsetup.PSParentPath -ChildPath 'store\usmt\usmt.mig'
					$testGood = Test-Path $testSuccess
					if ($testGood -ne $true)
					{
						$psobject.Result = 'Failed'
						Update-Log -message "$source migration job Failed!"
					}
					else
					{
						$psobject.Result = 'Success'
						Update-Log -message "$source migration job successful!"
					}
					
					$DGV_jobstatus.Rows |
					foreach-object{
						$h = $_.Cells['Num'].Value
						if ($h -eq $psobject.num)
						{
							%{ $_.cells['jobEnd'].value = $psobject.job.PSEndTime.toshorttimestring() }
							%{ $_.cells['state'].value = $psobject.job.state }
							%{ $_.cells['result'].value = $psObject.result }
						}
						if ($_.cells['result'].value -eq 'Failed')
						{
						$_.cells | %{ $_.style.backcolor = 'Pink' }
						if ($MainForm.WindowState -ne 'Normal')
						{
							New-Toast -JobName $psobject.job.name -jobstatus 'Failed' -jobresult $psobject.result
						}
					}
					elseif ($_.cells['result'].value -eq 'Success')
					{
						$_.cells | %{ $_.style.backcolor = 'LightGreen' }
						New-Toast -JobName $psobject.job.name -jobstatus 'Successfully Completed!' -jobresult 'Please Check It!'
						
					}
					
				}
			}
			
			if ($tsetup.BaseName -eq 'Restore')
				{
					$testGood = Get-Content $targetpath | Out-String
					
					if ($testGood.Length -lt 300)
					{
						$psobject.Result = 'Failed'
						Update-Log -message "$source migration job Failed!"
					}
					else
					{
						$psobject.Result = 'Success'
						Update-Log -message "$source migration job successful!"
					}
					
					$DGV_jobstatus.Rows |
				foreach-object{
					$h = $_.Cells['Num'].Value
						if ($_.cells['num'].value -eq $psobject.num)
						{
							%{ $_.cells['jobEnd'].value = $psobject.job.PSEndTime.toshorttimestring() }
							%{ $_.cells['state'].value = $psobject.job.state }
							%{ $_.cells['result'].value = $psObject.result }
						}
						if ($_.cells['result'].value -eq 'Failed')
						{
							$_.cells | %{ $_.style.backcolor = 'Pink' }
						}
						elseif ($_.cells['result'].value -eq 'Success')
						{
						$_.cells | %{ $_.style.backcolor = 'LightGreen' }
						New-Toast -JobName "Migration Job $_.cells['name']" -jobstatus 'Successfully Completed!' -jobresult 'Please Check It!'
						
					}
					
				}
			}
			
		}`
						   -UpdateScript {
				#this is called every second the job is running
			Param ($psobject)
			#Produce Realtime logs on UI only if verbose logging is enabled
			if ($checkboxVerboseLogging.Checked -eq $true)
			{
				#output status of job created for verbose logging
				$current = Receive-Job $psObject.job2 | Out-String
				 $logtextbox.appendtext($current) 
				}
				#$logtextbox.appendtext($current)
		}`
						   -TargetPath \\$source\c$\windows\temp\usmtfiles\$operation.log
			#    foreach($line in $(Receive-Job $Job)){Update-Log-Alt -message $line}
		}
		
		#this is called when job is complete
	function Stop-JobTracker
	{
				        <#
		       .SYNOPSIS
		       Stops and removes all Jobs from the list.
		       #>
		#Stop the timer
		$timerJobTracker.Stop()
		#Remove all the jobs
		while ($JobTrackerList.Count -gt 0)
		{
			$job = $JobTrackerList[0].Job
			$JobTrackerList.RemoveAt(0)
		}
	}
	#endregion HelperFunctions
	##
	# ** ------------------------------- ** #
	##
	#region Logging
	##
	#function to backup your operations performed on various PCs - will also be able to get loaded for restore
	#future enhancement to display status of these migration files and the ability to clean them up.
	function initialize-logs
	{
		if (!(Test-Path -Path "$env:LOCALAPPDATA\Remote_USMT"))
		{
			New-Item -ItemType Directory -Path "$env:LOCALAPPDATA\Remote_USMT"
		}
		$mycsv = "$env:LOCALAPPDATA\Remote_USMT\usmtlogs.csv"
		if ($(Test-Path $mycsv) -eq $false)
		{
			try
			{
				$dest = "$($txt_proselect.text)\$source"
				$encryptionkey = $($txt_keyItem.Text)
				$useritem = $($combo_userchoice.SelectedItem)
				$op = $global:operation
				$target = $($txt_SourceComputer.text)
				$migconfig = $($combo_Configs.SelectedItem)
				$tagRep = $source -replace "^[0-9]"
				$cmdbLink = 'https://mn-itservices.us.onbmc.com/arsys/forms/onbmc-s/SHR%3ALandingConsole/Default%20Administrator%20View/?wait=0&mode=search&F304255500=AST%3AComputerSystem&F1000000076=FormOpen&F303647600=SearchTicketWithQual&F304255610=%27400127400%27=%22BMC.ASSET%22AND%27260100004%27%3D%22' + $tagRep + '%22'
				$dateitem = Get-Date -Format MM-dd-yy`|hh:mm:ss
				$logfile = New-Object System.Collections.ArrayList
				$logfile = { } | Select-Object "date", "operation", "target", "destination", "encryptionkey", "username", "MigConfig", "CMDBLink"
				$logfile.Date = $dateitem
				$logfile.Operation = $op
				$logfile.Target = $target
				$logfile.Destination = $dest
				$logfile.EncryptionKey = $encryptionkey
				$logfile.Username = $useritem
				$logfile.MigConfig = $migconfig
				$logfile.CMDBLink = $cmdblink
				#Move-Item -Path $mycsv -Destination "$mycsv.bak" -ErrorAction Stop
				$logfile | Export-Csv $mycsv -Force -NoTypeInformation
			}
			catch
			{
				Update-Log "Your log file isnt working - generating a new one"
				Move-Item -Path $mycsv -Destination "$mycsv.bak"
				initialize-logs
			}
		}
		else { initialize-logs }
		write-log
	}
	
	#This function is used to create your log file of past migrations.
	function write-log
	{
		param ($operation)
		if ($(Test-Path -Path "$env:LOCALAPPDATA\Remote_USMT\usmtlogs.csv") -eq $true)
		{
			try
			{
				$logfile = New-Object System.Collections.ArrayList
				$mycsv = "$env:LOCALAPPDATA\Remote_USMT\usmtlogs.csv"
				$dest = "$($txt_proselect.text)\$source"
				$encryptionkey = $($txt_keyItem.Text)
				$useritem = $($combo_userchoice.SelectedItem)
				$tagRep = $source -replace "^[0-9]"
				$target = $($txt_SourceComputer.text)
				$CmdbLink = "https://mn-itservices.us.onbmc.com/arsys/forms/onbmc-s/SHR%3ALandingConsole/Default%20Administrator%20View/?mode=search&wait=0&F303647600=SearchTicketWithQual&F1000000076=FormOpen&F304255500=AST%3AComputerSystem&F304255610=%27400127400%27%3D%22BMC.ASSET%22AND%27260100004%27%3D%22' + $tagRep + '%22'"
				$op = $global:operation
				$usmtlogs = Test-Path $mycsv
				$migconfig = $($combo_Configs.SelectedItem)
				$dateitem = Get-Date -Format MM-dd-yy`|hh:mm:ss
				$logfile = { } | Select-Object "date", "operation", "target", "destination", "encryptionkey", "username", "MigConfig", "CMDBLink"
				$logfile.Date = $dateitem
				$logfile.Operation = $op
				$logfile.Target = $target
				$logfile.Destination = $dest
				$logfile.EncryptionKey = $encryptionkey
				$logfile.Username = $useritem
				$logfile.MigConfig = $migconfig
				$logfile.CmdbLink = $cmdblink
				$logfile | Export-Csv $mycsv -NoTypeInformation -Append
			}
			catch
			{
				initialize-logs
			}
		}
		#end if config file exists
		else
		{
			initialize-logs
		}
	}
	#create a config file if one doesnt already exist
	function Initailize-Config
	{
		if ($starting_usmtpath -ne $null)
		{
			$txt_usmtfile.Text = $starting_usmtpath
			$txt_proselect.Text = $starting_profileLocation
			
		}
		
		if (!(Test-Path -Path "$env:LOCALAPPDATA\Remote_USMT"))
		{
			New-Item -ItemType Directory -Path "$env:LOCALAPPDATA\Remote_USMT"
		}
		Update-Log 'Generating New Encryption Key'
		$sets = "abcdefghijklmnopqrstuvwxyz2345678"
		$length = 16
		$sb = New-Object System.Text.StringBuilder
		$sb.Append($sets) | Out-Null
		$permittedChars = $sb.ToString();
		$password = [char[]]@(0) * $Length;
		$bytes = [byte[]]@(0) * $Length;
		$rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
		$rng.GetBytes($bytes);
		$rng.Dispose();
		for ($i = 0; $i -lt $Length; $i++)
		{
			$index = [int] ($bytes[$i] % $permittedChars.Length);
			$password[$i] = [char]$permittedChars[$index];
		}
		$pass = -join $password
		#Setup default preferences
		#Creates hash table and .clixml config file
		$Config = @{
			'usmtsource' = $txt_usmtfile.text
			'usmtdest'   = $txt_proselect.Text
			'key'	     = "$pass"
		}
		$Config | Export-Clixml -Path "$env:LOCALAPPDATA\Remote_USMT\config.xml" -Force
		set-config
	}
	function set-config
	{
		#If a config file exists for the current user in the expected location, it is imported
		#and values from the config file are placed into global variables
		if (Test-Path -Path "$env:LOCALAPPDATA\Remote_USMT\config.xml")
		{
			try
			{
				#Imports the config file and saves it to variable $Config
				$Config = Import-Clixml -Path "$env:LOCALAPPDATA\Remote_USMT\config.xml"
				#Creates global variables for each config property and sets their values
				$global:usmtfiles = $Config.usmtsource
				$global:usmtdest = $Config.usmtdest
				$global:key = $Config.key
			}
			catch
			{
				[System.Windows.Forms.MessageBox]::Show("An error occurred importing your Config file. A new Config file will be generated for you. $_", 'Import Config Error', 'OK', 'Error')
				Initailize-Config
			}
		} #end if config file exists
		else
		{
			Initailize-Config
		}
		#update form with saved config
		$txt_keyiTEM.text = $key
		$txt_usmtfile.text = $usmtfiles
		$txt_proselect.text = $usmtdest
		$MainForm.Refresh()
	}
	
	##
	#endregion Logging
	##
	# ** ------------------------------- ** #
	##
	#region MigrationBeginsHere
	##
	function initialize-Operation
	{
		$initialize = $false
		$islocalmig = $false
		$usmtsourcefile = $($txt_usmtfile.Text)
		$global:source = $($txt_SourceComputer.Text)
		Update-Log $MigrationSettingsMessage
		Update-Log 'initializing progress logs'
		Update-Log "initializing action file"
		$targetPC = '\\' + $source + '\c$\windows\temp\usmtfiles'
	
		if ($(testport -hostname $source -port 445) -eq 'Online')
		{
			if ($(Test-Path $targetPC) -eq $true)
			{
				Update-Log "removing old usmt files before migration"
				Remove-Item $targetpc -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
				
			}
			update-log "Building job"
			if ($RadioRestore.Checked -eq $true)
			{
				#Setting variables for log operations
				$global:operation = 'restore'
				#adding log entry for this operation
				Write-Log -message "operation $operation"
				#calling restore operation
				Update-Log 'stopping any existing migration jobs'
				$ErrorActionPreference = 'SilentlyContinue'
				C:\Windows\System32\schtasks.exe  /s $source /end /tn restore | Out-Null
				restore
			}
			elseif ($RadioBackup.Checked -eq $true)
			{
				if ($labelIfThisPathIsCItWillB.text -eq 'Local') { $islocalmig = $true }
				#Setting variables for log operations
				$global:operation = 'backup'
				#adding log entry for this operation
				write-log  "operation $operation"
				#calling restore operation
				Update-Log 'stopping any existing migration jobs'
				C:\Windows\System32\schtasks.exe /s $source /end /tn backup | Out-Null
				Backup
			}
		}
		else{write-log "$targetPC is offline now, check this to be sure"}
		
	}
	
	#function that executes a backup operation
	function Backup
	{
		#Testing to see if target computer is online.
		if ($islocalmig = $true) { $checklocal = $null }
		#creating directories to move the migration objects to.  Also setting their required permissions.
		Update-Log 'Creating destination directory'
		try
		{
			$ErrorActionPreference = 'SilentlyContinue'
			
			$acl = Get-Acl $($txt_proselect.text)
			$newacl = New-Object System.Security.AccessControl.FileSystemAccessRule ("Domain Computers", "Modify", "ContainerInherit,ObjectInherit", "None", "Allow")
			$acl.AddAccessRule($newacl)
			Update-Log "Setting new ACL's on new directory"
			$acl | Set-Acl "$($txt_proselect.text)\$source"
		}
		catch [System.Management.Automation.ItemNotFoundException] {
			Update-Log "Parent directory does not exist?"
		}
		catch [System.UnauthorizedAccessException] {
			Update-Log "You lack permissions to create the destination directory"
			Update-Log "Pick a new location or a location on the target pc"
		}
		Update-Log -Message "Running Backup"
		#generating XML file for scheduled task that will be loaded onto target pc.
		if ($chkbox_NoShares.Checked -eq $false)
		{
			[xml]$downXML = @"
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
<RegistrationInfo>
	<Date>2022-03-04T01:26:37.4900672</Date>
	<Author>username</Author>
	<URI>\backup</URI>
</RegistrationInfo>
<Triggers>
	<RegistrationTrigger>
		<Enabled>false</Enabled>
	</RegistrationTrigger>
</Triggers>
<Principals>
	<Principal id="Author">
		<UserId>S-1-5-18</UserId>
		<RunLevel>HighestAvailable</RunLevel>
	</Principal>
</Principals>
<Settings>
	<MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
	<DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
	<StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
	<AllowHardTerminate>true</AllowHardTerminate>
	<StartWhenAvailable>false</StartWhenAvailable>
	<RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
	<IdleSettings>
		<StopOnIdleEnd>false</StopOnIdleEnd>
		<RestartOnIdle>false</RestartOnIdle>
	</IdleSettings>
	<AllowStartOnDemand>true</AllowStartOnDemand>
	<Enabled>true</Enabled>
	<Hidden>true</Hidden>
	<RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
	<WakeToRun>false</WakeToRun>
	<ExecutionTimeLimit>PT72H</ExecutionTimeLimit>
	<Priority>4</Priority>
</Settings>
<Actions Context="Author">		
<Exec>
		<Command>cmd</Command>
		<Arguments>/c mkdir $($txt_proselect.Text)\$source `&amp; timeout 5</Arguments>
	</Exec>
	<Exec>
		<Command>cmd</Command>
	<Arguments>/c robocopy $($txt_usmtfile.text) C:\windows\temp\usmtfiles /e /NP /NFL /MT:5 /XO /IT /LOG+:C:\windows\Temp\usmtfiles\backup.log `&amp; timeout 2 `&amp; echo. >> C:\Windows\temp\usmtfiles\backup.log `&amp; echo ***********Now Performing Backup*********** >> C:\Windows\Temp\usmtfiles\backup.log `&amp; timeout 3</Arguments>
	</Exec>
	<Exec>
		<Command>cmd</Command>
		<Arguments>/c C:\windows\temp\usmtfiles\scanstate.exe C:\windows\temp\usmtfiles\store $($txt_usmtString.text) $($txt_appendUSMT.Text) `&amp; timeout 2 `&amp; echo. >> C:\Windows\temp\usmtfiles\backup.log `&amp; echo ***********Now Uploading Captured File*********** >> C:\Windows\Temp\usmtfiles\backup.log `&amp; timeout 3 </Arguments>
	</Exec>
	<Exec>
		<Command>cmd</Command>
		<Arguments>/c robocopy C:\windows\temp\usmtfiles\store "$($txt_proselect.text)\$($txt_SourceComputer.text)" /e /XO /IT /NP /XJ /XJD /IM /R:2 /w:15 /LOG+:C:\windows\Temp\usmtfiles\backup.log `&amp; timeout 2 `&amp; echo. >> C:\Windows\temp\usmtfiles\backup.log `&amp; echo "Completed" >> C:\Windows\Temp\usmtfiles\backup.log</Arguments>
	</Exec>
	 </Actions>
	</Task>
"@
			
			#create script to run on remote PC
			$newdir = Start-Job {
				$h = mkdir -path \\$using:source\c$\windows\temp -Force -Name usmtfiles
				if ($? -eq $false) { throw 'couldnt make temp directory' }
			} -ArgumentList $source
			
			$res = Wait-Job $newdir -Timeout 5
			
			if ($newdir.State -eq 'Failed')
			{
				Update-Log "Could not create \\$source\c$\windows\temp\usmtfiles, you may not have access to this"
				
			}
		}
		else
		{
			$remoteUsmtFilesLoc = "\\$($txt_SourceComputer.Text)\c$\windows\temp\usmtfiles"
			$usmtprocArgs = ' /e /xo /it /np /xj /xjd /im /r:2 /mt:5 /w:15 /log+:' + $remoteUsmtFilesLoc+'\backup.log'
			$roboproc = [System.Diagnostics.Process]::new()
			$roboproc.StartInfo.FileName = 'C:\Windows\System32\robocopy.exe'
			$roboproc.StartInfo.Arguments = '"' + $($txt_localusmtfiles.Text) + '"' + $remoteUsmtFilesLoc + $usmtprocArgs
			$roboproc.StartInfo.UseShellExecute = $false
			$roboproc.StartInfo.RedirectStandardOutput = $true
			$roboproc.startinfo.RedirectStandardError = $true
			
			$roboproc.start()
			
			foreach ($line in $roboproc.BeginOutputReadLine()) { Update-Log -message $line }
			Wait-Process Robocopy
			$roboproc.WaitForExit()
			$roboproc.dispose()
			
			[xml]$downXML = @"
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
<RegistrationInfo>
	<Date>2022-03-04T01:26:37.4900672</Date>
	<Author>username</Author>
	<URI>\backup</URI>
</RegistrationInfo>
<Triggers>
	<RegistrationTrigger>
		<Enabled>false</Enabled>
	</RegistrationTrigger>
</Triggers>
<Principals>
	<Principal id="Author">
		<UserId>S-1-5-18</UserId>
		<RunLevel>HighestAvailable</RunLevel>
	</Principal>
</Principals>
<Settings>
	<MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
	<DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
	<StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
	<AllowHardTerminate>true</AllowHardTerminate>
	<StartWhenAvailable>false</StartWhenAvailable>
	<RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
	<IdleSettings>
		<StopOnIdleEnd>false</StopOnIdleEnd>
		<RestartOnIdle>false</RestartOnIdle>
	</IdleSettings>
	<AllowStartOnDemand>true</AllowStartOnDemand>
	<Enabled>true</Enabled>
	<Hidden>true</Hidden>
	<RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
	<WakeToRun>false</WakeToRun>
	<ExecutionTimeLimit>PT72H</ExecutionTimeLimit>
	<Priority>4</Priority>
</Settings>
<Actions Context="Author">		
	<Exec>
		<Command>cmd</Command>
		<Arguments>/c C:\windows\temp\usmtfiles\scanstate.exe $($proselect.text) $theargs $($txt_appendUSMT.Text) `&amp; timeout 2 `&amp; echo. >> C:\Windows\temp\usmtfiles\backup.log `&amp;</Arguments>
	</Exec>
	 </Actions>
	</Task>
"@
			
		}
		
		$tn = $operation.tostring()
		
		try
		{
			$ErrorActionPreference = 'SilentlyContinue'
			
			$acl = Get-Acl \\$source\c$\windows\temp\usmtfiles
			$newacl = New-Object System.Security.AccessControl.FileSystemAccessRule ("NT AUTHORITY\SYSTEM", "Modify", "ContainerInherit,ObjectInherit", "None", "Allow")
			$acl.AddAccessRule($newacl)
			Update-Log "Setting new ACL's on mig directory"
			$acl | Set-Acl \\$source\c$\windows\temp\usmtfiles
		}
		catch [System.Management.Automation.ItemNotFoundException] {
			Update-Log "Parent directory does not exist?"
			break
		}
		catch [System.UnauthorizedAccessException] {
			Update-Log "You lack permissions to create the destination directory"
			Update-Log "Pick a new location or a location on the target pc"
			break
		}
		
		#output XML file
		$downxml.outerxml | Out-File "$env:LOCALAPPDATA\Remote_USMT\down.xml" -Force
		#load job to remote PC
	
		C:\Windows\System32\schtasks.exe /s $source /create /xml "$env:LOCALAPPDATA\Remote_USMT\down.xml" /tn backup /f
		C:\Windows\System32\schtasks.exe /s $source /run /tn backup
		$started=0
		for ($i = 1; $i -lt 5; $i++)
		{
			Start-Sleep 4
			$ConfirmRunning = C:\Windows\System32\schtasks.exe /s $source /query /tn backup /fo csv | ConvertFrom-Csv
			if ($ConfirmRunning.status -eq 'Running')
			{
				$i = 5
				$started=1	
			}
			else
			{
				Update-Log 'attempting again to start backup operation'
				C:\Windows\System32\schtasks.exe /s $source /run /tn backup
			}
		}
		if ($started -eq 1)
		{
			#adding job to job grid
			$h = $checkboxVerboseLogging.CheckState
			
			if ($h -eq [System.Windows.Forms.CheckState]::Unchecked)
			{
	
			}
			update-jobstatus
	
			Update-Log '*********** Migration Will Complete soon, you will find your folder on file share specified ***********'
			Update-Log " ** This will occur automatically - The files will be located at $proselectdir\$global:source ***** "
			Update-Log '*** All you require is the name of the old PC to proceed with the restore ***'
			
		}
		else
		{
			Update-Log "Job failed to start"
			$button_begin.Enabled = $true
		}
		
	}
	#function to execute a restore operation
	function restore
	{
		$oldpc = $combo_selectOldPC.SelectedItem
		
		$oldPcItem = $oldpc
		If ($batchSourceitemback -eq $null)
		{
			$global:oldpc = $oldPcItem
		}
		$ErrorActionPreference = 'SilentlyContinue'
		$targetPC = '\\' + $source + '\c$\windows\temp\usmtfiles'
		
		#PSSCRIPT to Send
		Update-Log 'Setting up jobs - will be done soon'
		#generating XML for loading onto target PC.
		if ($chkbox_NoShares.Checked -eq $false)
		{
			[xml]$upXML = @"
<?xml version="1.0" encoding="UTF-16"?>
	<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
<RegistrationInfo>
	<Date>2022-03-04T01:26:37.4900672</Date>
	<Author>username</Author>
	<URI>\restore</URI>
</RegistrationInfo>
<Triggers>
	<RegistrationTrigger>
		<Enabled>false</Enabled>
	</RegistrationTrigger>
</Triggers>
<Principals>
	<Principal id="Author">
		<UserId>S-1-5-18</UserId>
		<RunLevel>HighestAvailable</RunLevel>
	</Principal>
</Principals>
<Settings>
	<MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
	<DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
	<StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
	<AllowHardTerminate>true</AllowHardTerminate>
	<StartWhenAvailable>false</StartWhenAvailable>
	<RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
	<IdleSettings>
		<StopOnIdleEnd>false</StopOnIdleEnd>
		<RestartOnIdle>false</RestartOnIdle>
	</IdleSettings>
	<AllowStartOnDemand>true</AllowStartOnDemand>
	<Enabled>true</Enabled>
	<Hidden>true</Hidden>
	<RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
	<WakeToRun>false</WakeToRun>
	<ExecutionTimeLimit>PT72H</ExecutionTimeLimit>
	<Priority>4</Priority>
</Settings>
<Actions Context="Author">		
<Exec>
		<Command>cmd</Command>
		<Arguments>/c net session /delete /y</Arguments>
	</Exec>
<Exec>
	<Command>cmd</Command>
	<Arguments>/c robocopy "$($txt_usmtfile.text)" C:\windows\temp\usmtfiles /e /NP /NFL /MT:5 /XO /IT /LOG+:C:\windows\Temp\usmtfiles\restore.log `&amp; timeout 2 `&amp; echo. >> C:\Windows\temp\usmtfiles\restore.log `&amp; echo ***********Downloading User Profile*********** >> C:\Windows\Temp\usmtfiles\Restore.log `&amp; timeout 3</Arguments>
	</Exec>
	<Exec>
	<Command>cmd</Command>
	<Arguments>/c robocopy "$($txt_proselect.text)\$oldPcItem" C:\windows\temp\usmtfiles\store /E /j /NP /XO /IT /XJ /XJD /IM /R:2 /w:15 /LOG+:C:\windows\Temp\usmtfiles\restore.log `&amp; timeout 2 `&amp; echo. >> C:\Windows\temp\usmtfiles\restore.log `&amp; echo "***********Performing User Profile Restore***********" >> C:\Windows\Temp\usmtfiles\restore.log `&amp; timeout 3</Arguments>
	</Exec>
	<Exec>
	<Command>cmd</Command>
	<Arguments>/c C:\windows\temp\usmtfiles\loadstate.exe C:\windows\temp\usmtfiles\store $TheArgs $($txt_appendUSMT.text) `&amp; timeout 2 `&amp; echo. >> C:\Windows\temp\usmtfiles\restore.log `&amp; echo "***********Completed  Restore***********" >> C:\Windows\Temp\usmtfiles\restore.log </Arguments>
	</Exec>
	</Actions>
	</Task>	
"@
		}
		else
		{
			
			$remoteUsmtFilesLoc = " \\$($txt_SourceComputer.Text)\c$\windows\temp\usmtfiles"
			$usmtprocArgs = " /e /xo /it /np /xj /xjd /im /r:2 /mt:5 /w:15 /log+$remoteUsmtFilesLoc\backup.log"
			$roboproc = [System.Diagnostics.Process]::new()
			$roboproc.StartInfo.FileName = 'C:\Windows\System32\robocopy.exe'
			$roboproc.StartInfo.Arguments = $txt_localusmtfiles + $remoteUsmtFilesLoc + $usmtprocArgs
			foreach ($line in $roboproc.start()) { Update-Log -message $line }
			$roboproc.WaitForExit()
			$roboproc.dispose()
			$usmtTransProc = [System.Diagnostics.Process]::new()
			$usmtTransProc.StartInfo.FileName = 'C:\Windows\System32\robocopy.exe'
			$usmtTransProc.StartInfo.Arguments = "$txt_localmigfile $remoteUsmtFilesLoc\store\usmt /e /xo /it /np /xj /xjd /im /r:2 /mt:5 /w:15 /log+$remoteUsmtFilesLoc\backup.log"
			$usmtTransProc.start()
			foreach ($line in $usmtTransProc) { Update-Log -message $line }
			$usmtTransProc.WaitForExit()
			$usmtTransProc.dispose()
			
			[xml]$upXML = @"
<?xml version="1.0" encoding="UTF-16"?>
	<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
<RegistrationInfo>
	<Date>2022-03-04T01:26:37.4900672</Date>
	<Author>username</Author>
	<URI>\restore</URI>
</RegistrationInfo>
<Triggers>
	<RegistrationTrigger>
		<Enabled>false</Enabled>
	</RegistrationTrigger>
</Triggers>
<Principals>
	<Principal id="Author">
		<UserId>S-1-5-18</UserId>
		<RunLevel>HighestAvailable</RunLevel>
	</Principal>
</Principals>
<Settings>
	<MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
	<DisallowStartIfOnBatteries>false</DisallowStartIfOnBatteries>
	<StopIfGoingOnBatteries>false</StopIfGoingOnBatteries>
	<AllowHardTerminate>true</AllowHardTerminate>
	<StartWhenAvailable>false</StartWhenAvailable>
	<RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
	<IdleSettings>
		<StopOnIdleEnd>false</StopOnIdleEnd>
		<RestartOnIdle>false</RestartOnIdle>
	</IdleSettings>
	<AllowStartOnDemand>true</AllowStartOnDemand>
	<Enabled>true</Enabled>
	<Hidden>true</Hidden>
	<RunOnlyIfIdle>false</RunOnlyIfIdle>
    <DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
    <UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
	<WakeToRun>false</WakeToRun>
	<ExecutionTimeLimit>PT72H</ExecutionTimeLimit>
	<Priority>4</Priority>
</Settings>
<Actions Context="Author">		
	<Exec>
	<Command>cmd</Command>
	<Arguments>/c C:\windows\temp\usmtfiles\loadstate.exe C:\windows\temp\usmtfiles\store $TheArgs $($txt_appendUSMT.text) `&amp; timeout 2 `&amp; echo. >> C:\Windows\temp\usmtfiles\restore.log `&amp; echo "***********Completed  Restore***********" >> C:\Windows\Temp\usmtfiles\restore.log </Arguments>
	</Exec>
	</Actions>
	</Task>	
"@
		}
		
		update-log "Job started"
		$tn = $operation.ToString()
		#output XML file
		$started = 0
		$i = 0
		$upXML.outerxml | Out-File "$env:LOCALAPPDATA\Remote_USMT\up.xml" -Force
		#loading job remotely onto target
		mkdir -path \\$source\c$\windows\temp -Force -Name usmtfiles
		try
		{
			$ErrorActionPreference = 'SilentlyContinue'
			
			$acl = Get-Acl \\$source\c$\windows\temp\usmtfiles
			$newacl = New-Object System.Security.AccessControl.FileSystemAccessRule ("NT AUTHORITY\SYSTEM", "Modify", "ContainerInherit,ObjectInherit", "None", "Allow")
			$acl.AddAccessRule($newacl)
			Update-Log "Setting new ACL's on mig directory"
			$acl | Set-Acl \\$source\c$\windows\temp\usmtfiles
		}
		catch [System.Management.Automation.ItemNotFoundException] {
			Update-Log "Parent directory does not exist?"
			break
		}
		catch [System.UnauthorizedAccessException] {
			Update-Log "You lack permissions to create the destination directory"
			Update-Log "Pick a new location or a location on the target pc"
			break
		}
		if ($chkbox_NoShares.Checked -eq $true)
		{
			update-log "You should have uploaded the USMT file to the remote host and set it's directory as the profile path"
			Update-Log "if you did not do this, the next actions will fail"
			Robocopy $txt_usmtfile.Text \\$source\c$\windows\temp\usmtfiles /E /NP /NFL /MT:5 /XO /IT /LOG+:\\$source\C$\windows\temp\usmtfiles\backup.log
			
			if ((Test-Path \\$source\C$\windows\temp\store\usmt\usmt.mig) -ne $true)
			{
				Update-Log 'You didnt copy the mig file to the correct directory.  This is \\$source\C$\windows\temp\store\usmt\usmt.mig'
				Update-Log 'killing job'
				break
			}
		}
		
		C:\Windows\System32\schtasks.exe /s $source /create /xml "$env:LOCALAPPDATA\Remote_USMT\up.xml" /tn $tn /f
		C:\Windows\System32\schtasks.exe /s $source /run /tn $tn
		
		for ($i = 1; $i -lt 7; $i++)
		{
			Start-Sleep 4
			$ConfirmRunning = C:\Windows\System32\schtasks.exe /s $source /query /tn restore /fo csv | ConvertFrom-Csv
			if ($ConfirmRunning.status -eq 'Running')
			{
				$i = 8
				$started=1	
			}
			else
			{
				Update-Log 'attempting again to start Restore operation'
			&  C:\Windows\System32\schtasks.exe /s $source /run /tn restore
			}
		}
		if ($started -eq 1)
		{
			#adding job to job grid
			$h = $checkboxVerboseLogging.CheckState
			
			if ($h -eq [System.Windows.Forms.CheckState]::Unchecked)
			{
			}
			Update-Log "$operation has started on $source"
			update-jobstatus
			Update-Log "Migration will be done soon"
	
		}
		else
		{
			Update-Log "Job failed to start"
			$button_begin.Enabled = $true
		}
		
	}
	##
	#endregion MigrationBeginsHere
	##
	# ** ------------------------------- ** #
	##
	#endregion globals
	##
	# ** ------------------------------- ** #
	##
	#region form
	# ** ------------------------------- ** #
	#Load form elements
	##
	Add-Type -AssemblyName System.Windows.Forms
	#define main form
	$MainForm_Load = {
		$LabelOperation = $null
		$usmtjob = $null
		$finalstring = $null
		reset-usmtstring
	}
	
	$buttonAbout_Click = {
		
		Show-about_psf
	}
	#update UI when changes are made##
	$checkboxVerboseLogging_CheckedChanged = {
		if ($checkboxVerboseLogging.Checked)
		{
			$labelMultipleJobsDisabled.Visible = $true
		}
		else { $labelMultipleJobsDisabled.Visible = $false }
		$MainForm.refresh()
		$MainForm.update()
		
	}
	
	$txt_SourceComputer_TextChanged = {
		$global:source = $($txt_SourceComputer.Text)
		if ($checkboxVerboseLogging.Checked -eq $false)
		{
		}
		reset-usmtstring
	}
	$RadioRestore_CheckedChanged = {
		if ($this.checked -eq $true)
		{
			$lbl_operationSelection.Text = "Operation = Restore"
		}
		reset-usmtstring
	}
	
	$picturebox2_Click = {
	
	}
	$RadioBackup_CheckedChanged = {
		if ($this.checked -eq $true)
		{
			$lbl_operationSelection.Text = "Operation = Backup"
		}
		reset-usmtstring
	}
	
	$txt_keyItem_TextChanged = {
		$global:txt_keyItem = $($txt_keyItem.Text)
		reset-usmtstring
	}
	
	$logtextbox_TextChanged = {
		$logtextbox.SelectionStart = $logtextbox.Text.Length
		$logtextbox.ScrollToCaret()
		#    if ($error[0]) { update-log -message $($error[0].Exception.Message) }
	}
	##Button Definitions
	$button_begin_Click = {
		#Disable the button so we don't trigger it again
		$initialize = $true
		$button_begin.Enabled = $false
		if ($source -and $txt_SourceComputer -and $txt_keyItem -and ($combo_selectOldPC.DisplayMember -or $combo_selectOldPC.DisplayMember) -ne $null)
		{
			initialize-Operation
			
		}
		else
		{
			Update-Log -message 'Missing required parameters!!  Check you filled required fields'
			$button_begin.Enabled = $true
			
		}
		
	}
	$buttonSources_Click = {
		$findfolder = get-folderdialogs
		if ("$findfolder" -ne $null)
		{
			$txt_usmtfile.Text = $findfolder
			$global:usmtfiles = $findfolder
		}
	}
	$buttonBrowseFolder_Click = {
		$findfolder = get-folderdialogs
		if ($findfolder.FileName -ne $null)
		{
			$textboxfolder.Text = $findfolder.FileName
		}
	}
	$button_proselect_Click = {
		$findfolder = get-folderdialogs
		if ("$findfolder" -ne $null)
		{
			$txt_proselect.Text = $findfolder
			$global:proselectdir = $findfolder
		}
	}
	
	$buttonQuit_Click = {
		update-config
		Get-Job | Stop-Job
		Get-Job | Remove-Job
		$ErrorActionPreference = 'SilentlyContinue'
		$tmpVars = Get-Variable -Scope Global | Where-Object{
			[System.Object]::ReferenceEquals($this, $_.Value)
		}
		$ErrorActionPreference = 'SilentlyContinue'
		if ($tmpVars.GetType().FullName -eq 'System.Management.Automation.PSVariable')
		{
			Remove-Variable -Scope Global -Name $tmpVars.Name
		}
		else
		{
			for ($i = 0; $i -lt $tmpVars.Count; $i++)
			{
				Remove-Variable -Scope Global -Name $tmpVars[$i].Name
			}
		}
		$MainForm.Close()
	}
	$buttonshowC_Click = {
		open-cdrive
	}
	$buttonCMTraceLog_Click = {
		if ($RadioBackup.Checked)
		{
			open-CMTracefile -Job Backup
		}
		else { open-CMTracefile -Job Restore }
	}
	$buttonShowHistory_Click = {
		$mycsv = "$env:LOCALAPPDATA\Remote_USMT\usmtlogs.csv"
		if ($(Test-Path -Path $mycsv) -eq $false)
		{
			[System.Windows.Forms.MessageBox]::Show('No History Found - Perform a Migration Prior to using this')
		}
		elseif ($(Test-Path $mycsv) -eq $true)
		{
			$history = Show-HistoryWindow_psf
			$mycsvtext = Import-Csv -Path $mycsv
			if ($history -eq 'Yes')
			{
				$RadioRestore.Checked = $true
				$txt_keyItem.Text = $HistoryWindow_historyGrid_SelectedObjects.encryptionkey
				$combo_selectOldPC.Items.add($HistoryWindow_historyGrid_SelectedObjects.target)
				$combo_selectOldPC.SelectedItem = $HistoryWindow_historyGrid_SelectedObjects.target
			}
		}
	}
	
	$ButtonCheckAvailable_Click = {
		$combo_selectOldPC.Items.Clear()
		check-AvailableMigs
		reset-usmtstring
	}
	$buttonCancel_Click = {
		$script:CancelLoop = $true
	}
	#form updates
	$jobTracker_FormClosed = [System.Windows.Forms.FormClosedEventHandler] {
		#Event Argument: $_ = [System.Windows.Forms.FormClosedEventArgs]
		#Stop any pending jobs
		Stop-JobTracker
	}
	$MainForm_FormClosing = [System.Windows.Forms.FormClosingEventHandler] {
		#Event Argument: $_ = [System.Windows.Forms.FormClosingEventArgs]     
	}
	#main async timer
	$timerJobTracker_Tick = {
		Update-JobTracker
	}
	#dialogs for input
	$dialog_usmtSources_FileOk = [System.ComponentModel.CancelEventHandler] {
		#Event Argument: $_ = [System.ComponentModel.CancelEventArgs]
	}
	$dialog_savefile_FileOk = [System.ComponentModel.CancelEventHandler] {
		#Event Argument: $_ = [System.Component``Model.CancelEventArgs]
	}
	$MainForm_Shown = {
		set-config
		reset-usmtstring
	}
	$combo_selectOldPC_selectedIndexChanged = {
		reset-usmtstring
	}
	$combo_Configs_SelectedIndexChanged = {
		reset-usmtstring
	}
	$combo_userchoice_SelectedIndexChanged = {
		$combo_userchoice.DisplayMember = $combo_userchoice.SelectedItem
		
		reset-usmtstring
	}
	$helpProvider_Click = {
	
	}
	
	##
	# ** ------------------------------- ** #
	#endregion form
	##
	# ** ------------------------------- **
	##
	# ** ------------------------------- ** #
	##
	
	$MainForm_Deactivate={
		
		$MainForm.SuspendLayout()
	}
	
	$MainForm_Activated={
		
		$MainForm.ResumeLayout()
	
	}
	
	#region Control Helper Functions
	function Update-ListBox
	{
	<#
		.SYNOPSIS
			This functions helps you load items into a ListBox or CheckedListBox.
		
		.DESCRIPTION
			Use this function to dynamically load items into the ListBox control.
		
		.PARAMETER ListBox
			The ListBox control you want to add items to.
		
		.PARAMETER Items
			The object or objects you wish to load into the ListBox's Items collection.
		
		.PARAMETER DisplayMember
			Indicates the property to display for the items in this control.
			
		.PARAMETER ValueMember
			Indicates the property to use for the value of the control.
		
		.PARAMETER Append
			Adds the item(s) to the ListBox without clearing the Items collection.
		
		.EXAMPLE
			Update-ListBox $ListBox1 "Red", "White", "Blue"
		
		.EXAMPLE
			Update-ListBox $listBox1 "Red" -Append
			Update-ListBox $listBox1 "White" -Append
			Update-ListBox $listBox1 "Blue" -Append
		
		.EXAMPLE
			Update-ListBox $listBox1 (Get-Process) "ProcessName"
		
		.NOTES
			Additional information about the function.
	#>
		
		param
		(
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			[System.Windows.Forms.ListBox]
			$ListBox,
			[Parameter(Mandatory = $true)]
			[ValidateNotNull()]
			$Items,
			[Parameter(Mandatory = $false)]
			[string]$DisplayMember,
			[Parameter(Mandatory = $false)]
			[string]$ValueMember,
			[switch]
			$Append
		)
		
		if (-not $Append)
		{
			$ListBox.Items.Clear()
		}
		
		if ($Items -is [System.Windows.Forms.ListBox+ObjectCollection] -or $Items -is [System.Collections.ICollection])
		{
			$ListBox.Items.AddRange($Items)
		}
		elseif ($Items -is [System.Collections.IEnumerable])
		{
			$ListBox.BeginUpdate()
			foreach ($obj in $Items)
			{
				$ListBox.Items.Add($obj)
			}
			$ListBox.EndUpdate()
		}
		else
		{
			$ListBox.Items.Add($Items)
		}
		
		if ($DisplayMember)
		{
			$ListBox.DisplayMember = $DisplayMember
		}
		if ($ValueMember)
		{
			$ListBox.ValueMember = $ValueMember
		}
	}
	
	function Show-NotifyIcon
	{
	<#
		.SYNOPSIS
			Displays a NotifyIcon's balloon tip message in the taskbar's notification area.
		
		.DESCRIPTION
			Displays a NotifyIcon's a balloon tip message in the taskbar's notification area.
			
		.PARAMETER NotifyIcon
	     	The NotifyIcon control that will be displayed.
		
		.PARAMETER BalloonTipText
	     	Sets the text to display in the balloon tip.
		
		.PARAMETER BalloonTipTitle
			Sets the Title to display in the balloon tip.
		
		.PARAMETER BalloonTipIcon	
			The icon to display in the ballon tip.
		
		.PARAMETER Timeout	
			The time the ToolTip Balloon will remain visible in milliseconds. 
			Default: 0 - Uses windows default.
	#>
		 param(
		  [Parameter(Mandatory = $true, Position = 0)]
		  [ValidateNotNull()]
		  [System.Windows.Forms.NotifyIcon]$NotifyIcon,
		  [Parameter(Mandatory = $true, Position = 1)]
		  [ValidateNotNullOrEmpty()]
		  [String]$BalloonTipText,
		  [Parameter(Position = 2)]
		  [String]$BalloonTipTitle = '',
		  [Parameter(Position = 3)]
		  [System.Windows.Forms.ToolTipIcon]$BalloonTipIcon = 'None',
		  [Parameter(Position = 4)]
		  [int]$Timeout = 0
	 	)
		
		if($null -eq $NotifyIcon.Icon)
		{
			#Set a Default Icon otherwise the balloon will not show
			$NotifyIcon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon([System.Windows.Forms.Application]::ExecutablePath)
		}
		
		$NotifyIcon.ShowBalloonTip($Timeout, $BalloonTipTitle, $BalloonTipText, $BalloonTipIcon)
	}
	
	#endregion
	
	$notifyicon1_MouseDoubleClick=[System.Windows.Forms.MouseEventHandler]{
	#Event Argument: $_ = [System.Windows.Forms.MouseEventArgs]
		
	}
	Function New-Toast
	{
		param ($JobName,
			$jobstatus,
			$jobresult
		)
		
		[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
		[Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
		[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null
		$app = $(new-guid)
		$icon = $MainForm.Icon | convertto-html
		$template = @"
<toast activationType="protocol"> // protocol,Background,Foreground
    <visual>
        <binding template="ToastGeneric">
            <text id="1">$jobname</text>
            <text id="2">$jobstatus</text>
<text id="2">$jobresult</text>
        </binding>
    </visual>
</toast>

"@
	
		$xml = New-Object Windows.Data.Xml.Dom.XmlDocument
		$xml.LoadXml($template)
		$toast = New-Object Windows.UI.Notifications.ToastNotification $xml
		[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($app).Show($toast)
		
	}
	
	$chkbox_NoShares_CheckedChanged = {
		if ($chkbox_NoShares.Checked -eq $TRUE)
		{
			
			Update-Log -message 'You have selected one-off Custom mode.  This will not use any shared folders and rely only on storage of the host'
			update-log -message 'computer and your computer. In this mode it is recommended you set the profile directory to a local path (this will '
			update-log -message 'be local on the target PC).  You will then want to manually transfer this file to the new computer.'
			$panel_Shares.Visible = $false
			$panel_noShares.visible = $true
			
		}
		else {$panel_noShares.Visible = $false
			$panel_Shares.Visible = $true
		}
	}
	
	$panel_SoloPanel_Paint=[System.Windows.Forms.PaintEventHandler]{
	#Event Argument: $_ = [System.Windows.Forms.PaintEventArgs]
		
	}
	
	$buttonBrowseFolder_Click2={
		if($folderbrowsermoderndialog1.ShowDialog() -eq 'OK')
		{
			$textboxFolder.Text = $folderbrowsermoderndialog1.SelectedPath
		}
	}
	
	$btn_noSharesUSMT_Click={
		
		$findfolder = get-folderdialogs
		if ("$findfolder" -ne $null)
		{
			$txt_localusmtfiles.Text = $findfolder
	
		}
	}
	
	$btn_nosharesMig_Click={
		
		$findfolder = get-folderdialogs
		$verifymig = ls $findfolder
		
		if ($verifymig -match 'usmt.mig')
		{
			$txt_localmigfile.Text = $findfolder
		}
		else{Update-Log -color 'red' -message 'The file MUST be named "USMT.MIG" and must be contained within this directory!'}
	}
	
	$lb_migrationXMLS_SelectedIndexChanged={
		
	}
	
	$button1_Click={
		$newXML = $AddXMLS.ShowDialog()
		foreach ($file in $AddXMLS)
		{
			$msg=$null
			if ($file.safefilename -match '.xml')
			{
				$msg = 'C:\windows\Temp\usmtfiles\' + $file.safefilename
				$lb_migrationXMLS.Items.Add($msg)
				
				Update-Log -color Green -message "Added $file.safefilename XML to migration"
			}
			else { Update-Log -color red -message "Cancelled or You didnt select an XML file" }
		}
	}
	
	$button2_Click={
		
		#$lb_migrationXMLS.SelectedItems.Remove($lb_migrationXMLS.SelectedItem)
		$itemtoremove = $lb_migrationXMLS.SelectedItem
		$idx = $lb_migrationXMLS.SelectedIndex
		$lb_migrationXMLS.Items.RemoveAt($idx)
		Update-Log -color red -message "You removed $itemtoremove from the migration"
	
		
	}
	
	$txt_usmtString_Enter={
		$txt_usmtString.Multiline = 1
		$txt_usmtString.Height=180
		$txt_usmtString.WordWrap = 1
		$txt_usmtString.update()
		
	}
	
	$txt_usmtString_Leave={
		
		$txt_usmtString.Multiline = 0
		$txt_usmtString.Height = 25
		$txt_usmtString.WordWrap = 0
		$txt_usmtString.update()
		
	}
	
	$txt_appendUSMT_Enter={
		
		$txt_appendUSMT.Multiline = 1
		$txt_appendUSMT.Height = 180
		$txt_appendUSMT.Width=180
		$txt_appendUSMT.WordWrap = 1
		$txt_appendUSMT.update()
	}
	
	$txt_appendUSMT_Leave={
		
		$txt_appendUSMT.Multiline = 0
		$txt_appendUSMT.Height = 25
		$txt_appendUSMT.WordWrap = 0
		$txt_appendUSMT.Width = 115
		$txt_appendUSMT.update()
	}
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$MainForm.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:USMT_Remote_Gui_txt_appendUSMT = $txt_appendUSMT.Text
		$script:USMT_Remote_Gui_chkbox_NoShares = $chkbox_NoShares.Checked
		$script:USMT_Remote_Gui_combo_userchoice = $combo_userchoice.Text
		$script:USMT_Remote_Gui_combo_userchoice_SelectedItem = $combo_userchoice.SelectedItem
		$script:USMT_Remote_Gui_lb_migrationXMLS = $lb_migrationXMLS.SelectedItems
		$script:USMT_Remote_Gui_RadioRestore = $RadioRestore.Checked
		$script:USMT_Remote_Gui_RadioBackup = $RadioBackup.Checked
		$script:USMT_Remote_Gui_txt_SourceComputer = $txt_SourceComputer.Text
		$script:USMT_Remote_Gui_combo_selectOldPC = $combo_selectOldPC.Text
		$script:USMT_Remote_Gui_combo_selectOldPC_SelectedItem = $combo_selectOldPC.SelectedItem
		$script:USMT_Remote_Gui_txt_usmtfile = $txt_usmtfile.Text
		$script:USMT_Remote_Gui_txt_proselect = $txt_proselect.Text
		$script:USMT_Remote_Gui_txt_localusmtfiles = $txt_localusmtfiles.Text
		$script:USMT_Remote_Gui_txt_localmigfile = $txt_localmigfile.Text
		$script:USMT_Remote_Gui_txt_usmtString = $txt_usmtString.Text
		$script:USMT_Remote_Gui_txt_keyItem = $txt_keyItem.Text
		$script:USMT_Remote_Gui_checkboxVerboseLogging = $checkboxVerboseLogging.Checked
		$script:USMT_Remote_Gui_DGV_jobstatus = $DGV_jobstatus.SelectedCells
		if ($DGV_jobstatus.SelectionMode -eq 'FullRowSelect')
		{ $script:USMT_Remote_Gui_DGV_jobstatus_SelectedObjects = $DGV_jobstatus.SelectedRows | Select-Object -ExpandProperty DataBoundItem }
		else { $script:USMT_Remote_Gui_DGV_jobstatus_SelectedObjects = $DGV_jobstatus.SelectedCells | Select-Object -ExpandProperty RowIndex -Unique | ForEach-Object { if ($_ -ne -1) { $DGV_jobstatus.Rows[$_].DataBoundItem } } }
		$script:USMT_Remote_Gui_RadioBatchRestore = $RadioBatchRestore.Checked
		$script:USMT_Remote_Gui_RadioBatchBackup = $RadioBatchBackup.Checked
		$script:USMT_Remote_Gui_datagridview1 = $datagridview1.SelectedCells
		if ($datagridview1.SelectionMode -eq 'FullRowSelect')
		{ $script:USMT_Remote_Gui_datagridview1_SelectedObjects = $datagridview1.SelectedRows | Select-Object -ExpandProperty DataBoundItem }
		else { $script:USMT_Remote_Gui_datagridview1_SelectedObjects = $datagridview1.SelectedCells | Select-Object -ExpandProperty RowIndex -Unique | ForEach-Object { if ($_ -ne -1) { $datagridview1.Rows[$_].DataBoundItem } } }
		$script:USMT_Remote_Gui_logtextbox = $logtextbox.Text
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$txt_appendUSMT.remove_Enter($txt_appendUSMT_Enter)
			$txt_appendUSMT.remove_Leave($txt_appendUSMT_Leave)
			$chkbox_NoShares.remove_CheckedChanged($chkbox_NoShares_CheckedChanged)
			$combo_userchoice.remove_SelectedIndexChanged($combo_userchoice_SelectedIndexChanged)
			$HelpButton.remove_Click($HelpButton_Click)
			$button_GetUsers.remove_Click($button_getusers_Click)
			$button2.remove_Click($button2_Click)
			$button1.remove_Click($button1_Click)
			$lb_migrationXMLS.remove_SelectedIndexChanged($lb_migrationXMLS_SelectedIndexChanged)
			$RadioRestore.remove_CheckedChanged($RadioRestore_CheckedChanged)
			$RadioBackup.remove_CheckedChanged($RadioBackup_CheckedChanged)
			$txt_SourceComputer.remove_TextChanged($txt_SourceComputer_TextChanged)
			$txt_SourceComputer.remove_Leave($button_getusers_Click)
			$combo_selectOldPC.remove_SelectedIndexChanged($combo_selectOldPC_SelectedIndexChanged)
			$ButtonCheckAvailable.remove_Click($ButtonCheckAvailable_Click)
			$buttonSources.remove_Click($buttonSources_Click)
			$txt_usmtfile.remove_Validating($txt_usmtfile_Validated)
			$txt_usmtfile.remove_Validated($txt_usmtfile_Validated)
			$button_proselect.remove_Click($button_proselect_Click)
			$btn_noSharesUSMT.remove_Click($btn_noSharesUSMT_Click)
			$btn_nosharesMig.remove_Click($btn_nosharesMig_Click)
			$panel_SoloPanel.remove_Paint($panel_SoloPanel_Paint)
			$buttonAbout.remove_Click($buttonAbout_Click)
			$txt_usmtString.remove_Enter($txt_usmtString_Enter)
			$txt_usmtString.remove_Leave($txt_usmtString_Leave)
			$labelX.remove_Click($labelX_Click)
			$txt_keyItem.remove_TextChanged($txt_keyItem_TextChanged)
			$buttonShowHistory.remove_Click($buttonShowHistory_Click)
			$checkboxVerboseLogging.remove_CheckedChanged($checkboxVerboseLogging_CheckedChanged)
			$buttonshowC.remove_Click($buttonshowC_Click)
			$DGV_jobstatus.remove_CellContentClick($DGV_jobstatus_CellContentClick)
			$buttonCMTraceLog.remove_Click($buttonCMTraceLog_Click)
			$buttonQuit.remove_Click($buttonQuit_Click)
			$buttonQuit.remove_MouseClick($buttonQuit_Click)
			$button_begin.remove_Click($button_begin_Click)
			$logtextbox.remove_TextChanged($logtextbox_TextChanged)
			$MainForm.remove_Activated($MainForm_Activated)
			$MainForm.remove_Deactivate($MainForm_Deactivate)
			$MainForm.remove_FormClosing($MainForm_FormClosing)
			$MainForm.remove_FormClosed($jobTracker_FormClosed)
			$MainForm.remove_Load($MainForm_Load)
			$MainForm.remove_Shown($MainForm_Shown)
			$dialog_savefile.remove_FileOk($dialog_savefile_FileOk)
			$dialog_usmtSources.remove_FileOk($dialog_usmtSources_FileOk)
			$timerJobTracker.remove_Tick($timerJobTracker_Tick)
			$notifyicon1.remove_MouseDoubleClick($notifyicon1_MouseDoubleClick)
			$MainForm.remove_Load($Form_StateCorrection_Load)
			$MainForm.remove_Closing($Form_StoreValues_Closing)
			$MainForm.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$MainForm.SuspendLayout()
	$picturebox1.BeginInit()
	$panel_SoloPanel.SuspendLayout()
	$PanelSelectUser.SuspendLayout()
	$Panel_TargetPC.SuspendLayout()
	$Panel_SelectOldPC.SuspendLayout()
	$panel_Shares.SuspendLayout()
	$panel_noShares.SuspendLayout()
	$DGV_jobstatus.BeginInit()
	$panel_batchBox.SuspendLayout()
	$datagridview1.BeginInit()
	$filesystemwatcher1.BeginInit()
	$bindingsource1.BeginInit()
	#
	# MainForm
	#
	$MainForm.Controls.Add($label200)
	$MainForm.Controls.Add($txt_appendUSMT)
	$MainForm.Controls.Add($chkbox_NoShares)
	$MainForm.Controls.Add($picturebox1)
	$MainForm.Controls.Add($labelMouseOverFieldsForHe)
	$MainForm.Controls.Add($labelCancelJob)
	$MainForm.Controls.Add($panel_SoloPanel)
	$MainForm.Controls.Add($labelOldPCName)
	$MainForm.Controls.Add($buttonAbout)
	$MainForm.Controls.Add($txt_usmtString)
	$MainForm.Controls.Add($labelX)
	$MainForm.Controls.Add($txt_keyItem)
	$MainForm.Controls.Add($lbl_operationSelection)
	$MainForm.Controls.Add($labelEncryptionKey)
	$MainForm.Controls.Add($label202)
	$MainForm.Controls.Add($labelMultipleJobsDisabled)
	$MainForm.Controls.Add($buttonShowHistory)
	$MainForm.Controls.Add($checkboxVerboseLogging)
	$MainForm.Controls.Add($buttonshowC)
	$MainForm.Controls.Add($DGV_jobstatus)
	$MainForm.Controls.Add($buttonCMTraceLog)
	$MainForm.Controls.Add($buttonQuit)
	$MainForm.Controls.Add($button_begin)
	$MainForm.Controls.Add($panel_batchBox)
	$MainForm.Controls.Add($labelUSMTRemoteMigrationG)
	$MainForm.Controls.Add($logtextbox)
	$MainForm.AccessibleRole = 'None'
	$MainForm.AutoScaleDimensions = New-Object System.Drawing.SizeF(96, 96)
	$MainForm.AutoScaleMode = 'Dpi'
	$MainForm.AutoSize = $True
	$MainForm.AutoSizeMode = 'GrowAndShrink'
	$MainForm.AutoValidate = 'EnableAllowFocusChange'
	$MainForm.BackColor = [System.Drawing.Color]::DimGray 
	$MainForm.CausesValidation = $False
	$MainForm.ClientSize = New-Object System.Drawing.Size(825, 773)
	$MainForm.Cursor = 'Default'
	$MainForm.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABNTeXN0
ZW0uRHJhd2luZy5JY29uAgAAAAhJY29uRGF0YQhJY29uU2l6ZQcEAhNTeXN0ZW0uRHJhd2luZy5T
aXplAgAAAAIAAAAJAwAAAAX8////E1N5c3RlbS5EcmF3aW5nLlNpemUCAAAABXdpZHRoBmhlaWdo
dAAACAgCAAAAAAAAAAAAAAAPAwAAAMxcAAACAAABAAUAEBAAAAEAIABoBAAAVgAAABgYAAABACAA
iAkAAL4EAAAgIAAAAQAgAKgQAABGDgAAMDAAAAEAIACoJQAA7h4AAAAAAAABACAANhgAAJZEAAAo
AAAAEAAAACAAAAABACAAAAAAAAAEAADDDgAAww4AAAAAAAAAAAAA+8BCAPvAQgD7wEI6+8BCvfvA
Qjn7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIF+8BC
p/vAQv/7wELI+8BCO/vAQgP7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA
+8BCCPvAQrn7wEL/+8BC//vAQuj7wEKm+8BCe/vAQmj7wEJk+8BCW/vAQin7wEIC+8BCAAAAAAAA
AAAA+8BCAPvAQgD7wEIv+8BCdPvAQrn7wELx+8BC//vAQv/7wEL/+8BC//vAQv77wELi+8BCZ/vA
QgP7wEIAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIK+8BCQfvAQq77wEL5+8BC//vAQv/7wEL/+8BC
//vAQuz7wEJD+8BCAPvAQgAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQgv7wEJb+8BC5fvAQv/7wEL/
+8BC//vAQv/7wEL/+8BCovvAQgP7wEIAAAAAAAAAAAD7wEIA+8BCBfvAQkz7wEK8+8BC9vvAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQtn7wEIb+8BCAAAAAAD7wEIA+8BCDvvAQob7wELx+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL5+8BC3fvAQv37wELx+8BCOPvAQgD7wEIA+8BCC/vAQpT7wEL8+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC5fvAQmD7wEK++8BC//vAQpf7wEIc+8BCAPvAQmv7wEL5
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQrT7wEJ++8BCTfvAQrL7wELG+8BCRfvAQiP7
wELV+8BC//vAQv/7wEL/+8BC//vAQv/7wEL8+8BC6PvAQqj7wEJr+8BCnvvAQgz7wEIL+8BCEPvA
QgH7wEJq+8BC+/vAQv/7wEL/+8BC/fvAQuL7wEKl+8BCXPvAQkj7wEKO+8BC4vvAQpj7wEIA+8BC
AAAAAAAAAAAA+8BCovvAQv/7wEL5+8BCx/vAQm/7wEIl+8BCBPvAQgD7wEIy+8BC6/vAQv/7wEKC
+8BCAPvAQgAAAAAAAAAAAPvAQrf7wELQ+8BCYPvAQhL7wEIA+8BCAAAAAAD7wEIA+8BCBvvAQpz7
wEL/+8BCg/vAQgD7wEIAAAAAAAAAAAD7wEJQ+8BCH/vAQgD7wEIAAAAAAAAAAAAAAAAA+8BCAPvA
QgD7wEIg+8BCwfvAQpv7wEIA+8BCAAAAAAAAAAAA+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAD7wEIA+8BCAPvAQin7wEJ4+8BCCvvAQgAAAAAAAAAAAMf/AACB/wAAgAcAAMADAADwAwAA
+AEAAOABAADAAQAAgAAAAIAAAAAAAAAAAA8AAAEPAAAPDwAAP48AAP/HAAAoAAAAGAAAADAAAAAB
ACAAAAAAAAAJAADDDgAAww4AAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAvvAQmT7wEK1+8BCHvvA
QgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCQ/vAQuj7wEL/+8BCn/vAQhL7wEIA+8BCAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEIC+8BCoPvAQv/7wEL/+8BC/fvAQqv7wEIp+8BCAfvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIE+8BCsfvAQv/7wEL/+8BC
//vAQv/7wELe+8BCkfvAQlr7wEI9+8BCL/vAQin7wEIp+8BCJvvAQhH7wEIB+8BCAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCbfvAQtv7wEL2+8BC//vAQv/7wEL/+8BC//vAQv37
wEL0+8BC7fvAQun7wELp+8BC5/vAQsr7wEJ5+8BCFvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAA
AAD7wEIA+8BCBPvAQhr7wEJH+8BCjfvAQtb7wEL8+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL++8BCtPvAQh37wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA
+8BCAfvAQhv7wEJs+8BC1PvAQv77wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQpv7
wEIH+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCHfvA
QqD7wEL9+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvD7wEJC+8BCAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIR+8BCUPvAQq37wEL7+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEKU+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEIA+8BCC/vAQln7wELC+8BC+PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wELO+8BCE/vAQgAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIq+8BCqPvAQvf7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wELs+8BCL/vAQgAAAAAA
AAAAAAAAAAD7wEIA+8BCAPvAQkf7wELV+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQt77wELT+8BC//vAQv/7wEL6+8BCTvvAQgAAAAAAAAAAAPvAQgD7wEIA+8BCTfvA
QuT7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQpn7wEI0+8BC
xvvAQv/7wEL/+8BCnPvAQg37wEIA+8BCAPvAQgD7wEI1+8BC3PvAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQoD7wEJ2+8BCWPvAQuD7wEL/+8BC+/vAQrP7
wEIt+8BCAPvAQg/7wEK0+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC2vvAQkj7wEK4+8BCJ/vAQkT7wEK8+8BC0PvAQn/7wEIT+8BCAPvAQl37wEL6+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv77wELT+8BCSvvAQnX7wEKy
+8BCCPvAQgD7wEIL+8BCEfvAQgL7wEIA+8BCC/vAQrb7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQvf7wELV+8BCp/vAQmv7wEIz+8BCcPvAQvD7wEKH+8BCAPvAQgAAAAAAAAAAAAAA
AAAAAAAA+8BCNfvAQuj7wEL/+8BC//vAQv/7wEL/+8BC//vAQvr7wELX+8BClPvAQkz7wEIY+8BC
DPvAQnf7wELL+8BC+vvAQv/7wEJj+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCZPvAQvv7wEL/
+8BC//vAQv/7wELv+8BCsfvAQlv7wEIb+8BCAvvAQgD7wEIA+8BCCfvAQrn7wEL/+8BC//vAQvv7
wEJP+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BChPvAQv/7wEL/+8BC7PvAQp37wEI9+8BCCPvA
QgD7wEIAAAAAAAAAAAD7wEIA+8BCAPvAQmj7wEL8+8BC//vAQvn7wEJI+8BCAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCkPvAQvj7wEKq+8BCO/vAQgX7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
+8BCAPvAQhT7wEK8+8BC//vAQvv7wEJP+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCa/vAQmb7
wEIK+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEI2+8BC2PvA
Qv/7wEJl+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCCPvAQgL7wEIAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCPfvAQtT7wEKN+8BCAPvAQgAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAD7wEIA+8BCAPvAQjL7wEJ3+8BCCPvAQgAAAAAAAAAAAAAAAAAAAAAA4f//AOD/
/wDAP/8AwAA/AOAAHwDgAA8A/AAHAP+ABwD/AAcA/AADAPgAAwDwAAMA4AABAMAAAACAAAAAgAAR
AAAAPwAAAD8AADA/AAH4PwAH+D8AH/w/AD/+PwD//x8AKAAAACAAAABAAAAAAQAgAAAAAAAAEAAA
ww4AAMMOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCDPvAQob7wEKg+8BCDfvAQgAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgX7wEKF+8BC
+fvAQvn7wEJ2+8BCBPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEIA+8BCSfvAQvH7wEL/+8BC//vAQvL7wEJw+8BCBvvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCAPvAQgD7wEKU+8BC//vAQv/7wEL/+8BC//vAQvX7wEKP+8BCHfvAQgD7wEIA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAfvAQqL7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv77wELR+8BCfPvAQkH7wEIi+8BCEvvAQgv7wEIH+8BCBvvAQgb7wEIG+8BCAfvAQgAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCgvvAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC9fvAQuL7wELQ+8BCwvvAQrn7wEK2+8BCt/vAQrf7
wEKZ+8BCW/vAQhf7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvA
QgD7wEIk+8BCe/vAQrL7wELi+8BC/PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL7+8BCyfvAQkv7wEIC+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCBvvAQiX7wEJh+8BCsPvAQu37wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC6vvAQln7wEIA+8BCAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIH+8BC
OfvAQpn7wELs+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC4PvAQjT7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAD7wEIA+8BCBPvAQkD7wEK8+8BC/fvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BCpfvAQgf7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQh37wEK0+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wELu+8BCOvvAQgAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhP7wEJY+8BCq/vA
Quj7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEKE+8BC
APvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhD7wEJi
+8BCx/vAQvn7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQsD7wEIM+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvA
QgP7wEJB+8BCuvvAQvr7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC5fvAQib7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAPvAQgD7wEIN+8BCefvAQuv7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL3+8BCRfvAQgAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQgD7wEIA+8BCGPvAQqD7wEL7+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvn7wEKy+8BC2PvAQv/7wEL/+8BC//vAQv/7wEJn
+8BCAPvAQgAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhn7wEKu+8BC/vvAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC8fvAQjn7wEI0+8BC0/vA
Qv/7wEL/+8BC//vAQqv7wEIM+8BCAAAAAAAAAAAAAAAAAPvAQgD7wEIO+8BCovvAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wELm
+8BCRfvAQlT7wEJQ+8BC7fvAQv/7wEL/+8BC+fvAQqD7wEI1+8BCCAAAAAD7wEIA+8BCAfvAQnv7
wEL8+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQrr7wEI4+8BC0PvAQjP7wEJv+8BC8/vAQv/7wEL/+8BC//vAQrj7wEId+8BC
APvAQgD7wEI8+8BC6PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wELz+8BCU/vAQlf7wELa+8BCIvvAQgT7wEJa+8BCvfvAQs/7
wEKW+8BCKPvAQgD7wEIA+8BCCPvAQqn7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC7vvAQnL7wEIV+8BCuvvAQrD7wEIF+8BC
APvAQgD7wEIL+8BCEfvAQgP7wEIAAAAAAPvAQgD7wEI8+8BC7/vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL6+8BC5fvAQqj7wEI/+8BCEfvAQo/7
wEL++8BCevvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQoj7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvH7wELG+8BChvvAQk/7wEIo+8BC
F/vAQkf7wEK2+8BC/PvAQvv7wEJQ+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIQ
+8BCxPvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC9vvAQsr7wEKD+8BCPPvAQg/7
wEIA+8BCAPvAQl77wELN+8BC9fvAQv/7wEL/+8BC8PvAQjX7wEIAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQi77wELm+8BC//vAQv/7wEL/+8BC//vAQv/7wEL++8BC4/vAQp37wEJK+8BC
EvvAQgD7wEIAAAAAAPvAQgD7wEIA+8BCbfvAQv/7wEL/+8BC//vAQv/7wELm+8BCJfvAQgAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCTPvAQvX7wEL/+8BC//vAQv/7wEL8+8BC1PvAQnz7
wEIp+8BCA/vAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIt+8BC5vvAQv/7wEL/+8BC//vA
QuD7wEIe+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEJg+8BC+vvAQv/7wEL++8BC
1PvAQnH7wEIc+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgP7wEKV
+8BC//vAQv/7wEL/+8BC4PvAQh77wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQmb7
wEL8+8BC6PvAQoP7wEIe+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAA+8BCAPvAQij7wELW+8BC//vAQv/7wELm+8BCJvvAQgAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCXvvAQrj7wEI7+8BCAvvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQlD7wELq+8BC//vAQvH7wEI3+8BCAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIZ+8BCFvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAfvAQl77wELr+8BC
/fvAQlX7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7
wEIA+8BCAvvAQk/7wELb+8BChPvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQjf7wEJ0+8BCB/vAQgAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAD4f///8D////Af///wD///4AAD//AAAP/wAAA//AAAP/+AAB//4AAP//gAD//gAA//
gAAH/gAAB/wAAAf4AAAH8AAAA+AAAADAAAAAwAAAAYAAAGOAAAD/gAAA/wABgP8AD4D/AD+A/wH/
gP8H/8D/D//g/z//4P////D////8fygAAAAwAAAAYAAAAAEAIAAAAAAAACQAAMMOAADDDgAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIu+8BCr/vAQmT7wEIA
+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BC
APvAQj/7wELR+8BC//vAQtr7wEIz+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQgD7wEIA+8BCMPvAQtb7wEL/+8BC//vAQv/7wELC+8BCIvvAQgD7wEIAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIK+8BCq/vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BCt/vAQiH7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEJC+8BC8vvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQsD7wEIx+8BCAPvAQgAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAA+8BCAPvAQgD7wEJz+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wELb+8BCYPvAQgz7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEKA+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC9/vAQrT7wEJX+8BCHvvAQgb7wEIA+8BCAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BC
APvAQgD7wEJu+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL5
+8BC3PvAQrT7wEKO+8BCb/vAQlf7wEJH+8BCPPvAQjX7wEIy+8BCMvvAQjT7wEI4+8BCKvvAQhH7
wEIC+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEJF+8BC9fvAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv37wEL4+8BC9PvAQvH7wELv
+8BC7/vAQvH7wELy+8BC6PvAQsz7wEKT+8BCQ/vAQgn7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIR+8BCf/vA
Qrz7wELj+8BC+/vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC8vvAQqb7wEIt
+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAD7wEIA+8BCAPvAQgn7wEIm+8BCWPvAQpr7wELW+8BC+fvAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wELY+8BCSvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgL7
wEIa+8BCVvvAQqf7wELp+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC4vvAQkT7wEIA+8BC
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgb7wEIy+8BCjPvAQuL7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQs/7wEIk+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA
+8BCAvvAQiz7wEKW+8BC7/vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEKW+8BCBfvAQgAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIF+8BCSfvAQsn7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wELt+8BCPfvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BC
APvAQhz7wEKj+8BC/PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BCm/vAQgP7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQgD7wEIA+8BCC/vAQjn7wEKS+8BC9vvAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC4PvAQiX7wEIA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhn7wEJj+8BCuvvAQvD7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC/fvAQmL7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIZ+8BCcPvAQs/7
wEL7+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQqH7wEIC+8BCAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA
+8BCDfvAQmD7wELN+8BC/PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
QtD7wEIU+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCAPvAQgH7wEI1+8BCr/vAQvj7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQu37wEIy+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCCvvAQmr7wELi+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvv7wEJU+8BCAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIY+8BCmPvA
Qvf7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEJ3+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7
wEIA+8BCAPvAQiX7wEK2+8BC/vvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvv7wEKS+8BC
jfvAQuv7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEKa+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCKfvAQsL7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQvf7wEJE+8BCAPvAQlb7wELp+8BC//vAQv/7wEL/+8BC//vAQv/7wELO+8BC
GPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIi+8BCwPvAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvX7wEI/+8BCJfvAQgz7wEJr+8BC+PvA
Qv/7wEL/+8BC//vAQv/7wEL9+8BCk/vAQhL7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BC
APvAQhP7wEKt+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQuf7
wEIm+8BCd/vAQmz7wEIK+8BCn/vAQv/7wEL/+8BC//vAQv/7wEL/+8BC+/vAQrr7wEJR+8BCFvvA
QgEAAAAAAAAAAAAAAAD7wEIA+8BCBPvAQof7wEL9+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQr77wEIK+8BCkPvAQuf7wEI0+8BCHPvAQr/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL4+8BCg/vAQgUAAAAAAAAAAPvAQgD7wEIA+8BCTvvAQvD7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC/PvAQmj7wEIE+8BCs/vAQvr7wEJH
+8BCAPvAQif7wEK3+8BC/fvAQv/7wEL/+8BC//vAQvf7wEKg+8BCHPvAQgAAAAAAAAAAAPvAQgD7
wEIX+8BCxfvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
tfvAQhD7wEIo+8BC5fvAQtP7wEIX+8BCAPvAQgD7wEIV+8BCb/vAQrr7wELL+8BCrfvAQlj7wEIL
+8BCAAAAAAAAAAAA+8BCAPvAQgD7wEJx+8BC/fvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wELD+8BCKfvAQgD7wEKC+8BC//vAQpz7wEIB+8BCAAAAAAD7wEIA+8BC
APvAQgn7wEIQ+8BCBfvAQgD7wEIAAAAAAAAAAAAAAAAA+8BCAPvAQhr7wELR+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC8vvAQpz7wEIh+8BCAPvAQkj7wELo+8BC//vA
QmT7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BC
APvAQmL7wEL8+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC+fvAQt/7wEKh+8BCRvvAQgf7
wEIB+8BCSfvAQtr7wEL/+8BC8PvAQjj7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAD7wEIA+8BCB/vAQrH7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL8+8BC4vvAQq37wEJ2
+8BCTfvAQiD7wEID+8BCAPvAQh77wEKA+8BC6fvAQv/7wEL/+8BC2vvAQhv7wEIAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCKfvAQuX7wEL/+8BC//vA
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
QhH7wEKh+8BC/vvAQv/7wEL/+8BCxPvAQgz7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAD7wEID+8BCCvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIV+8BCofvAQvz7wEL/+8BC3/vAQiD7wEIAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCEfvAQo37
wEL2+8BC9fvAQkL7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAA+8BCAPvAQgj7wEJl+8BC4fvAQnb7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIB+8BCPvvAQm/7wEIE
+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/j/////8AAP8H////
/wAA/gP/////AAD8Af////8AAPwA/////wAA/AA/////AAD8AAf///8AAPwAAAA//wAA/AAAAA//
AAD8AAAAB/8AAP8AAAAD/wAA/+AAAAH/AAD//AAAAP8AAP//AAAAfwAA///AAAB/AAD///AAAD8A
AP//4AAAPwAA//+AAAA/AAD//gAAAB8AAP/4AAAAHwAA/+AAAAAfAAD/wAAAAB8AAP+AAAAAHwAA
/wAAAAAfAAD+AAAAIA8AAPwAAAAABwAA+AAAAAAAAADwAAAAAAAAAPAAAAAEAQAA4AAAAAYDAADg
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
itEAAAAASUVORK5CYIIL'))
	#endregion
	$MainForm.Icon = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$MainForm.ImeMode = 'Off'
	$MainForm.KeyPreview = $True
	$MainForm.Margin = '4, 4, 4, 4'
	$MainForm.MaximizeBox = $False
	$MainForm.MaximumSize = New-Object System.Drawing.Size(1400, 1600)
	$MainForm.MinimumSize = New-Object System.Drawing.Size(780, 600)
	$MainForm.Name = 'MainForm'
	$MainForm.SizeGripStyle = 'Show'
	$MainForm.StartPosition = 'WindowsDefaultBounds'
	$MainForm.Text = 'USMT Remote Migration'
	$MainForm.add_Activated($MainForm_Activated)
	$MainForm.add_Deactivate($MainForm_Deactivate)
	$MainForm.add_FormClosing($MainForm_FormClosing)
	$MainForm.add_FormClosed($jobTracker_FormClosed)
	$MainForm.add_Load($MainForm_Load)
	$MainForm.add_Shown($MainForm_Shown)
	#
	# label200
	#
	$label200.Anchor = 'Top, Right'
	$label200.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$label200.ForeColor = [System.Drawing.Color]::Orange 
	$label200.Location = New-Object System.Drawing.Point(580, 342)
	$label200.Name = 'label200'
	$label200.Size = New-Object System.Drawing.Size(37, 28)
	$label200.TabIndex = 112
	$label200.Text = '+'
	$label200.TextAlign = 'BottomCenter'
	$label200.UseCompatibleTextRendering = $True
	#
	# txt_appendUSMT
	#
	$txt_appendUSMT.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$txt_appendUSMT.Location = New-Object System.Drawing.Point(623, 345)
	$txt_appendUSMT.Name = 'txt_appendUSMT'
	$txt_appendUSMT.Size = New-Object System.Drawing.Size(191, 25)
	$txt_appendUSMT.TabIndex = 111
	$tooltip1.SetToolTip($txt_appendUSMT, 'this text will be appended to the args of USMT command to send.')
	$txt_appendUSMT.add_Enter($txt_appendUSMT_Enter)
	$txt_appendUSMT.add_Leave($txt_appendUSMT_Leave)
	#
	# chkbox_NoShares
	#
	$chkbox_NoShares.ForeColor = [System.Drawing.Color]::FloralWhite 
	$chkbox_NoShares.Location = New-Object System.Drawing.Point(699, 116)
	$chkbox_NoShares.Name = 'chkbox_NoShares'
	$chkbox_NoShares.Size = New-Object System.Drawing.Size(120, 24)
	$chkbox_NoShares.TabIndex = 108
	$chkbox_NoShares.Text = 'No Shares'
	$tooltip1.SetToolTip($chkbox_NoShares, 'This means that you dont want to use any shares to manage this deployment.
You will have to pull the migration file off of the target PC manually.
It will be found in in this directory C:\windows\system32\temp\usmtfiles\store\usmt\usmt.mig.')
	$chkbox_NoShares.UseVisualStyleBackColor = $True
	$chkbox_NoShares.add_CheckedChanged($chkbox_NoShares_CheckedChanged)
	#
	# picturebox1
	#
	$picturebox1.Anchor = 'Top, Right'
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
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'))
	#endregion
	$picturebox1.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$picturebox1.Location = New-Object System.Drawing.Point(677, 1)
	$picturebox1.Name = 'picturebox1'
	$picturebox1.Size = New-Object System.Drawing.Size(145, 109)
	$picturebox1.SizeMode = 'StretchImage'
	$picturebox1.TabIndex = 0
	$picturebox1.TabStop = $False
	#
	# labelMouseOverFieldsForHe
	#
	$labelMouseOverFieldsForHe.AutoSize = $True
	$labelMouseOverFieldsForHe.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$labelMouseOverFieldsForHe.ForeColor = [System.Drawing.Color]::Coral 
	$labelMouseOverFieldsForHe.Location = New-Object System.Drawing.Point(12, 39)
	$labelMouseOverFieldsForHe.Name = 'labelMouseOverFieldsForHe'
	$labelMouseOverFieldsForHe.Size = New-Object System.Drawing.Size(190, 21)
	$labelMouseOverFieldsForHe.TabIndex = 15
	$labelMouseOverFieldsForHe.Text = 'Mouse Over fields for help!'
	#
	# labelCancelJob
	#
	$labelCancelJob.Anchor = 'Top, Right'
	$labelCancelJob.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$labelCancelJob.ForeColor = [System.Drawing.Color]::Orange 
	$labelCancelJob.Location = New-Object System.Drawing.Point(716, 211)
	$labelCancelJob.Name = 'labelCancelJob'
	$labelCancelJob.Size = New-Object System.Drawing.Size(93, 28)
	$labelCancelJob.TabIndex = 90
	$labelCancelJob.Text = 'Cancel Job'
	$labelCancelJob.TextAlign = 'BottomCenter'
	$labelCancelJob.UseCompatibleTextRendering = $True
	#
	# panel_SoloPanel
	#
	$panel_SoloPanel.Controls.Add($PanelSelectUser)
	$panel_SoloPanel.Controls.Add($Panel_TargetPC)
	$panel_SoloPanel.Controls.Add($Panel_SelectOldPC)
	$panel_SoloPanel.Controls.Add($panel_Shares)
	$panel_SoloPanel.Controls.Add($panel_noShares)
	$panel_SoloPanel.BackColor = [System.Drawing.Color]::Transparent 
	$panel_SoloPanel.BackgroundImageLayout = 'None'
	$panel_SoloPanel.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$panel_SoloPanel.Location = New-Object System.Drawing.Point(-3, 58)
	$panel_SoloPanel.Margin = '4, 4, 4, 4'
	$panel_SoloPanel.Name = 'panel_SoloPanel'
	$panel_SoloPanel.Size = New-Object System.Drawing.Size(707, 243)
	$panel_SoloPanel.TabIndex = 107
	$panel_SoloPanel.add_Paint($panel_SoloPanel_Paint)
	#
	# PanelSelectUser
	#
	$PanelSelectUser.Controls.Add($combo_userchoice)
	$PanelSelectUser.Controls.Add($HelpButton)
	$PanelSelectUser.Controls.Add($button_GetUsers)
	$PanelSelectUser.Controls.Add($labelSelectUser)
	$PanelSelectUser.Cursor = 'Default'
	$PanelSelectUser.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$PanelSelectUser.Location = New-Object System.Drawing.Point(10, 195)
	$PanelSelectUser.Name = 'PanelSelectUser'
	$PanelSelectUser.Size = New-Object System.Drawing.Size(630, 37)
	$PanelSelectUser.TabIndex = 0
	#
	# combo_userchoice
	#
	$combo_userchoice.BackColor = [System.Drawing.Color]::AliceBlue 
	$combo_userchoice.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$combo_userchoice.Location = New-Object System.Drawing.Point(113, 7)
	$combo_userchoice.Margin = '4, 4, 4, 4'
	$combo_userchoice.Name = 'combo_userchoice'
	$combo_userchoice.Size = New-Object System.Drawing.Size(349, 28)
	$combo_userchoice.TabIndex = 6
	$combo_userchoice.TabStop = $False
	$tooltip1.SetToolTip($combo_userchoice, 'Who do you want to back up

You can backup multiple users, click the ? for
more information on this.
')
	$combo_userchoice.add_SelectedIndexChanged($combo_userchoice_SelectedIndexChanged)
	#
	# HelpButton
	#
	$HelpButton.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$HelpButton.Location = New-Object System.Drawing.Point(590, 4)
	$HelpButton.Name = 'HelpButton'
	$helpprovider1.SetShowHelp($HelpButton, $True)
	$HelpButton.Size = New-Object System.Drawing.Size(20, 33)
	$HelpButton.TabIndex = 81
	$HelpButton.TabStop = $False
	$HelpButton.Text = '?'
	$HelpButton.UseVisualStyleBackColor = $True
	$HelpButton.add_Click($HelpButton_Click)
	#
	# button_GetUsers
	#
	$button_GetUsers.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$button_GetUsers.Location = New-Object System.Drawing.Point(470, 6)
	$button_GetUsers.Margin = '4, 4, 4, 4'
	$button_GetUsers.Name = 'button_GetUsers'
	$button_GetUsers.Size = New-Object System.Drawing.Size(113, 29)
	$button_GetUsers.TabIndex = 7
	$button_GetUsers.Text = 'Get Users'
	$button_GetUsers.UseCompatibleTextRendering = $True
	$button_GetUsers.UseVisualStyleBackColor = $True
	$button_GetUsers.add_Click($button_getusers_Click)
	#
	# labelSelectUser
	#
	$labelSelectUser.AutoSize = $True
	$labelSelectUser.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12', [System.Drawing.FontStyle]'Underline')
	$labelSelectUser.ForeColor = [System.Drawing.Color]::FloralWhite 
	$labelSelectUser.Location = New-Object System.Drawing.Point(5, 6)
	$labelSelectUser.Name = 'labelSelectUser'
	$labelSelectUser.Size = New-Object System.Drawing.Size(85, 24)
	$labelSelectUser.TabIndex = 80
	$labelSelectUser.Text = 'Select User'
	$labelSelectUser.TextAlign = 'TopRight'
	$labelSelectUser.UseCompatibleTextRendering = $True
	#
	# Panel_TargetPC
	#
	$Panel_TargetPC.Controls.Add($button2)
	$Panel_TargetPC.Controls.Add($button1)
	$Panel_TargetPC.Controls.Add($lb_migrationXMLS)
	$Panel_TargetPC.Controls.Add($lbl_migconfig)
	$Panel_TargetPC.Controls.Add($RadioRestore)
	$Panel_TargetPC.Controls.Add($RadioBackup)
	$Panel_TargetPC.Controls.Add($labelOFFLINE)
	$Panel_TargetPC.Controls.Add($labelTargetPC)
	$Panel_TargetPC.Controls.Add($txt_SourceComputer)
	$Panel_TargetPC.Controls.Add($labelSelectOperation)
	$Panel_TargetPC.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$Panel_TargetPC.Location = New-Object System.Drawing.Point(10, 93)
	$Panel_TargetPC.Name = 'Panel_TargetPC'
	$Panel_TargetPC.Size = New-Object System.Drawing.Size(689, 94)
	$Panel_TargetPC.TabIndex = 88
	#
	# button2
	#
	$button2.Location = New-Object System.Drawing.Point(652, 58)
	$button2.Name = 'button2'
	$button2.Size = New-Object System.Drawing.Size(34, 30)
	$button2.TabIndex = 110
	$button2.Text = '-'
	$button2.UseVisualStyleBackColor = $True
	$button2.add_Click($button2_Click)
	#
	# button1
	#
	$button1.Location = New-Object System.Drawing.Point(652, 27)
	$button1.Name = 'button1'
	$button1.Size = New-Object System.Drawing.Size(34, 30)
	$button1.TabIndex = 109
	$button1.Text = '+'
	$button1.UseVisualStyleBackColor = $True
	$button1.add_Click($button1_Click)
	#
	# lb_migrationXMLS
	#
	$lb_migrationXMLS.AllowDrop = $True
	$lb_migrationXMLS.BackColor = [System.Drawing.SystemColors]::ScrollBar 
	$lb_migrationXMLS.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '9.75')
	$lb_migrationXMLS.ItemHeight = 17
	[void]$lb_migrationXMLS.Items.Add('C:\windows\temp\usmtfiles\files.xml')
	[void]$lb_migrationXMLS.Items.Add('C:\windows\temp\usmtfiles\excludes.xml')
	$lb_migrationXMLS.Location = New-Object System.Drawing.Point(373, 33)
	$lb_migrationXMLS.Name = 'lb_migrationXMLS'
	$lb_migrationXMLS.Size = New-Object System.Drawing.Size(273, 55)
	$lb_migrationXMLS.TabIndex = 108
	$tooltip1.SetToolTip($lb_migrationXMLS, 'Provide the full path of xmls to include with migration')
	$lb_migrationXMLS.add_SelectedIndexChanged($lb_migrationXMLS_SelectedIndexChanged)
	#
	# lbl_migconfig
	#
	$lbl_migconfig.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12', [System.Drawing.FontStyle]'Underline')
	$lbl_migconfig.ForeColor = [System.Drawing.Color]::FloralWhite 
	$lbl_migconfig.Location = New-Object System.Drawing.Point(391, 4)
	$lbl_migconfig.Name = 'lbl_migconfig'
	$lbl_migconfig.Size = New-Object System.Drawing.Size(181, 24)
	$lbl_migconfig.TabIndex = 107
	$lbl_migconfig.Text = 'Migration XMLs'
	$lbl_migconfig.TextAlign = 'TopCenter'
	$lbl_migconfig.UseCompatibleTextRendering = $True
	#
	# RadioRestore
	#
	$RadioRestore.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$RadioRestore.ForeColor = [System.Drawing.Color]::FloralWhite 
	$RadioRestore.Location = New-Object System.Drawing.Point(257, 60)
	$RadioRestore.Name = 'RadioRestore'
	$RadioRestore.Size = New-Object System.Drawing.Size(128, 24)
	$RadioRestore.TabIndex = 6
	$RadioRestore.TabStop = $True
	$RadioRestore.Tag = 'operationselecttag'
	$RadioRestore.Text = 'Restore'
	$RadioRestore.UseVisualStyleBackColor = $True
	$RadioRestore.add_CheckedChanged($RadioRestore_CheckedChanged)
	#
	# RadioBackup
	#
	$RadioBackup.Checked = $True
	$RadioBackup.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$RadioBackup.ForeColor = [System.Drawing.Color]::FloralWhite 
	$RadioBackup.Location = New-Object System.Drawing.Point(148, 58)
	$RadioBackup.Name = 'RadioBackup'
	$RadioBackup.Size = New-Object System.Drawing.Size(91, 30)
	$RadioBackup.TabIndex = 5
	$RadioBackup.TabStop = $True
	$RadioBackup.Tag = 'operationselecttag'
	$RadioBackup.Text = 'Backup'
	$RadioBackup.TextAlign = 'MiddleCenter'
	$RadioBackup.UseCompatibleTextRendering = $True
	$RadioBackup.UseVisualStyleBackColor = $True
	$RadioBackup.add_CheckedChanged($RadioBackup_CheckedChanged)
	#
	# labelOFFLINE
	#
	$labelOFFLINE.AutoSize = $True
	$labelOFFLINE.BackColor = [System.Drawing.Color]::Transparent 
	$labelOFFLINE.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$labelOFFLINE.Location = New-Object System.Drawing.Point(499, 4)
	$labelOFFLINE.Name = 'labelOFFLINE'
	$labelOFFLINE.Size = New-Object System.Drawing.Size(0, 24)
	$labelOFFLINE.TabIndex = 2
	$labelOFFLINE.UseCompatibleTextRendering = $True
	$labelOFFLINE.Visible = $False
	#
	# labelTargetPC
	#
	$labelTargetPC.BackColor = [System.Drawing.Color]::Transparent 
	$labelTargetPC.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12', [System.Drawing.FontStyle]'Underline')
	$labelTargetPC.ForeColor = [System.Drawing.Color]::FloralWhite 
	$labelTargetPC.Location = New-Object System.Drawing.Point(5, 24)
	$labelTargetPC.Margin = '4, 0, 4, 0'
	$labelTargetPC.Name = 'labelTargetPC'
	$labelTargetPC.Size = New-Object System.Drawing.Size(83, 27)
	$labelTargetPC.TabIndex = 47
	$labelTargetPC.Text = '&Target PC'
	$labelTargetPC.UseCompatibleTextRendering = $True
	#
	# txt_SourceComputer
	#
	$txt_SourceComputer.BackColor = [System.Drawing.Color]::AliceBlue 
	$txt_SourceComputer.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$txt_SourceComputer.ImeMode = 'Off'
	$txt_SourceComputer.Location = New-Object System.Drawing.Point(98, 22)
	$txt_SourceComputer.Margin = '4, 4, 4, 4'
	$txt_SourceComputer.MaxLength = 85
	$txt_SourceComputer.Name = 'txt_SourceComputer'
	$txt_SourceComputer.Size = New-Object System.Drawing.Size(268, 25)
	$txt_SourceComputer.TabIndex = 4
	$tooltip1.SetToolTip($txt_SourceComputer, 'The PC you are wanting to backup.')
	$txt_SourceComputer.add_TextChanged($txt_SourceComputer_TextChanged)
	$txt_SourceComputer.add_Leave($button_getusers_Click)
	#
	# labelSelectOperation
	#
	$labelSelectOperation.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12', [System.Drawing.FontStyle]'Underline')
	$labelSelectOperation.ForeColor = [System.Drawing.Color]::FloralWhite 
	$labelSelectOperation.Location = New-Object System.Drawing.Point(5, 62)
	$labelSelectOperation.Name = 'labelSelectOperation'
	$labelSelectOperation.Size = New-Object System.Drawing.Size(123, 24)
	$labelSelectOperation.TabIndex = 67
	$labelSelectOperation.Text = 'Select Operation'
	$labelSelectOperation.UseCompatibleTextRendering = $True
	#
	# Panel_SelectOldPC
	#
	$Panel_SelectOldPC.Controls.Add($combo_selectOldPC)
	$Panel_SelectOldPC.Controls.Add($ButtonCheckAvailable)
	$Panel_SelectOldPC.Controls.Add($lbl_oldpc)
	$Panel_SelectOldPC.BorderStyle = 'FixedSingle'
	$Panel_SelectOldPC.Cursor = 'Default'
	$Panel_SelectOldPC.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$Panel_SelectOldPC.Location = New-Object System.Drawing.Point(10, 192)
	$Panel_SelectOldPC.Name = 'Panel_SelectOldPC'
	$Panel_SelectOldPC.Size = New-Object System.Drawing.Size(659, 45)
	$Panel_SelectOldPC.TabIndex = 110
	$Panel_SelectOldPC.Visible = $False
	#
	# combo_selectOldPC
	#
	[void]$combo_selectOldPC.AutoCompleteCustomSource.Add('Old Pc Name')
	$combo_selectOldPC.BackColor = [System.Drawing.Color]::AliceBlue 
	$combo_selectOldPC.DisplayMember = 'Old Pc Name'
	$combo_selectOldPC.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	[void]$combo_selectOldPC.Items.Add('Old PC Name')
	$combo_selectOldPC.Location = New-Object System.Drawing.Point(147, 11)
	$combo_selectOldPC.Margin = '4, 4, 4, 4'
	$combo_selectOldPC.MaxLength = 50
	$combo_selectOldPC.Name = 'combo_selectOldPC'
	$combo_selectOldPC.Size = New-Object System.Drawing.Size(251, 28)
	$combo_selectOldPC.Sorted = $True
	$combo_selectOldPC.TabIndex = 6
	$combo_selectOldPC.TabStop = $False
	$combo_selectOldPC.ValueMember = 'Old Pc Name'
	$combo_selectOldPC.add_SelectedIndexChanged($combo_selectOldPC_SelectedIndexChanged)
	#
	# ButtonCheckAvailable
	#
	$ButtonCheckAvailable.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$ButtonCheckAvailable.Location = New-Object System.Drawing.Point(415, 10)
	$ButtonCheckAvailable.Margin = '4, 4, 4, 4'
	$ButtonCheckAvailable.Name = 'ButtonCheckAvailable'
	$ButtonCheckAvailable.Size = New-Object System.Drawing.Size(172, 29)
	$ButtonCheckAvailable.TabIndex = 0
	$ButtonCheckAvailable.TabStop = $False
	$ButtonCheckAvailable.Text = 'Get Profiles Available'
	$ButtonCheckAvailable.UseCompatibleTextRendering = $True
	$ButtonCheckAvailable.UseVisualStyleBackColor = $True
	$ButtonCheckAvailable.add_Click($ButtonCheckAvailable_Click)
	#
	# lbl_oldpc
	#
	$lbl_oldpc.AutoSize = $True
	$lbl_oldpc.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$lbl_oldpc.ForeColor = [System.Drawing.Color]::FloralWhite 
	$lbl_oldpc.Location = New-Object System.Drawing.Point(2, 13)
	$lbl_oldpc.Name = 'lbl_oldpc'
	$lbl_oldpc.Size = New-Object System.Drawing.Size(101, 24)
	$lbl_oldpc.TabIndex = 80
	$lbl_oldpc.Text = 'Select Old PC'
	$lbl_oldpc.TextAlign = 'TopRight'
	$lbl_oldpc.UseCompatibleTextRendering = $True
	#
	# panel_Shares
	#
	$panel_Shares.Controls.Add($buttonSources)
	$panel_Shares.Controls.Add($txt_usmtfile)
	$panel_Shares.Controls.Add($button_proselect)
	$panel_Shares.Controls.Add($label_usmtsource)
	$panel_Shares.Controls.Add($labelProfilePath)
	$panel_Shares.Controls.Add($txt_proselect)
	$panel_Shares.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$panel_Shares.Location = New-Object System.Drawing.Point(11, 5)
	$panel_Shares.Name = 'panel_Shares'
	$panel_Shares.Size = New-Object System.Drawing.Size(658, 106)
	$panel_Shares.TabIndex = 1
	#
	# buttonSources
	#
	$buttonSources.BackColor = [System.Drawing.Color]::Transparent 
	$buttonSources.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$buttonSources.Location = New-Object System.Drawing.Point(621, 6)
	$buttonSources.Name = 'buttonSources'
	$buttonSources.Size = New-Object System.Drawing.Size(34, 31)
	$buttonSources.TabIndex = 1
	$buttonSources.Text = '..'
	$buttonSources.UseVisualStyleBackColor = $False
	$buttonSources.add_Click($buttonSources_Click)
	#
	# txt_usmtfile
	#
	[void]$txt_usmtfile.AutoCompleteCustomSource.Add('usmtfiles.zip')
	$txt_usmtfile.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$txt_usmtfile.Location = New-Object System.Drawing.Point(108, 9)
	$txt_usmtfile.Margin = '4, 4, 4, 4'
	$txt_usmtfile.Name = 'txt_usmtfile'
	$helpprovider1.SetShowHelp($txt_usmtfile, $True)
	$txt_usmtfile.Size = New-Object System.Drawing.Size(509, 25)
	$txt_usmtfile.TabIndex = 0
	$tooltip1.SetToolTip($txt_usmtfile, 'This is where all your USMT source files are located.  Such as, 
Scanstate.exe and loadstate.exe.  Most likely a network location.
Do not enter a drive letter here, use a UNC path such as
\\myserver\myshare\myusmtfiles')
	$txt_usmtfile.add_Validating($txt_usmtfile_Validated)
	$txt_usmtfile.add_Validated($txt_usmtfile_Validated)
	#
	# button_proselect
	#
	$button_proselect.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$button_proselect.Location = New-Object System.Drawing.Point(621, 44)
	$button_proselect.Margin = '4, 4, 4, 4'
	$button_proselect.Name = 'button_proselect'
	$button_proselect.Size = New-Object System.Drawing.Size(34, 28)
	$button_proselect.TabIndex = 3
	$button_proselect.Text = '..'
	$button_proselect.UseVisualStyleBackColor = $True
	$button_proselect.add_Click($button_proselect_Click)
	#
	# label_usmtsource
	#
	$label_usmtsource.BackColor = [System.Drawing.Color]::Transparent 
	$label_usmtsource.BorderStyle = 'FixedSingle'
	$label_usmtsource.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12', [System.Drawing.FontStyle]'Underline')
	$label_usmtsource.ForeColor = [System.Drawing.Color]::FloralWhite 
	$label_usmtsource.Location = New-Object System.Drawing.Point(3, 10)
	$label_usmtsource.Margin = '4, 0, 4, 0'
	$label_usmtsource.Name = 'label_usmtsource'
	$label_usmtsource.Size = New-Object System.Drawing.Size(107, 27)
	$label_usmtsource.TabIndex = 1
	$label_usmtsource.Text = 'USMT Source'
	$label_usmtsource.UseCompatibleTextRendering = $True
	#
	# labelProfilePath
	#
	$labelProfilePath.BackColor = [System.Drawing.Color]::Transparent 
	$labelProfilePath.BorderStyle = 'FixedSingle'
	$labelProfilePath.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12', [System.Drawing.FontStyle]'Underline')
	$labelProfilePath.ForeColor = [System.Drawing.Color]::FloralWhite 
	$labelProfilePath.Location = New-Object System.Drawing.Point(3, 43)
	$labelProfilePath.Margin = '4, 0, 4, 0'
	$labelProfilePath.Name = 'labelProfilePath'
	$labelProfilePath.Size = New-Object System.Drawing.Size(98, 27)
	$labelProfilePath.TabIndex = 89
	$labelProfilePath.Text = 'Profile Path'
	$labelProfilePath.UseCompatibleTextRendering = $True
	#
	# txt_proselect
	#
	$txt_proselect.AccessibleRole = 'None'
	$txt_proselect.Cursor = 'IBeam'
	$txt_proselect.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$txt_proselect.HideSelection = $False
	$txt_proselect.Location = New-Object System.Drawing.Point(108, 45)
	$txt_proselect.Name = 'txt_proselect'
	$txt_proselect.Size = New-Object System.Drawing.Size(509, 25)
	$txt_proselect.TabIndex = 2
	$tooltip1.SetToolTip($txt_proselect, "This is where the profile is located for restore, or where you wish 
it to be backed up to.  It will be backed up to this location in a 
folder created based on the name of the computer.

You can backup the pc to their local computer by setting this 
to a local path.  IE C:\store.  Make sure your backup location has 
the correct permissions assigned to it.  The Domain Computers 
account should have at least write access to folders it creates
and read access to any files you are going to restore.  Domain
computers have a user account named ""domain\computer$"".")
	#
	# panel_noShares
	#
	$panel_noShares.Controls.Add($btn_noSharesUSMT)
	$panel_noShares.Controls.Add($txt_localusmtfiles)
	$panel_noShares.Controls.Add($btn_nosharesMig)
	$panel_noShares.Controls.Add($labelLocalUSMTFilesPath)
	$panel_noShares.Controls.Add($labelLocalUSMTmigFile)
	$panel_noShares.Controls.Add($txt_localmigfile)
	$panel_noShares.Location = New-Object System.Drawing.Point(5, 8)
	$panel_noShares.Name = 'panel_noShares'
	$panel_noShares.Size = New-Object System.Drawing.Size(664, 106)
	$panel_noShares.TabIndex = 91
	$panel_noShares.Visible = $False
	#
	# btn_noSharesUSMT
	#
	$btn_noSharesUSMT.BackColor = [System.Drawing.Color]::Transparent 
	$btn_noSharesUSMT.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$btn_noSharesUSMT.Location = New-Object System.Drawing.Point(621, 3)
	$btn_noSharesUSMT.Name = 'btn_noSharesUSMT'
	$btn_noSharesUSMT.Size = New-Object System.Drawing.Size(34, 31)
	$btn_noSharesUSMT.TabIndex = 91
	$btn_noSharesUSMT.Text = '..'
	$btn_noSharesUSMT.UseVisualStyleBackColor = $False
	$btn_noSharesUSMT.add_Click($btn_noSharesUSMT_Click)
	#
	# txt_localusmtfiles
	#
	[void]$txt_localusmtfiles.AutoCompleteCustomSource.Add('usmtfiles.zip')
	$txt_localusmtfiles.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$txt_localusmtfiles.Location = New-Object System.Drawing.Point(209, 6)
	$txt_localusmtfiles.Margin = '4, 4, 4, 4'
	$txt_localusmtfiles.Name = 'txt_localusmtfiles'
	$txt_localusmtfiles.Size = New-Object System.Drawing.Size(408, 25)
	$txt_localusmtfiles.TabIndex = 90
	#
	# btn_nosharesMig
	#
	$btn_nosharesMig.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$btn_nosharesMig.Location = New-Object System.Drawing.Point(620, 40)
	$btn_nosharesMig.Margin = '4, 4, 4, 4'
	$btn_nosharesMig.Name = 'btn_nosharesMig'
	$btn_nosharesMig.Size = New-Object System.Drawing.Size(34, 28)
	$btn_nosharesMig.TabIndex = 94
	$btn_nosharesMig.Text = '..'
	$btn_nosharesMig.UseVisualStyleBackColor = $True
	$btn_nosharesMig.add_Click($btn_nosharesMig_Click)
	#
	# labelLocalUSMTFilesPath
	#
	$labelLocalUSMTFilesPath.BackColor = [System.Drawing.Color]::Transparent 
	$labelLocalUSMTFilesPath.BorderStyle = 'FixedSingle'
	$labelLocalUSMTFilesPath.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12', [System.Drawing.FontStyle]'Underline')
	$labelLocalUSMTFilesPath.ForeColor = [System.Drawing.Color]::FloralWhite 
	$labelLocalUSMTFilesPath.Location = New-Object System.Drawing.Point(3, 7)
	$labelLocalUSMTFilesPath.Margin = '4, 0, 4, 0'
	$labelLocalUSMTFilesPath.Name = 'labelLocalUSMTFilesPath'
	$labelLocalUSMTFilesPath.Size = New-Object System.Drawing.Size(186, 27)
	$labelLocalUSMTFilesPath.TabIndex = 92
	$labelLocalUSMTFilesPath.Text = 'Local USMT Files Path'
	$labelLocalUSMTFilesPath.UseCompatibleTextRendering = $True
	#
	# labelLocalUSMTmigFile
	#
	$labelLocalUSMTmigFile.BackColor = [System.Drawing.Color]::Transparent 
	$labelLocalUSMTmigFile.BorderStyle = 'FixedSingle'
	$labelLocalUSMTmigFile.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12', [System.Drawing.FontStyle]'Underline')
	$labelLocalUSMTmigFile.ForeColor = [System.Drawing.Color]::FloralWhite 
	$labelLocalUSMTmigFile.Location = New-Object System.Drawing.Point(3, 40)
	$labelLocalUSMTmigFile.Margin = '4, 0, 4, 0'
	$labelLocalUSMTmigFile.Name = 'labelLocalUSMTmigFile'
	$labelLocalUSMTmigFile.Size = New-Object System.Drawing.Size(186, 27)
	$labelLocalUSMTmigFile.TabIndex = 95
	$labelLocalUSMTmigFile.Text = 'Local USMT.mig File'
	$labelLocalUSMTmigFile.UseCompatibleTextRendering = $True
	#
	# txt_localmigfile
	#
	$txt_localmigfile.AccessibleRole = 'None'
	$txt_localmigfile.Cursor = 'IBeam'
	$txt_localmigfile.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$txt_localmigfile.HideSelection = $False
	$txt_localmigfile.Location = New-Object System.Drawing.Point(209, 42)
	$txt_localmigfile.Name = 'txt_localmigfile'
	$txt_localmigfile.Size = New-Object System.Drawing.Size(408, 25)
	$txt_localmigfile.TabIndex = 93
	$txt_localmigfile.Text = 'This is needed for Restore'
	#
	# labelOldPCName
	#
	$labelOldPCName.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12', [System.Drawing.FontStyle]'Underline')
	$labelOldPCName.ForeColor = [System.Drawing.Color]::FloralWhite 
	$labelOldPCName.Location = New-Object System.Drawing.Point(10, 319)
	$labelOldPCName.Name = 'labelOldPCName'
	$labelOldPCName.Size = New-Object System.Drawing.Size(169, 23)
	$labelOldPCName.TabIndex = 105
	$labelOldPCName.Text = 'USMT Command Args'
	$labelOldPCName.TextAlign = 'MiddleLeft'
	$labelOldPCName.UseCompatibleTextRendering = $True
	#
	# buttonAbout
	#
	$buttonAbout.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$buttonAbout.Location = New-Object System.Drawing.Point(2, 1)
	$buttonAbout.Margin = '4, 4, 4, 4'
	$buttonAbout.Name = 'buttonAbout'
	$buttonAbout.Size = New-Object System.Drawing.Size(98, 27)
	$buttonAbout.TabIndex = 110
	$buttonAbout.TabStop = $False
	$buttonAbout.Text = 'About'
	$buttonAbout.UseCompatibleTextRendering = $True
	$buttonAbout.UseVisualStyleBackColor = $True
	$buttonAbout.add_Click($buttonAbout_Click)
	#
	# txt_usmtString
	#
	$txt_usmtString.BackColor = [System.Drawing.Color]::AliceBlue 
	$txt_usmtString.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$txt_usmtString.HideSelection = $False
	$txt_usmtString.ImeMode = 'Off'
	$txt_usmtString.Location = New-Object System.Drawing.Point(12, 345)
	$txt_usmtString.Name = 'txt_usmtString'
	$txt_usmtString.Size = New-Object System.Drawing.Size(562, 25)
	$txt_usmtString.TabIndex = 14
	$txt_usmtString.TabStop = $False
	$txt_usmtString.Text = ' /ui: /progress:C:\Windows\Temp\usmtfiles\backup.log /encrypt:AES_192 /l:C:\windows\temp\usmtfiles\scanstate.log /ue:* /o /localonly /c /key: /i:C:\windows\temp\usmtfiles\files.xml /i:C:\windows\temp\usmtfiles\excludes.xml'
	$tooltip1.SetToolTip($txt_usmtString, 'This exact string will be sent as the migration string.
Manually editing this is not supported.')
	$txt_usmtString.WordWrap = $False
	$txt_usmtString.add_Enter($txt_usmtString_Enter)
	$txt_usmtString.add_Leave($txt_usmtString_Leave)
	#
	# labelX
	#
	$labelX.Anchor = 'Top, Right'
	$labelX.AutoSize = $True
	$labelX.Cursor = 'Hand'
	$labelX.FlatStyle = 'System'
	$labelX.Font = [System.Drawing.Font]::new('Wingdings', '48')
	$labelX.ForeColor = [System.Drawing.Color]::Tomato 
	$labelX.Location = New-Object System.Drawing.Point(724, 151)
	$labelX.Name = 'labelX'
	$labelX.Size = New-Object System.Drawing.Size(98, 71)
	$labelX.TabIndex = 0
	$labelX.Text = 'x'
	$labelX.add_Click($labelX_Click)
	#
	# txt_keyItem
	#
	$txt_keyItem.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$txt_keyItem.Location = New-Object System.Drawing.Point(580, 314)
	$txt_keyItem.Name = 'txt_keyItem'
	$txt_keyItem.Size = New-Object System.Drawing.Size(234, 25)
	$txt_keyItem.TabIndex = 13
	$txt_keyItem.TabStop = $False
	$txt_keyItem.Text = ')(JGj9ergjwJGSIjgsE83w-39t'
	$tooltip1.SetToolTip($txt_keyItem, 'This is the key used to encrypt the profile.  This should be unique
to your backups and losing this key would render these backups
useless.

These keys will be stored in your history next to the migration.
Upon restore, if you use the history panel, it will automatically
fill in the associated fields including this one.')
	$txt_keyItem.add_TextChanged($txt_keyItem_TextChanged)
	#
	# lbl_operationSelection
	#
	$lbl_operationSelection.BackColor = [System.Drawing.Color]::Gray 
	$lbl_operationSelection.BorderStyle = 'Fixed3D'
	$lbl_operationSelection.FlatStyle = 'Flat'
	$lbl_operationSelection.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$lbl_operationSelection.ForeColor = [System.Drawing.Color]::Orange 
	$lbl_operationSelection.Location = New-Object System.Drawing.Point(264, 313)
	$lbl_operationSelection.Name = 'lbl_operationSelection'
	$lbl_operationSelection.Size = New-Object System.Drawing.Size(214, 26)
	$lbl_operationSelection.TabIndex = 105
	$lbl_operationSelection.Text = 'Operation = Backup'
	$lbl_operationSelection.TextAlign = 'MiddleCenter'
	#
	# labelEncryptionKey
	#
	$labelEncryptionKey.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12', [System.Drawing.FontStyle]'Underline')
	$labelEncryptionKey.ForeColor = [System.Drawing.Color]::FloralWhite 
	$labelEncryptionKey.Location = New-Object System.Drawing.Point(704, 289)
	$labelEncryptionKey.Name = 'labelEncryptionKey'
	$labelEncryptionKey.Size = New-Object System.Drawing.Size(118, 24)
	$labelEncryptionKey.TabIndex = 94
	$labelEncryptionKey.Text = 'Encryption Key'
	$labelEncryptionKey.UseCompatibleTextRendering = $True
	#
	# label202
	#
	$label202.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$label202.ForeColor = [System.Drawing.Color]::Gold 
	$label202.Location = New-Object System.Drawing.Point(537, 39)
	$label202.Name = 'label202'
	$label202.Size = New-Object System.Drawing.Size(63, 15)
	$label202.TabIndex = 3
	$label202.Text = '2.0.2'
	$label202.TextAlign = 'MiddleCenter'
	$label202.UseCompatibleTextRendering = $True
	#
	# labelMultipleJobsDisabled
	#
	$labelMultipleJobsDisabled.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$labelMultipleJobsDisabled.ForeColor = [System.Drawing.Color]::Orange 
	$labelMultipleJobsDisabled.LiveSetting = 'Assertive'
	$labelMultipleJobsDisabled.Location = New-Object System.Drawing.Point(537, 685)
	$labelMultipleJobsDisabled.Name = 'labelMultipleJobsDisabled'
	$labelMultipleJobsDisabled.Size = New-Object System.Drawing.Size(187, 26)
	$labelMultipleJobsDisabled.TabIndex = 109
	$labelMultipleJobsDisabled.Text = 'Multiple Jobs Disabled'
	$labelMultipleJobsDisabled.TextAlign = 'MiddleCenter'
	$labelMultipleJobsDisabled.Visible = $False
	#
	# buttonShowHistory
	#
	$buttonShowHistory.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$buttonShowHistory.Location = New-Object System.Drawing.Point(736, 663)
	$buttonShowHistory.Margin = '4, 4, 4, 4'
	$buttonShowHistory.Name = 'buttonShowHistory'
	$buttonShowHistory.Size = New-Object System.Drawing.Size(83, 48)
	$buttonShowHistory.TabIndex = 14
	$buttonShowHistory.TabStop = $False
	$buttonShowHistory.Text = 'Show History'
	$buttonShowHistory.UseCompatibleTextRendering = $True
	$buttonShowHistory.UseVisualStyleBackColor = $True
	$buttonShowHistory.add_Click($buttonShowHistory_Click)
	#
	# checkboxVerboseLogging
	#
	$checkboxVerboseLogging.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25', [System.Drawing.FontStyle]'Underline')
	$checkboxVerboseLogging.ImageAlign = 'BottomCenter'
	$checkboxVerboseLogging.Location = New-Object System.Drawing.Point(528, 661)
	$checkboxVerboseLogging.Name = 'checkboxVerboseLogging'
	$checkboxVerboseLogging.Size = New-Object System.Drawing.Size(194, 28)
	$checkboxVerboseLogging.TabIndex = 8
	$checkboxVerboseLogging.Text = 'Verbose Logging'
	$checkboxVerboseLogging.TextAlign = 'MiddleCenter'
	$tooltip1.SetToolTip($checkboxVerboseLogging, 'this can cause significant lag due to scrolling
text.  I wouldnt use this if you dont plan to wait
for each migration to finish.')
	$checkboxVerboseLogging.UseVisualStyleBackColor = $True
	$checkboxVerboseLogging.add_CheckedChanged($checkboxVerboseLogging_CheckedChanged)
	#
	# buttonshowC
	#
	$buttonshowC.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$buttonshowC.Location = New-Object System.Drawing.Point(534, 740)
	$buttonshowC.Margin = '4, 4, 4, 4'
	$buttonshowC.Name = 'buttonshowC'
	$buttonshowC.Size = New-Object System.Drawing.Size(99, 27)
	$buttonshowC.TabIndex = 103
	$buttonshowC.TabStop = $False
	$buttonshowC.Text = "Show C$"
	$buttonshowC.UseCompatibleTextRendering = $True
	$buttonshowC.UseVisualStyleBackColor = $True
	$buttonshowC.add_Click($buttonshowC_Click)
	#
	# DGV_jobstatus
	#
	$DGV_jobstatus.AllowUserToAddRows = $False
	$DGV_jobstatus.AllowUserToDeleteRows = $False
	$System_Windows_Forms_DataGridViewCellStyle_1 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_1.Font = [System.Drawing.Font]::new('Calibri', '8.25', [System.Drawing.FontStyle]'Bold')
	$DGV_jobstatus.AlternatingRowsDefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_1
	$DGV_jobstatus.AutoSizeColumnsMode = 'ColumnHeader'
	$DGV_jobstatus.AutoSizeRowsMode = 'DisplayedCells'
	$DGV_jobstatus.ColumnHeadersHeightSizeMode = 'AutoSize'
	[void]$DGV_jobstatus.Columns.Add($num)
	[void]$DGV_jobstatus.Columns.Add($JobName)
	[void]$DGV_jobstatus.Columns.Add($State)
	[void]$DGV_jobstatus.Columns.Add($jobStart)
	[void]$DGV_jobstatus.Columns.Add($JobEnd)
	[void]$DGV_jobstatus.Columns.Add($result)
	[void]$DGV_jobstatus.Columns.Add($Cancel)
	$System_Windows_Forms_DataGridViewCellStyle_2 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_2.Alignment = 'MiddleCenter'
	$System_Windows_Forms_DataGridViewCellStyle_2.BackColor = [System.Drawing.SystemColors]::Window 
	$System_Windows_Forms_DataGridViewCellStyle_2.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$System_Windows_Forms_DataGridViewCellStyle_2.ForeColor = [System.Drawing.SystemColors]::ControlText 
	$System_Windows_Forms_DataGridViewCellStyle_2.SelectionBackColor = [System.Drawing.SystemColors]::Highlight 
	$System_Windows_Forms_DataGridViewCellStyle_2.SelectionForeColor = [System.Drawing.SystemColors]::HighlightText 
	$System_Windows_Forms_DataGridViewCellStyle_2.WrapMode = 'False'
	$DGV_jobstatus.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_2
	$DGV_jobstatus.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$DGV_jobstatus.Location = New-Object System.Drawing.Point(8, 661)
	$DGV_jobstatus.Name = 'DGV_jobstatus'
	$System_Windows_Forms_DataGridViewCellStyle_3 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_3.Alignment = 'MiddleLeft'
	$System_Windows_Forms_DataGridViewCellStyle_3.BackColor = [System.Drawing.SystemColors]::Control 
	$System_Windows_Forms_DataGridViewCellStyle_3.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$System_Windows_Forms_DataGridViewCellStyle_3.ForeColor = [System.Drawing.SystemColors]::WindowText 
	$System_Windows_Forms_DataGridViewCellStyle_3.SelectionBackColor = [System.Drawing.SystemColors]::Highlight 
	$System_Windows_Forms_DataGridViewCellStyle_3.SelectionForeColor = [System.Drawing.SystemColors]::HighlightText 
	$System_Windows_Forms_DataGridViewCellStyle_3.WrapMode = 'True'
	$DGV_jobstatus.RowHeadersDefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_3
	$DGV_jobstatus.RowHeadersVisible = $False
	$DGV_jobstatus.RowHeadersWidthSizeMode = 'AutoSizeToDisplayedHeaders'
	$System_Windows_Forms_DataGridViewCellStyle_4 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_4.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '9.75')
	$DGV_jobstatus.RowsDefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_4
	$DGV_jobstatus.RowTemplate.DefaultCellStyle.BackColor = [System.Drawing.Color]::LightGray 
	$DGV_jobstatus.RowTemplate.DefaultCellStyle.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '8.25')
	$DGV_jobstatus.RowTemplate.DefaultCellStyle.ForeColor = [System.Drawing.Color]::Black 
	$DGV_jobstatus.RowTemplate.DefaultCellStyle.SelectionBackColor = [System.Drawing.Color]::LightYellow 
	$DGV_jobstatus.RowTemplate.DefaultCellStyle.SelectionForeColor = [System.Drawing.Color]::DarkCyan 
	$DGV_jobstatus.RowTemplate.Height = 25
	$DGV_jobstatus.ShowCellErrors = $False
	$DGV_jobstatus.ShowCellToolTips = $False
	$DGV_jobstatus.ShowEditingIcon = $False
	$DGV_jobstatus.ShowRowErrors = $False
	$DGV_jobstatus.Size = New-Object System.Drawing.Size(509, 106)
	$DGV_jobstatus.StandardTab = $True
	$DGV_jobstatus.TabIndex = 108
	$DGV_jobstatus.TabStop = $False
	$tooltip1.SetToolTip($DGV_jobstatus, 'You can click the job name and it will open up the operational log file for that particular job.

Clicking Cancel will attempt to cancel a job that is already in progress.  This should kill the
local job and end any file transfers that may be taking place.  This will only work if you still
have connectivity to the remote host.  ')
	$DGV_jobstatus.add_CellContentClick($DGV_jobstatus_CellContentClick)
	#
	# buttonCMTraceLog
	#
	$buttonCMTraceLog.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$buttonCMTraceLog.Location = New-Object System.Drawing.Point(534, 715)
	$buttonCMTraceLog.Margin = '4, 4, 4, 4'
	$buttonCMTraceLog.Name = 'buttonCMTraceLog'
	$buttonCMTraceLog.Size = New-Object System.Drawing.Size(99, 27)
	$buttonCMTraceLog.TabIndex = 102
	$buttonCMTraceLog.TabStop = $False
	$buttonCMTraceLog.Text = 'CMtrace'
	$buttonCMTraceLog.UseCompatibleTextRendering = $True
	$buttonCMTraceLog.UseVisualStyleBackColor = $True
	$buttonCMTraceLog.add_Click($buttonCMTraceLog_Click)
	#
	# buttonQuit
	#
	$buttonQuit.Anchor = 'Bottom, Right'
	$buttonQuit.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$buttonQuit.Location = New-Object System.Drawing.Point(641, 718)
	$buttonQuit.Margin = '4, 4, 4, 4'
	$buttonQuit.Name = 'buttonQuit'
	$buttonQuit.Size = New-Object System.Drawing.Size(88, 44)
	$buttonQuit.TabIndex = 11
	$buttonQuit.TabStop = $False
	$buttonQuit.Text = 'Quit'
	$buttonQuit.UseVisualStyleBackColor = $True
	$buttonQuit.add_Click($buttonQuit_Click)
	$buttonQuit.add_MouseClick($buttonQuit_Click)
	#
	# button_begin
	#
	$button_begin.Anchor = 'Bottom, Right'
	$button_begin.Enabled = $False
	$button_begin.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$button_begin.ForeColor = [System.Drawing.Color]::Crimson 
	$button_begin.Location = New-Object System.Drawing.Point(736, 718)
	$button_begin.Name = 'button_begin'
	$button_begin.Size = New-Object System.Drawing.Size(83, 46)
	$button_begin.TabIndex = 9
	$button_begin.Text = 'Begin'
	$button_begin.UseVisualStyleBackColor = $True
	$button_begin.add_Click($button_begin_Click)
	#
	# panel_batchBox
	#
	$panel_batchBox.Controls.Add($buttonGoBackSingle)
	$panel_batchBox.Controls.Add($RadioBatchRestore)
	$panel_batchBox.Controls.Add($RadioBatchBackup)
	$panel_batchBox.Controls.Add($labelCsvWillLoadHere)
	$panel_batchBox.Controls.Add($labelOldPCAndNewPCRelates)
	$panel_batchBox.Controls.Add($labelRunMigrationProcedur)
	$panel_batchBox.Controls.Add($labelTheCSVMustContainOld)
	$panel_batchBox.Controls.Add($buttonRunBatch)
	$panel_batchBox.Controls.Add($datagridview1)
	$panel_batchBox.BackColor = [System.Drawing.Color]::DimGray 
	$panel_batchBox.BackgroundImageLayout = 'None'
	$panel_batchBox.FlatStyle = 'System'
	$panel_batchBox.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$panel_batchBox.Location = New-Object System.Drawing.Point(2, 86)
	$panel_batchBox.Margin = '0, 0, 0, 0'
	$panel_batchBox.Name = 'panel_batchBox'
	$panel_batchBox.Padding = '0, 0, 0, 0'
	$panel_batchBox.Size = New-Object System.Drawing.Size(659, 209)
	$panel_batchBox.TabIndex = 102
	$panel_batchBox.TabStop = $False
	$panel_batchBox.Visible = $False
	#
	# buttonGoBackSingle
	#
	$buttonGoBackSingle.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$buttonGoBackSingle.Location = New-Object System.Drawing.Point(628, 195)
	$buttonGoBackSingle.Margin = '4, 4, 4, 4'
	$buttonGoBackSingle.Name = 'buttonGoBackSingle'
	$buttonGoBackSingle.Size = New-Object System.Drawing.Size(116, 32)
	$buttonGoBackSingle.TabIndex = 0
	$buttonGoBackSingle.TabStop = $False
	$buttonGoBackSingle.UseVisualStyleBackColor = $True
	#
	# RadioBatchRestore
	#
	$RadioBatchRestore.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$RadioBatchRestore.ForeColor = [System.Drawing.Color]::Coral 
	$RadioBatchRestore.Location = New-Object System.Drawing.Point(408, 204)
	$RadioBatchRestore.Margin = '4, 4, 4, 4'
	$RadioBatchRestore.Name = 'RadioBatchRestore'
	$RadioBatchRestore.Size = New-Object System.Drawing.Size(139, 33)
	$RadioBatchRestore.TabIndex = 13
	$RadioBatchRestore.Tag = 'radio'
	$RadioBatchRestore.Text = 'Restore'
	$RadioBatchRestore.UseVisualStyleBackColor = $True
	#
	# RadioBatchBackup
	#
	$RadioBatchBackup.Checked = $True
	$RadioBatchBackup.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$RadioBatchBackup.ForeColor = [System.Drawing.Color]::Coral 
	$RadioBatchBackup.Location = New-Object System.Drawing.Point(408, 248)
	$RadioBatchBackup.Margin = '4, 4, 4, 4'
	$RadioBatchBackup.Name = 'RadioBatchBackup'
	$RadioBatchBackup.Size = New-Object System.Drawing.Size(139, 33)
	$RadioBatchBackup.TabIndex = 12
	$RadioBatchBackup.TabStop = $True
	$RadioBatchBackup.Tag = 'radio'
	$RadioBatchBackup.Text = 'Backup'
	$RadioBatchBackup.UseVisualStyleBackColor = $True
	#
	# labelCsvWillLoadHere
	#
	$labelCsvWillLoadHere.AutoSize = $True
	$labelCsvWillLoadHere.BackColor = [System.Drawing.Color]::White 
	$labelCsvWillLoadHere.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$labelCsvWillLoadHere.Location = New-Object System.Drawing.Point(403, 101)
	$labelCsvWillLoadHere.Margin = '4, 0, 4, 0'
	$labelCsvWillLoadHere.Name = 'labelCsvWillLoadHere'
	$labelCsvWillLoadHere.Size = New-Object System.Drawing.Size(153, 21)
	$labelCsvWillLoadHere.TabIndex = 1
	$labelCsvWillLoadHere.Text = '<--- Csv will load here'
	#
	# labelOldPCAndNewPCRelates
	#
	$labelOldPCAndNewPCRelates.AutoSize = $True
	$labelOldPCAndNewPCRelates.BackColor = [System.Drawing.Color]::White 
	$labelOldPCAndNewPCRelates.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$labelOldPCAndNewPCRelates.Location = New-Object System.Drawing.Point(18, 41)
	$labelOldPCAndNewPCRelates.Margin = '4, 0, 4, 0'
	$labelOldPCAndNewPCRelates.Name = 'labelOldPCAndNewPCRelates'
	$labelOldPCAndNewPCRelates.Size = New-Object System.Drawing.Size(299, 21)
	$labelOldPCAndNewPCRelates.TabIndex = 10
	$labelOldPCAndNewPCRelates.Text = 'oldPC and newPC relates to the Hostname'
	#
	# labelRunMigrationProcedur
	#
	$labelRunMigrationProcedur.AutoSize = $True
	$labelRunMigrationProcedur.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$labelRunMigrationProcedur.ForeColor = [System.Drawing.Color]::Cyan 
	$labelRunMigrationProcedur.Location = New-Object System.Drawing.Point(401, 74)
	$labelRunMigrationProcedur.Margin = '4, 0, 4, 0'
	$labelRunMigrationProcedur.Name = 'labelRunMigrationProcedur'
	$labelRunMigrationProcedur.Size = New-Object System.Drawing.Size(345, 21)
	$labelRunMigrationProcedur.TabIndex = 0
	$labelRunMigrationProcedur.Text = 'Run Migration Procedures on a CSV of computers'
	#
	# labelTheCSVMustContainOld
	#
	$labelTheCSVMustContainOld.AutoSize = $True
	$labelTheCSVMustContainOld.BackColor = [System.Drawing.Color]::White 
	$labelTheCSVMustContainOld.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '12')
	$labelTheCSVMustContainOld.Location = New-Object System.Drawing.Point(4, 14)
	$labelTheCSVMustContainOld.Margin = '4, 0, 4, 0'
	$labelTheCSVMustContainOld.Name = 'labelTheCSVMustContainOld'
	$labelTheCSVMustContainOld.Size = New-Object System.Drawing.Size(382, 21)
	$labelTheCSVMustContainOld.TabIndex = 9
	$labelTheCSVMustContainOld.Text = 'The CSV must contain oldpc, email, newpc as columns'
	#
	# buttonRunBatch
	#
	$buttonRunBatch.BackColor = [System.Drawing.Color]::WhiteSmoke 
	$buttonRunBatch.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$buttonRunBatch.Location = New-Object System.Drawing.Point(578, 247)
	$buttonRunBatch.Name = 'buttonRunBatch'
	$buttonRunBatch.Size = New-Object System.Drawing.Size(172, 50)
	$buttonRunBatch.TabIndex = 5
	$buttonRunBatch.TabStop = $False
	$buttonRunBatch.UseVisualStyleBackColor = $False
	#
	# datagridview1
	#
	$datagridview1.AllowDrop = $True
	$datagridview1.AllowUserToOrderColumns = $True
	$datagridview1.ColumnHeadersHeightSizeMode = 'AutoSize'
	$datagridview1.EditMode = 'EditOnEnter'
	$datagridview1.Location = New-Object System.Drawing.Point(10, 74)
	$datagridview1.Name = 'datagridview1'
	$datagridview1.RowHeadersWidthSizeMode = 'AutoSizeToAllHeaders'
	$datagridview1.Size = New-Object System.Drawing.Size(385, 224)
	$datagridview1.TabIndex = 0
	$datagridview1.TabStop = $False
	#
	# labelUSMTRemoteMigrationG
	#
	$labelUSMTRemoteMigrationG.AutoSize = $True
	$labelUSMTRemoteMigrationG.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '21.75')
	$labelUSMTRemoteMigrationG.ForeColor = [System.Drawing.Color]::Orange 
	$labelUSMTRemoteMigrationG.ImageAlign = 'TopCenter'
	$labelUSMTRemoteMigrationG.Location = New-Object System.Drawing.Point(184, 1)
	$labelUSMTRemoteMigrationG.Name = 'labelUSMTRemoteMigrationG'
	$labelUSMTRemoteMigrationG.Size = New-Object System.Drawing.Size(374, 40)
	$labelUSMTRemoteMigrationG.TabIndex = 0
	$labelUSMTRemoteMigrationG.Text = 'USMT Remote Migration GUI'
	$labelUSMTRemoteMigrationG.UseCompatibleTextRendering = $True
	#
	# logtextbox
	#
	$logtextbox.BackColor = [System.Drawing.Color]::LightGray 
	$logtextbox.CausesValidation = $False
	$logtextbox.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$logtextbox.ImeMode = 'Off'
	$logtextbox.Location = New-Object System.Drawing.Point(11, 374)
	$logtextbox.Margin = '5, 1, 1, 1'
	$logtextbox.Name = 'logtextbox'
	$logtextbox.ReadOnly = $True
	$logtextbox.RightMargin = 1308
	$logtextbox.ShortcutsEnabled = $False
	$logtextbox.ShowSelectionMargin = $True
	$logtextbox.Size = New-Object System.Drawing.Size(804, 283)
	$logtextbox.TabIndex = 99
	$logtextbox.TabStop = $False
	$logtextbox.Text = "You can backup to the local C: of a remote computer the same as to a file share, just enter the drive:\folder.  This 
would require manually copying the migration file to the new computer or fileshare manually.

A config file will be created in your %localappdata%\Remote-USMT folder.  This will save the settings Sources, Profile
Path and Encryption Key.  In addition, a history file will be created you can use to restore profiles from.  This is found
by click ""Show Mig History"" button and relates to the ""Restore"" operation.

Your ""Profile Path"" Directory will be populated with a folder named after the target PC. Contained within will be a 
directory named ""USMT"", inside will be the .MIG file.  This directory is required by USMT.   USMT will look at a target
directory for a folder containing USMT.mig. ""<folder>\usmt\usmt.mig"".  

****IMPORTANT****
This program is only generating scheduled tasks and running them on remote computers.  This will happen, if the
 target is online, almost instantly.  Use Verbose logging if you want to watch the status, but this will limit you to just 
one job at a time.  otherwise the restore will be found in the targeted directory after it is uploaded.

Showing remote C$ requires 7zip be installed.  CMTrace relies on cmtrace being installed."
	$logtextbox.WordWrap = $False
	$logtextbox.add_TextChanged($logtextbox_TextChanged)
	#
	# Dialog_OpenMultiCSV
	#
	$Dialog_OpenMultiCSV.DefaultExt = 'txt'
	$Dialog_OpenMultiCSV.Filter = 'CSV File (csv)|*.csv|All Files|*.*'
	$Dialog_OpenMultiCSV.ShowHelp = $True
	#
	# dialog_savefile
	#
	$dialog_savefile.DefaultExt = 'csv'
	$dialog_savefile.Filter = 'CSV File (csv)|*.csv|All Files|*.*'
	$dialog_savefile.add_FileOk($dialog_savefile_FileOk)
	#
	# tooltip1
	#
	# dialog_usmtSources
	#
	$dialog_usmtSources.DefaultExt = 'zip'
	$dialog_usmtSources.FileName = 'usmtSources'
	$dialog_usmtSources.Filter = '"Zip Files|*.zip"'
	$dialog_usmtSources.add_FileOk($dialog_usmtSources_FileOk)
	#
	# timer1
	#
	$timer1.Interval = 1500
	#
	# timerJobTracker
	#
	$timerJobTracker.Interval = 1000
	$timerJobTracker.add_Tick($timerJobTracker_Tick)
	#
	# filesystemwatcher1
	#
	$filesystemwatcher1.EnableRaisingEvents = $True
	$filesystemwatcher1.SynchronizingObject = $MainForm
	#
	# timer2
	#
	# helpprovider1
	#
	# bindingsource1
	#
	# notifyicon1
	#
	$notifyicon1.BalloonTipIcon = 'Info'
	$notifyicon1.BalloonTipText = 'Job Complete'
	$notifyicon1.BalloonTipTitle = 'Status'
	$notifyicon1.Text = 'notifyicon1'
	$notifyicon1.Visible = $True
	$notifyicon1.add_MouseDoubleClick($notifyicon1_MouseDoubleClick)
	#
	# timer3
	#
	# num
	#
	$num.AutoSizeMode = 'None'
	$num.DataPropertyName = 'num'
	$System_Windows_Forms_DataGridViewCellStyle_5 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_5.Font = [System.Drawing.Font]::new('Calibri', '12', [System.Drawing.FontStyle]'Bold')
	$num.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_5
	$num.FillWeight = 8.03764248
	$num.HeaderText = '#'
	$num.MaxInputLength = 3
	$num.MinimumWidth = 17
	$num.Name = 'num'
	$num.Visible = $False
	$num.Width = 17
	#
	# JobName
	#
	$JobName.AutoSizeMode = 'Fill'
	$JobName.DataPropertyName = 'name'
	$System_Windows_Forms_DataGridViewCellStyle_6 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_6.Alignment = 'MiddleCenter'
	$System_Windows_Forms_DataGridViewCellStyle_6.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '8.25')
	$JobName.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_6
	$JobName.FillWeight = 37.8811264
	$JobName.HeaderText = 'JobName'
	$JobName.Name = 'JobName'
	$JobName.Resizable = 'True'
	$JobName.SortMode = 'Automatic'
	#
	# State
	#
	$State.AutoSizeMode = 'AllCells'
	$State.DataPropertyName = 'state'
	$System_Windows_Forms_DataGridViewCellStyle_7 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_7.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '8.25')
	$State.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_7
	$State.FillWeight = 7.84879637
	$State.HeaderText = 'State'
	$State.MaxInputLength = 15
	$State.Name = 'State'
	$State.Width = 78
	#
	# jobStart
	#
	$jobStart.AutoSizeMode = 'AllCells'
	$jobStart.DataPropertyName = 'jobstart'
	$System_Windows_Forms_DataGridViewCellStyle_8 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_8.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '8.25')
	$jobStart.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_8
	$jobStart.FillWeight = 14.125494
	$jobStart.HeaderText = 'JobStart'
	$jobStart.Name = 'jobStart'
	$jobStart.Width = 101
	#
	# JobEnd
	#
	$JobEnd.AutoSizeMode = 'AllCells'
	$JobEnd.DataPropertyName = 'jobend'
	$System_Windows_Forms_DataGridViewCellStyle_9 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_9.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '8.25')
	$JobEnd.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_9
	$JobEnd.FillWeight = 14.125494
	$JobEnd.HeaderText = 'JobEnd'
	$JobEnd.Name = 'JobEnd'
	$JobEnd.Width = 92
	#
	# result
	#
	$result.AutoSizeMode = 'None'
	$result.DataPropertyName = 'result'
	$System_Windows_Forms_DataGridViewCellStyle_10 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_10.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '8.25')
	$result.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_10
	$result.FillWeight = 14.125494
	$result.HeaderText = 'Result'
	$result.Name = 'result'
	$result.Width = 75
	#
	# Cancel
	#
	$Cancel.AutoSizeMode = 'None'
	$Cancel.DataPropertyName = 'Cancel'
	$System_Windows_Forms_DataGridViewCellStyle_11 = New-Object 'System.Windows.Forms.DataGridViewCellStyle'
	$System_Windows_Forms_DataGridViewCellStyle_11.Alignment = 'MiddleCenter'
	$System_Windows_Forms_DataGridViewCellStyle_11.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '8.25')
	$Cancel.DefaultCellStyle = $System_Windows_Forms_DataGridViewCellStyle_11
	$Cancel.FillWeight = 12
	$Cancel.HeaderText = 'Cancel'
	$Cancel.Name = 'Cancel'
	$Cancel.Resizable = 'True'
	$Cancel.SortMode = 'Automatic'
	$Cancel.Text = ''
	$Cancel.ToolTipText = 'Will kill this job'
	$Cancel.UseColumnTextForButtonValue = $True
	$Cancel.Width = 70
	#
	# AddXMLS
	#
	$AddXMLS.DefaultExt = 'xml'
	$AddXMLS.Filter = 'XML files|*.xml'
	$AddXMLS.InitialDirectory = "$usmtfiles.text"
	$AddXMLS.Multiselect = $True
	$bindingsource1.EndInit()
	$filesystemwatcher1.EndInit()
	$datagridview1.EndInit()
	$panel_batchBox.ResumeLayout()
	$DGV_jobstatus.EndInit()
	$panel_noShares.ResumeLayout()
	$panel_Shares.ResumeLayout()
	$Panel_SelectOldPC.ResumeLayout()
	$Panel_TargetPC.ResumeLayout()
	$PanelSelectUser.ResumeLayout()
	$panel_SoloPanel.ResumeLayout()
	$picturebox1.EndInit()
	$MainForm.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $MainForm.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$MainForm.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$MainForm.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$MainForm.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $MainForm.ShowDialog()

}
#endregion Source: USMT-Remote-Gui.psf

#region Source: about.psf
function Show-about_psf
{
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	[void][reflection.assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$About = New-Object 'System.Windows.Forms.Form'
	$labelThisPageAlsoHasAPlac = New-Object 'System.Windows.Forms.Label'
	$linklabelHttpsgithubcomamrak4 = New-Object 'System.Windows.Forms.LinkLabel'
	$labelDevelopedByJoshDahle = New-Object 'System.Windows.Forms.Label'
	$buttonCloseDialog = New-Object 'System.Windows.Forms.Button'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	$About_Load={
		#TODO: Initialize Form Controls here
		
	}
	
	$linklabelHttpsgithubcomamrak4_LinkClicked=[System.Windows.Forms.LinkLabelLinkClickedEventHandler]{
	#Event Argument: $_ = [System.Windows.Forms.LinkLabelLinkClickedEventArgs]
		
		Start-Process 'https://mn365.sharepoint.com/sites/MNIT_apps-jd'
	}
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$About.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$linklabelHttpsgithubcomamrak4.remove_LinkClicked($linklabelHttpsgithubcomamrak4_LinkClicked)
			$About.remove_Load($About_Load)
			$About.remove_Load($Form_StateCorrection_Load)
			$About.remove_Closing($Form_StoreValues_Closing)
			$About.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$About.SuspendLayout()
	#
	# About
	#
	$About.Controls.Add($labelThisPageAlsoHasAPlac)
	$About.Controls.Add($linklabelHttpsgithubcomamrak4)
	$About.Controls.Add($labelDevelopedByJoshDahle)
	$About.Controls.Add($buttonCloseDialog)
	$About.AcceptButton = $buttonCloseDialog
	$About.AutoScaleDimensions = New-Object System.Drawing.SizeF(6, 16)
	$About.AutoScaleMode = 'Font'
	$About.BackColor = [System.Drawing.Color]::DimGray 
	$About.ClientSize = New-Object System.Drawing.Size(372, 474)
	$About.Font = [System.Drawing.Font]::new('Franklin Gothic Medium Cond', '9')
	$About.ForeColor = [System.Drawing.Color]::Orange 
	$About.FormBorderStyle = 'FixedDialog'
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABNTeXN0
ZW0uRHJhd2luZy5JY29uAgAAAAhJY29uRGF0YQhJY29uU2l6ZQcEAhNTeXN0ZW0uRHJhd2luZy5T
aXplAgAAAAIAAAAJAwAAAAX8////E1N5c3RlbS5EcmF3aW5nLlNpemUCAAAABXdpZHRoBmhlaWdo
dAAACAgCAAAAAAAAAAAAAAAPAwAAAMxcAAACAAABAAUAEBAAAAEAIABoBAAAVgAAABgYAAABACAA
iAkAAL4EAAAgIAAAAQAgAKgQAABGDgAAMDAAAAEAIACoJQAA7h4AAAAAAAABACAANhgAAJZEAAAo
AAAAEAAAACAAAAABACAAAAAAAAAEAADDDgAAww4AAAAAAAAAAAAA+8BCAPvAQgD7wEI6+8BCvfvA
Qjn7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIF+8BC
p/vAQv/7wELI+8BCO/vAQgP7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA
+8BCCPvAQrn7wEL/+8BC//vAQuj7wEKm+8BCe/vAQmj7wEJk+8BCW/vAQin7wEIC+8BCAAAAAAAA
AAAA+8BCAPvAQgD7wEIv+8BCdPvAQrn7wELx+8BC//vAQv/7wEL/+8BC//vAQv77wELi+8BCZ/vA
QgP7wEIAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIK+8BCQfvAQq77wEL5+8BC//vAQv/7wEL/+8BC
//vAQuz7wEJD+8BCAPvAQgAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQgv7wEJb+8BC5fvAQv/7wEL/
+8BC//vAQv/7wEL/+8BCovvAQgP7wEIAAAAAAAAAAAD7wEIA+8BCBfvAQkz7wEK8+8BC9vvAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQtn7wEIb+8BCAAAAAAD7wEIA+8BCDvvAQob7wELx+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL5+8BC3fvAQv37wELx+8BCOPvAQgD7wEIA+8BCC/vAQpT7wEL8+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC5fvAQmD7wEK++8BC//vAQpf7wEIc+8BCAPvAQmv7wEL5
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQrT7wEJ++8BCTfvAQrL7wELG+8BCRfvAQiP7
wELV+8BC//vAQv/7wEL/+8BC//vAQv/7wEL8+8BC6PvAQqj7wEJr+8BCnvvAQgz7wEIL+8BCEPvA
QgH7wEJq+8BC+/vAQv/7wEL/+8BC/fvAQuL7wEKl+8BCXPvAQkj7wEKO+8BC4vvAQpj7wEIA+8BC
AAAAAAAAAAAA+8BCovvAQv/7wEL5+8BCx/vAQm/7wEIl+8BCBPvAQgD7wEIy+8BC6/vAQv/7wEKC
+8BCAPvAQgAAAAAAAAAAAPvAQrf7wELQ+8BCYPvAQhL7wEIA+8BCAAAAAAD7wEIA+8BCBvvAQpz7
wEL/+8BCg/vAQgD7wEIAAAAAAAAAAAD7wEJQ+8BCH/vAQgD7wEIAAAAAAAAAAAAAAAAA+8BCAPvA
QgD7wEIg+8BCwfvAQpv7wEIA+8BCAAAAAAAAAAAA+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAD7wEIA+8BCAPvAQin7wEJ4+8BCCvvAQgAAAAAAAAAAAMf/AACB/wAAgAcAAMADAADwAwAA
+AEAAOABAADAAQAAgAAAAIAAAAAAAAAAAA8AAAEPAAAPDwAAP48AAP/HAAAoAAAAGAAAADAAAAAB
ACAAAAAAAAAJAADDDgAAww4AAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAvvAQmT7wEK1+8BCHvvA
QgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCQ/vAQuj7wEL/+8BCn/vAQhL7wEIA+8BCAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEIC+8BCoPvAQv/7wEL/+8BC/fvAQqv7wEIp+8BCAfvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIE+8BCsfvAQv/7wEL/+8BC
//vAQv/7wELe+8BCkfvAQlr7wEI9+8BCL/vAQin7wEIp+8BCJvvAQhH7wEIB+8BCAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCbfvAQtv7wEL2+8BC//vAQv/7wEL/+8BC//vAQv37
wEL0+8BC7fvAQun7wELp+8BC5/vAQsr7wEJ5+8BCFvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAA
AAD7wEIA+8BCBPvAQhr7wEJH+8BCjfvAQtb7wEL8+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL++8BCtPvAQh37wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA
+8BCAfvAQhv7wEJs+8BC1PvAQv77wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQpv7
wEIH+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCHfvA
QqD7wEL9+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvD7wEJC+8BCAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIR+8BCUPvAQq37wEL7+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEKU+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEIA+8BCC/vAQln7wELC+8BC+PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wELO+8BCE/vAQgAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIq+8BCqPvAQvf7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wELs+8BCL/vAQgAAAAAA
AAAAAAAAAAD7wEIA+8BCAPvAQkf7wELV+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQt77wELT+8BC//vAQv/7wEL6+8BCTvvAQgAAAAAAAAAAAPvAQgD7wEIA+8BCTfvA
QuT7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQpn7wEI0+8BC
xvvAQv/7wEL/+8BCnPvAQg37wEIA+8BCAPvAQgD7wEI1+8BC3PvAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQoD7wEJ2+8BCWPvAQuD7wEL/+8BC+/vAQrP7
wEIt+8BCAPvAQg/7wEK0+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC2vvAQkj7wEK4+8BCJ/vAQkT7wEK8+8BC0PvAQn/7wEIT+8BCAPvAQl37wEL6+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv77wELT+8BCSvvAQnX7wEKy
+8BCCPvAQgD7wEIL+8BCEfvAQgL7wEIA+8BCC/vAQrb7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQvf7wELV+8BCp/vAQmv7wEIz+8BCcPvAQvD7wEKH+8BCAPvAQgAAAAAAAAAAAAAA
AAAAAAAA+8BCNfvAQuj7wEL/+8BC//vAQv/7wEL/+8BC//vAQvr7wELX+8BClPvAQkz7wEIY+8BC
DPvAQnf7wELL+8BC+vvAQv/7wEJj+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCZPvAQvv7wEL/
+8BC//vAQv/7wELv+8BCsfvAQlv7wEIb+8BCAvvAQgD7wEIA+8BCCfvAQrn7wEL/+8BC//vAQvv7
wEJP+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BChPvAQv/7wEL/+8BC7PvAQp37wEI9+8BCCPvA
QgD7wEIAAAAAAAAAAAD7wEIA+8BCAPvAQmj7wEL8+8BC//vAQvn7wEJI+8BCAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCkPvAQvj7wEKq+8BCO/vAQgX7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
+8BCAPvAQhT7wEK8+8BC//vAQvv7wEJP+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCa/vAQmb7
wEIK+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEI2+8BC2PvA
Qv/7wEJl+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCCPvAQgL7wEIAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCPfvAQtT7wEKN+8BCAPvAQgAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAD7wEIA+8BCAPvAQjL7wEJ3+8BCCPvAQgAAAAAAAAAAAAAAAAAAAAAA4f//AOD/
/wDAP/8AwAA/AOAAHwDgAA8A/AAHAP+ABwD/AAcA/AADAPgAAwDwAAMA4AABAMAAAACAAAAAgAAR
AAAAPwAAAD8AADA/AAH4PwAH+D8AH/w/AD/+PwD//x8AKAAAACAAAABAAAAAAQAgAAAAAAAAEAAA
ww4AAMMOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCDPvAQob7wEKg+8BCDfvAQgAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgX7wEKF+8BC
+fvAQvn7wEJ2+8BCBPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEIA+8BCSfvAQvH7wEL/+8BC//vAQvL7wEJw+8BCBvvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCAPvAQgD7wEKU+8BC//vAQv/7wEL/+8BC//vAQvX7wEKP+8BCHfvAQgD7wEIA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAfvAQqL7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv77wELR+8BCfPvAQkH7wEIi+8BCEvvAQgv7wEIH+8BCBvvAQgb7wEIG+8BCAfvAQgAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCgvvAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC9fvAQuL7wELQ+8BCwvvAQrn7wEK2+8BCt/vAQrf7
wEKZ+8BCW/vAQhf7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvA
QgD7wEIk+8BCe/vAQrL7wELi+8BC/PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL7+8BCyfvAQkv7wEIC+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCBvvAQiX7wEJh+8BCsPvAQu37wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC6vvAQln7wEIA+8BCAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIH+8BC
OfvAQpn7wELs+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC4PvAQjT7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAD7wEIA+8BCBPvAQkD7wEK8+8BC/fvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BCpfvAQgf7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQh37wEK0+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wELu+8BCOvvAQgAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhP7wEJY+8BCq/vA
Quj7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEKE+8BC
APvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhD7wEJi
+8BCx/vAQvn7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQsD7wEIM+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvA
QgP7wEJB+8BCuvvAQvr7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC5fvAQib7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAPvAQgD7wEIN+8BCefvAQuv7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL3+8BCRfvAQgAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQgD7wEIA+8BCGPvAQqD7wEL7+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvn7wEKy+8BC2PvAQv/7wEL/+8BC//vAQv/7wEJn
+8BCAPvAQgAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhn7wEKu+8BC/vvAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC8fvAQjn7wEI0+8BC0/vA
Qv/7wEL/+8BC//vAQqv7wEIM+8BCAAAAAAAAAAAAAAAAAPvAQgD7wEIO+8BCovvAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wELm
+8BCRfvAQlT7wEJQ+8BC7fvAQv/7wEL/+8BC+fvAQqD7wEI1+8BCCAAAAAD7wEIA+8BCAfvAQnv7
wEL8+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQrr7wEI4+8BC0PvAQjP7wEJv+8BC8/vAQv/7wEL/+8BC//vAQrj7wEId+8BC
APvAQgD7wEI8+8BC6PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wELz+8BCU/vAQlf7wELa+8BCIvvAQgT7wEJa+8BCvfvAQs/7
wEKW+8BCKPvAQgD7wEIA+8BCCPvAQqn7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC7vvAQnL7wEIV+8BCuvvAQrD7wEIF+8BC
APvAQgD7wEIL+8BCEfvAQgP7wEIAAAAAAPvAQgD7wEI8+8BC7/vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL6+8BC5fvAQqj7wEI/+8BCEfvAQo/7
wEL++8BCevvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQoj7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvH7wELG+8BChvvAQk/7wEIo+8BC
F/vAQkf7wEK2+8BC/PvAQvv7wEJQ+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIQ
+8BCxPvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC9vvAQsr7wEKD+8BCPPvAQg/7
wEIA+8BCAPvAQl77wELN+8BC9fvAQv/7wEL/+8BC8PvAQjX7wEIAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQi77wELm+8BC//vAQv/7wEL/+8BC//vAQv/7wEL++8BC4/vAQp37wEJK+8BC
EvvAQgD7wEIAAAAAAPvAQgD7wEIA+8BCbfvAQv/7wEL/+8BC//vAQv/7wELm+8BCJfvAQgAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCTPvAQvX7wEL/+8BC//vAQv/7wEL8+8BC1PvAQnz7
wEIp+8BCA/vAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIt+8BC5vvAQv/7wEL/+8BC//vA
QuD7wEIe+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEJg+8BC+vvAQv/7wEL++8BC
1PvAQnH7wEIc+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgP7wEKV
+8BC//vAQv/7wEL/+8BC4PvAQh77wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQmb7
wEL8+8BC6PvAQoP7wEIe+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAA+8BCAPvAQij7wELW+8BC//vAQv/7wELm+8BCJvvAQgAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCXvvAQrj7wEI7+8BCAvvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQlD7wELq+8BC//vAQvH7wEI3+8BCAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIZ+8BCFvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAfvAQl77wELr+8BC
/fvAQlX7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7
wEIA+8BCAvvAQk/7wELb+8BChPvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQjf7wEJ0+8BCB/vAQgAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAD4f///8D////Af///wD///4AAD//AAAP/wAAA//AAAP/+AAB//4AAP//gAD//gAA//
gAAH/gAAB/wAAAf4AAAH8AAAA+AAAADAAAAAwAAAAYAAAGOAAAD/gAAA/wABgP8AD4D/AD+A/wH/
gP8H/8D/D//g/z//4P////D////8fygAAAAwAAAAYAAAAAEAIAAAAAAAACQAAMMOAADDDgAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIu+8BCr/vAQmT7wEIA
+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BC
APvAQj/7wELR+8BC//vAQtr7wEIz+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQgD7wEIA+8BCMPvAQtb7wEL/+8BC//vAQv/7wELC+8BCIvvAQgD7wEIAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIK+8BCq/vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BCt/vAQiH7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEJC+8BC8vvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQsD7wEIx+8BCAPvAQgAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAA+8BCAPvAQgD7wEJz+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wELb+8BCYPvAQgz7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEKA+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC9/vAQrT7wEJX+8BCHvvAQgb7wEIA+8BCAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BC
APvAQgD7wEJu+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL5
+8BC3PvAQrT7wEKO+8BCb/vAQlf7wEJH+8BCPPvAQjX7wEIy+8BCMvvAQjT7wEI4+8BCKvvAQhH7
wEIC+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEJF+8BC9fvAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv37wEL4+8BC9PvAQvH7wELv
+8BC7/vAQvH7wELy+8BC6PvAQsz7wEKT+8BCQ/vAQgn7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIR+8BCf/vA
Qrz7wELj+8BC+/vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC8vvAQqb7wEIt
+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAD7wEIA+8BCAPvAQgn7wEIm+8BCWPvAQpr7wELW+8BC+fvAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wELY+8BCSvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgL7
wEIa+8BCVvvAQqf7wELp+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC4vvAQkT7wEIA+8BC
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgb7wEIy+8BCjPvAQuL7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQs/7wEIk+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA
+8BCAvvAQiz7wEKW+8BC7/vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEKW+8BCBfvAQgAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIF+8BCSfvAQsn7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wELt+8BCPfvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BC
APvAQhz7wEKj+8BC/PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BCm/vAQgP7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQgD7wEIA+8BCC/vAQjn7wEKS+8BC9vvAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC4PvAQiX7wEIA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhn7wEJj+8BCuvvAQvD7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC/fvAQmL7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIZ+8BCcPvAQs/7
wEL7+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQqH7wEIC+8BCAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA
+8BCDfvAQmD7wELN+8BC/PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
QtD7wEIU+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCAPvAQgH7wEI1+8BCr/vAQvj7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQu37wEIy+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCCvvAQmr7wELi+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvv7wEJU+8BCAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIY+8BCmPvA
Qvf7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEJ3+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7
wEIA+8BCAPvAQiX7wEK2+8BC/vvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvv7wEKS+8BC
jfvAQuv7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEKa+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCKfvAQsL7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQvf7wEJE+8BCAPvAQlb7wELp+8BC//vAQv/7wEL/+8BC//vAQv/7wELO+8BC
GPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIi+8BCwPvAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvX7wEI/+8BCJfvAQgz7wEJr+8BC+PvA
Qv/7wEL/+8BC//vAQv/7wEL9+8BCk/vAQhL7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BC
APvAQhP7wEKt+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQuf7
wEIm+8BCd/vAQmz7wEIK+8BCn/vAQv/7wEL/+8BC//vAQv/7wEL/+8BC+/vAQrr7wEJR+8BCFvvA
QgEAAAAAAAAAAAAAAAD7wEIA+8BCBPvAQof7wEL9+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQr77wEIK+8BCkPvAQuf7wEI0+8BCHPvAQr/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL4+8BCg/vAQgUAAAAAAAAAAPvAQgD7wEIA+8BCTvvAQvD7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC/PvAQmj7wEIE+8BCs/vAQvr7wEJH
+8BCAPvAQif7wEK3+8BC/fvAQv/7wEL/+8BC//vAQvf7wEKg+8BCHPvAQgAAAAAAAAAAAPvAQgD7
wEIX+8BCxfvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
tfvAQhD7wEIo+8BC5fvAQtP7wEIX+8BCAPvAQgD7wEIV+8BCb/vAQrr7wELL+8BCrfvAQlj7wEIL
+8BCAAAAAAAAAAAA+8BCAPvAQgD7wEJx+8BC/fvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wELD+8BCKfvAQgD7wEKC+8BC//vAQpz7wEIB+8BCAAAAAAD7wEIA+8BC
APvAQgn7wEIQ+8BCBfvAQgD7wEIAAAAAAAAAAAAAAAAA+8BCAPvAQhr7wELR+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC8vvAQpz7wEIh+8BCAPvAQkj7wELo+8BC//vA
QmT7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BC
APvAQmL7wEL8+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC+fvAQt/7wEKh+8BCRvvAQgf7
wEIB+8BCSfvAQtr7wEL/+8BC8PvAQjj7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAD7wEIA+8BCB/vAQrH7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL8+8BC4vvAQq37wEJ2
+8BCTfvAQiD7wEID+8BCAPvAQh77wEKA+8BC6fvAQv/7wEL/+8BC2vvAQhv7wEIAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCKfvAQuX7wEL/+8BC//vA
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
QhH7wEKh+8BC/vvAQv/7wEL/+8BCxPvAQgz7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAD7wEID+8BCCvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIV+8BCofvAQvz7wEL/+8BC3/vAQiD7wEIAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCEfvAQo37
wEL2+8BC9fvAQkL7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAA+8BCAPvAQgj7wEJl+8BC4fvAQnb7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIB+8BCPvvAQm/7wEIE
+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/j/////8AAP8H////
/wAA/gP/////AAD8Af////8AAPwA/////wAA/AA/////AAD8AAf///8AAPwAAAA//wAA/AAAAA//
AAD8AAAAB/8AAP8AAAAD/wAA/+AAAAH/AAD//AAAAP8AAP//AAAAfwAA///AAAB/AAD///AAAD8A
AP//4AAAPwAA//+AAAA/AAD//gAAAB8AAP/4AAAAHwAA/+AAAAAfAAD/wAAAAB8AAP+AAAAAHwAA
/wAAAAAfAAD+AAAAIA8AAPwAAAAABwAA+AAAAAAAAADwAAAAAAAAAPAAAAAEAQAA4AAAAAYDAADg
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
itEAAAAASUVORK5CYIIL'))
	#endregion
	$About.Icon = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$About.Margin = '3, 4, 3, 4'
	$About.MaximizeBox = $False
	$About.MinimizeBox = $False
	$About.Name = 'About'
	$About.StartPosition = 'CenterScreen'
	$About.Text = 'About'
	$About.add_Load($About_Load)
	#
	# labelThisPageAlsoHasAPlac
	#
	$labelThisPageAlsoHasAPlac.AutoSize = $True
	$labelThisPageAlsoHasAPlac.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '11.25')
	$labelThisPageAlsoHasAPlac.Location = New-Object System.Drawing.Point(12, 265)
	$labelThisPageAlsoHasAPlac.Name = 'labelThisPageAlsoHasAPlac'
	$labelThisPageAlsoHasAPlac.Size = New-Object System.Drawing.Size(0, 20)
	$labelThisPageAlsoHasAPlac.TabIndex = 3
	#
	# linklabelHttpsgithubcomamrak4
	#
	$linklabelHttpsgithubcomamrak4.Font = [System.Drawing.Font]::new('Franklin Gothic Medium Cond', '12')
	$linklabelHttpsgithubcomamrak4.LinkColor = [System.Drawing.Color]::FromArgb(255, 255, 128, 0)
	$linklabelHttpsgithubcomamrak4.Location = New-Object System.Drawing.Point(12, 228)
	$linklabelHttpsgithubcomamrak4.Name = 'linklabelHttpsgithubcomamrak4'
	$linklabelHttpsgithubcomamrak4.Size = New-Object System.Drawing.Size(348, 28)
	$linklabelHttpsgithubcomamrak4.TabIndex = 2
	$linklabelHttpsgithubcomamrak4.TabStop = $True
	$linklabelHttpsgithubcomamrak4.Text = 'https://github.com/amrak44/RemoteUSMT-TechTool'
	$linklabelHttpsgithubcomamrak4.VisitedLinkColor = [System.Drawing.Color]::FromArgb(255, 128, 255, 255)
	$linklabelHttpsgithubcomamrak4.add_LinkClicked($linklabelHttpsgithubcomamrak4_LinkClicked)
	#
	# labelDevelopedByJoshDahle
	#
	$labelDevelopedByJoshDahle.AutoSize = $True
	$labelDevelopedByJoshDahle.Font = [System.Drawing.Font]::new('Franklin Gothic Medium Cond', '12')
	$labelDevelopedByJoshDahle.Location = New-Object System.Drawing.Point(12, 9)
	$labelDevelopedByJoshDahle.Name = 'labelDevelopedByJoshDahle'
	$labelDevelopedByJoshDahle.Size = New-Object System.Drawing.Size(303, 147)
	$labelDevelopedByJoshDahle.TabIndex = 1
	$labelDevelopedByJoshDahle.Text = 'Developed by Josh Dahle for a quick and reliable 
way to migrate files from one computer to another.

The goal of this has and will always be to lessen the
burden of a PC migration for staff and collegues.  

Updates can be found at '
	#
	# buttonCloseDialog
	#
	$buttonCloseDialog.Anchor = 'Bottom, Right'
	$buttonCloseDialog.DialogResult = 'OK'
	$buttonCloseDialog.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '9')
	$buttonCloseDialog.ForeColor = [System.Drawing.Color]::Black 
	$buttonCloseDialog.Location = New-Object System.Drawing.Point(140, 433)
	$buttonCloseDialog.Margin = '3, 4, 3, 4'
	$buttonCloseDialog.Name = 'buttonCloseDialog'
	$buttonCloseDialog.Size = New-Object System.Drawing.Size(95, 28)
	$buttonCloseDialog.TabIndex = 0
	$buttonCloseDialog.Text = 'Close Dialog'
	$buttonCloseDialog.UseCompatibleTextRendering = $True
	$buttonCloseDialog.UseVisualStyleBackColor = $True
	$About.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $About.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$About.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$About.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$About.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $About.ShowDialog()

}
#endregion Source: about.psf

#region Source: starting.psf
function Show-starting_psf
{
	#----------------------------------------------
	#region Import the Assemblies
	#----------------------------------------------
	[void][reflection.assembly]::Load('System.Drawing, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a')
	[void][reflection.assembly]::Load('System.Windows.Forms, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089')
	#endregion Import Assemblies

	#----------------------------------------------
	#region Define powershell Types
	#----------------------------------------------
	try{
		[FolderBrowserModernDialog] | Out-Null
	}
	catch
	{
		Add-Type -ReferencedAssemblies ('System.Windows.Forms') -TypeDefinition  @" 
		using System;
		using System.Windows.Forms;
		using System.Reflection;

        namespace powershellTypes
        {
		    public class FolderBrowserModernDialog : System.Windows.Forms.CommonDialog
            {
                private System.Windows.Forms.OpenFileDialog fileDialog;
                public FolderBrowserModernDialog()
                {
                    fileDialog = new System.Windows.Forms.OpenFileDialog();
                    fileDialog.Filter = "Folders|\n";
                    fileDialog.AddExtension = false;
                    fileDialog.CheckFileExists = false;
                    fileDialog.DereferenceLinks = true;
                    fileDialog.Multiselect = false;
                    fileDialog.Title = "Select a folder";
                }

                public string Title
                {
                    get { return fileDialog.Title; }
                    set { fileDialog.Title = value; }
                }

                public string InitialDirectory
                {
                    get { return fileDialog.InitialDirectory; }
                    set { fileDialog.InitialDirectory = value; }
                }
                
                public string SelectedPath
                {
                    get { return fileDialog.FileName; }
                    set { fileDialog.FileName = value; }
                }

                object InvokeMethod(Type type, object obj, string method, object[] parameters)
                {
                    MethodInfo methInfo = type.GetMethod(method, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
                    return methInfo.Invoke(obj, parameters);
                }

                bool ShowOriginalBrowserDialog(IntPtr hwndOwner)
                {
                    using(FolderBrowserDialog folderBrowserDialog = new FolderBrowserDialog())
                    {
                        folderBrowserDialog.Description = this.Title;
                        folderBrowserDialog.SelectedPath = !string.IsNullOrEmpty(this.SelectedPath) ? this.SelectedPath : this.InitialDirectory;
                        folderBrowserDialog.ShowNewFolderButton = false;
                        if (folderBrowserDialog.ShowDialog() == DialogResult.OK)
                        {
                            fileDialog.FileName = folderBrowserDialog.SelectedPath;
                            return true;
                        }
                        return false;
                    }
                }

                protected override bool RunDialog(IntPtr hwndOwner)
                {
                    if (Environment.OSVersion.Version.Major >= 6)
                    {      
                        try
                        {
                            bool flag = false;
                            System.Reflection.Assembly assembly = Assembly.Load("System.Windows.Forms, Version = 4.0.0.0, Culture = neutral, PublicKeyToken = b77a5c561934e089");
                            Type typeIFileDialog = assembly.GetType("System.Windows.Forms.FileDialogNative").GetNestedType("IFileDialog", BindingFlags.NonPublic);
                            uint num = 0;
                            object dialog = InvokeMethod(fileDialog.GetType(), fileDialog, "CreateVistaDialog", null);
                            InvokeMethod(fileDialog.GetType(), fileDialog, "OnBeforeVistaDialog", new object[] { dialog });
                            uint options = (uint)InvokeMethod(typeof(System.Windows.Forms.FileDialog), fileDialog, "GetOptions", null) | (uint)0x20;
                            InvokeMethod(typeIFileDialog, dialog, "SetOptions", new object[] { options });
                            Type vistaDialogEventsType = assembly.GetType("System.Windows.Forms.FileDialog").GetNestedType("VistaDialogEvents", BindingFlags.NonPublic);
                            object pfde = Activator.CreateInstance(vistaDialogEventsType, fileDialog);
                            object[] parameters = new object[] { pfde, num };
                            InvokeMethod(typeIFileDialog, dialog, "Advise", parameters);
                            num = (uint)parameters[1];
                            try
                            {
                                int num2 = (int)InvokeMethod(typeIFileDialog, dialog, "Show", new object[] { hwndOwner });
                                flag = 0 == num2;
                            }
                            finally
                            {
                                InvokeMethod(typeIFileDialog, dialog, "Unadvise", new object[] { num });
                                GC.KeepAlive(pfde);
                            }
                            return flag;
                        }
                        catch
                        {
                            return ShowOriginalBrowserDialog(hwndOwner);
                        }
                    }
                    else
                        return ShowOriginalBrowserDialog(hwndOwner);
                }

                public override void Reset()
                {
                    fileDialog.Reset();
                }
            }
       }
"@ -IgnoreWarnings | Out-Null
	}
	#endregion Define powershell Types

	#----------------------------------------------
	#region Generated Form Objects
	#----------------------------------------------
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$Remote_USMT_FirstRun = New-Object 'System.Windows.Forms.Form'
	$buttonCancel = New-Object 'System.Windows.Forms.Button'
	$buttonBack = New-Object 'System.Windows.Forms.Button'
	$buttonBegin = New-Object 'System.Windows.Forms.Button'
	$tabcontrolWizard = New-Object 'System.Windows.Forms.TabControl'
	$tabpageStep1 = New-Object 'System.Windows.Forms.TabPage'
	$labelThisWillRunOnlyWhenA = New-Object 'System.Windows.Forms.Label'
	$buttonBrowse2 = New-Object 'System.Windows.Forms.Button'
	$textboxFile = New-Object 'System.Windows.Forms.TextBox'
	$textbox1 = New-Object 'System.Windows.Forms.TextBox'
	$labelRequiredDomainComput = New-Object 'System.Windows.Forms.Label'
	$labelOnASharedDriveBothYo = New-Object 'System.Windows.Forms.Label'
	$labelScanstateexeLocation = New-Object 'System.Windows.Forms.Label'
	$labelFirstStartWizard = New-Object 'System.Windows.Forms.Label'
	$labelUSMTRemoteGUI = New-Object 'System.Windows.Forms.Label'
	$tabpageStep2 = New-Object 'System.Windows.Forms.TabPage'
	$picturebox1 = New-Object 'System.Windows.Forms.PictureBox'
	$textbox2 = New-Object 'System.Windows.Forms.TextBox'
	$buttonBrowseFolder = New-Object 'System.Windows.Forms.Button'
	$textboxFolder = New-Object 'System.Windows.Forms.TextBox'
	$label1 = New-Object 'System.Windows.Forms.Label'
	$labelWhichTheyWillBeTheOw = New-Object 'System.Windows.Forms.Label'
	$labelDomainComputersShoul = New-Object 'System.Windows.Forms.Label'
	$labelUntilTheyAreNeededTo = New-Object 'System.Windows.Forms.Label'
	$labelThisIsTheLocationWhe = New-Object 'System.Windows.Forms.Label'
	$labelUSMTProfileStorageLo = New-Object 'System.Windows.Forms.Label'
	$buttonNext = New-Object 'System.Windows.Forms.Button'
	$scanstatelocation = New-Object 'System.Windows.Forms.OpenFileDialog'
	$folderbrowsermoderndialog1 = New-Object 'powershellTypes.FolderBrowserModernDialog'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	#endregion Generated Form Objects

	#----------------------------------------------
	# User Generated Script
	#----------------------------------------------
	
	#-------------------------------------------------------
	# NOTE: When new TabPage added place the validation code
	# 		in the Test-WizardPage function.
	#-------------------------------------------------------
	function Test-WizardPage
	{
	<#
		Add TabPages and place the validation code in this function
	#>
		[OutputType([boolean])]
		param([System.Windows.Forms.TabPage]$tabPage)
		
		if($tabPage -eq $tabpageStep1)
		{
			#TODO: Enter Validation Code here for Step 1
			if(-not $usmtpath.Text)
			{
				return $false	
			}
			$buttonNext.Enabled = $true
			return $true
		}
		elseif ($tabPage -eq $tabpageStep2)
		{
			#TODO: Enter Validation Code here for Step 2
			if(-not $profileLocation.Text)
			{
				return $false
			}
			
			return $true
		}
	
		#Add more pages here
		
		return $false
	}
	
	#region Events and Functions
	$Remote_USMT_FirstRun_Load={
		Update-NavButtons
	}
	
	function Update-NavButtons
	{
		<# 
			.DESCRIPTION
			Validates the current tab and Updates the Next, Prev and Finish buttons.
		#>
		$enabled = Test-WizardPage $tabcontrolWizard.SelectedTab
		$buttonNext.Enabled = $enabled -and ($tabcontrolWizard.SelectedIndex -lt $tabcontrolWizard.TabCount - 1)
		$buttonBack.Enabled = $tabcontrolWizard.SelectedIndex -gt 0
		$buttonBegin.Enabled = $enabled -and ($tabcontrolWizard.SelectedIndex -eq $tabcontrolWizard.TabCount - 1)	
		#Uncomment to Hide Buttons
		$buttonNext.Visible = ($tabcontrolWizard.SelectedIndex -lt $tabcontrolWizard.TabCount - 1)
		#$buttonFinish.Visible = ($tabcontrolWizard.SelectedIndex -eq $tabcontrolWizard.TabCount - 1)
	}
	
	$script:DeselectedIndex = -1
	$tabcontrolWizard_Deselecting=[System.Windows.Forms.TabControlCancelEventHandler]{
	#Event Argument: $_ = [System.Windows.Forms.TabControlCancelEventArgs]
		# Store the previous tab index
		$script:DeselectedIndex = $_.TabPageIndex
	}
	
	$tabcontrolWizard_Selecting=[System.Windows.Forms.TabControlCancelEventHandler]{
	#Event Argument: $_ = [System.Windows.Forms.TabControlCancelEventArgs]
		# We only validate if we are moving to the Next TabPage. 
		# Users can move back without validating
		if($script:DeselectedIndex -ne -1 -and $script:DeselectedIndex -lt $_.TabPageIndex)
		{
			#Validate each page until we reach the one we want
			for($index = $script:DeselectedIndex; $index -lt $_.TabPageIndex; $index++)
			{
				$_.Cancel = -not (Test-WizardPage $tabcontrolWizard.TabPages[$index])
				
				if($_.Cancel) 
				{
					# Cancel and Return if validation failed.
					return;
				}
			}
		}
		
		Update-NavButtons
	}
	
	$buttonBack_Click={
		#Go to the previous tab page
		if($tabcontrolWizard.SelectedIndex -gt 0)
		{
			$tabcontrolWizard.SelectedIndex--
		}
	}
	
	$buttonNext_Click={	
		#Go to the next tab page
		if($tabcontrolWizard.SelectedIndex -lt $tabcontrolWizard.TabCount - 1)
		{
			$tabcontrolWizard.SelectedIndex++
		}
		$buttonBegin.Visible = $true
		
	}
	
	#endregion
	
	#------------------------------------------------------
	# NOTE: When a Control State changes you should call
	# 		Update-NavButtons to trigger validation
	#------------------------------------------------------
	
	$buttonBrowseFolder_Click={
		if($folderbrowserdialog1.ShowDialog() -eq 'OK')
		{
			$folderbrowserdialog1.
			$profileLocation = $folderbrowserdialog1.SelectedPath
		}
	}
	
	$buttonBrowse_Click={
		
		if ($scanstateLocation.ShowDialog() -eq 'OK')
		{
			$usmtpath.text = $scanstateLocation.FileName
		}
	}
	
	$buttonBrowseFolder_Click2={
		if($folderbrowserdialog2.ShowDialog() -eq 'OK')
		{
			$profileLocation = $folderbrowserdialog2.SelectedPath
		}
	}
	
	$usmtpath_TextChanged={
		
		Update-NavButtons
	}
	
	$profileLocation_TextChanged={
		
		Update-NavButtons
	}
	
	$textbox1_TextChanged={
		
	}
	
	$buttonBrowseFolder2_Click={
		if($folderbrowsermoderndialog2.ShowDialog() -eq 'OK')
		{
			$textboxFolder.Text = $folderbrowsermoderndialog2.SelectedPath
		}
	}
	
	$buttonBrowseFolder3_Click={
		if($folderbrowserdialog3.ShowDialog() -eq 'OK')
		{
			$textboxFolder2.Text = $folderbrowserdialog3.SelectedPath
		}
	}
	
	$buttonBrowse2_Click={
	
		if($scanstatelocation.ShowDialog() -eq 'OK')
		{
			$textboxFile.Text = $scanstatelocation.FileName
		}
	}
	
	$buttonBrowseFolder_Click3={
		if($folderbrowsermoderndialog1.ShowDialog() -eq 'OK')
		{
			$textboxFolder.Text = $folderbrowsermoderndialog1.SelectedPath
		}
	}
	
	# --End User Generated Script--
	#----------------------------------------------
	#region Generated Events
	#----------------------------------------------
	
	$Form_StateCorrection_Load=
	{
		#Correct the initial state of the form to prevent the .Net maximized form issue
		$Remote_USMT_FirstRun.WindowState = $InitialFormWindowState
	}
	
	$Form_StoreValues_Closing=
	{
		#Store the control values
		$script:starting_textboxFile = $textboxFile.Text
		$script:starting_textbox1 = $textbox1.Text
		$script:starting_textbox2 = $textbox2.Text
		$script:starting_textboxFolder = $textboxFolder.Text
	}

	
	$Form_Cleanup_FormClosed=
	{
		#Remove all event handlers from the controls
		try
		{
			$buttonBack.remove_Click($buttonBack_Click)
			$buttonBegin.remove_Click($buttonBegin_Click)
			$buttonBrowse2.remove_Click($buttonBrowse2_Click)
			$textbox1.remove_TextChanged($textbox1_TextChanged)
			$buttonBrowseFolder.remove_Click($buttonBrowseFolder_Click3)
			$tabcontrolWizard.remove_Selecting($tabcontrolWizard_Selecting)
			$tabcontrolWizard.remove_Deselecting($tabcontrolWizard_Deselecting)
			$buttonNext.remove_Click($buttonNext_Click)
			$Remote_USMT_FirstRun.remove_Load($Remote_USMT_FirstRun_Load)
			$Remote_USMT_FirstRun.remove_Load($Form_StateCorrection_Load)
			$Remote_USMT_FirstRun.remove_Closing($Form_StoreValues_Closing)
			$Remote_USMT_FirstRun.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null <# Prevent PSScriptAnalyzer warning #> }
	}
	#endregion Generated Events

	#----------------------------------------------
	#region Generated Form Code
	#----------------------------------------------
	$Remote_USMT_FirstRun.SuspendLayout()
	$tabcontrolWizard.SuspendLayout()
	$tabpageStep1.SuspendLayout()
	$tabpageStep2.SuspendLayout()
	$picturebox1.BeginInit()
	#
	# Remote_USMT_FirstRun
	#
	$Remote_USMT_FirstRun.Controls.Add($buttonCancel)
	$Remote_USMT_FirstRun.Controls.Add($buttonBack)
	$Remote_USMT_FirstRun.Controls.Add($buttonBegin)
	$Remote_USMT_FirstRun.Controls.Add($tabcontrolWizard)
	$Remote_USMT_FirstRun.Controls.Add($buttonNext)
	$Remote_USMT_FirstRun.AcceptButton = $buttonBegin
	$Remote_USMT_FirstRun.AutoScaleDimensions = New-Object System.Drawing.SizeF(10, 24)
	$Remote_USMT_FirstRun.AutoScaleMode = 'Font'
	$Remote_USMT_FirstRun.BackColor = [System.Drawing.Color]::DimGray 
	$Remote_USMT_FirstRun.CancelButton = $buttonCancel
	$Remote_USMT_FirstRun.ClientSize = New-Object System.Drawing.Size(895, 607)
	$Remote_USMT_FirstRun.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$Remote_USMT_FirstRun.FormBorderStyle = 'FixedDialog'
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
AAEAAAD/////AQAAAAAAAAAMAgAAAFFTeXN0ZW0uRHJhd2luZywgVmVyc2lvbj00LjAuMC4wLCBD
dWx0dXJlPW5ldXRyYWwsIFB1YmxpY0tleVRva2VuPWIwM2Y1ZjdmMTFkNTBhM2EFAQAAABNTeXN0
ZW0uRHJhd2luZy5JY29uAgAAAAhJY29uRGF0YQhJY29uU2l6ZQcEAhNTeXN0ZW0uRHJhd2luZy5T
aXplAgAAAAIAAAAJAwAAAAX8////E1N5c3RlbS5EcmF3aW5nLlNpemUCAAAABXdpZHRoBmhlaWdo
dAAACAgCAAAAAAAAAAAAAAAPAwAAAMxcAAACAAABAAUAEBAAAAEAIABoBAAAVgAAABgYAAABACAA
iAkAAL4EAAAgIAAAAQAgAKgQAABGDgAAMDAAAAEAIACoJQAA7h4AAAAAAAABACAANhgAAJZEAAAo
AAAAEAAAACAAAAABACAAAAAAAAAEAADDDgAAww4AAAAAAAAAAAAA+8BCAPvAQgD7wEI6+8BCvfvA
Qjn7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIF+8BC
p/vAQv/7wELI+8BCO/vAQgP7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA
+8BCCPvAQrn7wEL/+8BC//vAQuj7wEKm+8BCe/vAQmj7wEJk+8BCW/vAQin7wEIC+8BCAAAAAAAA
AAAA+8BCAPvAQgD7wEIv+8BCdPvAQrn7wELx+8BC//vAQv/7wEL/+8BC//vAQv77wELi+8BCZ/vA
QgP7wEIAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIK+8BCQfvAQq77wEL5+8BC//vAQv/7wEL/+8BC
//vAQuz7wEJD+8BCAPvAQgAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQgv7wEJb+8BC5fvAQv/7wEL/
+8BC//vAQv/7wEL/+8BCovvAQgP7wEIAAAAAAAAAAAD7wEIA+8BCBfvAQkz7wEK8+8BC9vvAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQtn7wEIb+8BCAAAAAAD7wEIA+8BCDvvAQob7wELx+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL5+8BC3fvAQv37wELx+8BCOPvAQgD7wEIA+8BCC/vAQpT7wEL8+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC5fvAQmD7wEK++8BC//vAQpf7wEIc+8BCAPvAQmv7wEL5
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQrT7wEJ++8BCTfvAQrL7wELG+8BCRfvAQiP7
wELV+8BC//vAQv/7wEL/+8BC//vAQv/7wEL8+8BC6PvAQqj7wEJr+8BCnvvAQgz7wEIL+8BCEPvA
QgH7wEJq+8BC+/vAQv/7wEL/+8BC/fvAQuL7wEKl+8BCXPvAQkj7wEKO+8BC4vvAQpj7wEIA+8BC
AAAAAAAAAAAA+8BCovvAQv/7wEL5+8BCx/vAQm/7wEIl+8BCBPvAQgD7wEIy+8BC6/vAQv/7wEKC
+8BCAPvAQgAAAAAAAAAAAPvAQrf7wELQ+8BCYPvAQhL7wEIA+8BCAAAAAAD7wEIA+8BCBvvAQpz7
wEL/+8BCg/vAQgD7wEIAAAAAAAAAAAD7wEJQ+8BCH/vAQgD7wEIAAAAAAAAAAAAAAAAA+8BCAPvA
QgD7wEIg+8BCwfvAQpv7wEIA+8BCAAAAAAAAAAAA+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAD7wEIA+8BCAPvAQin7wEJ4+8BCCvvAQgAAAAAAAAAAAMf/AACB/wAAgAcAAMADAADwAwAA
+AEAAOABAADAAQAAgAAAAIAAAAAAAAAAAA8AAAEPAAAPDwAAP48AAP/HAAAoAAAAGAAAADAAAAAB
ACAAAAAAAAAJAADDDgAAww4AAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAvvAQmT7wEK1+8BCHvvA
QgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCQ/vAQuj7wEL/+8BCn/vAQhL7wEIA+8BCAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEIC+8BCoPvAQv/7wEL/+8BC/fvAQqv7wEIp+8BCAfvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIE+8BCsfvAQv/7wEL/+8BC
//vAQv/7wELe+8BCkfvAQlr7wEI9+8BCL/vAQin7wEIp+8BCJvvAQhH7wEIB+8BCAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCbfvAQtv7wEL2+8BC//vAQv/7wEL/+8BC//vAQv37
wEL0+8BC7fvAQun7wELp+8BC5/vAQsr7wEJ5+8BCFvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAA
AAD7wEIA+8BCBPvAQhr7wEJH+8BCjfvAQtb7wEL8+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL++8BCtPvAQh37wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA
+8BCAfvAQhv7wEJs+8BC1PvAQv77wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQpv7
wEIH+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCHfvA
QqD7wEL9+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvD7wEJC+8BCAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIR+8BCUPvAQq37wEL7+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEKU+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEIA+8BCC/vAQln7wELC+8BC+PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wELO+8BCE/vAQgAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIq+8BCqPvAQvf7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wELs+8BCL/vAQgAAAAAA
AAAAAAAAAAD7wEIA+8BCAPvAQkf7wELV+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQt77wELT+8BC//vAQv/7wEL6+8BCTvvAQgAAAAAAAAAAAPvAQgD7wEIA+8BCTfvA
QuT7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQpn7wEI0+8BC
xvvAQv/7wEL/+8BCnPvAQg37wEIA+8BCAPvAQgD7wEI1+8BC3PvAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQoD7wEJ2+8BCWPvAQuD7wEL/+8BC+/vAQrP7
wEIt+8BCAPvAQg/7wEK0+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC2vvAQkj7wEK4+8BCJ/vAQkT7wEK8+8BC0PvAQn/7wEIT+8BCAPvAQl37wEL6+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv77wELT+8BCSvvAQnX7wEKy
+8BCCPvAQgD7wEIL+8BCEfvAQgL7wEIA+8BCC/vAQrb7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQvf7wELV+8BCp/vAQmv7wEIz+8BCcPvAQvD7wEKH+8BCAPvAQgAAAAAAAAAAAAAA
AAAAAAAA+8BCNfvAQuj7wEL/+8BC//vAQv/7wEL/+8BC//vAQvr7wELX+8BClPvAQkz7wEIY+8BC
DPvAQnf7wELL+8BC+vvAQv/7wEJj+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCZPvAQvv7wEL/
+8BC//vAQv/7wELv+8BCsfvAQlv7wEIb+8BCAvvAQgD7wEIA+8BCCfvAQrn7wEL/+8BC//vAQvv7
wEJP+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BChPvAQv/7wEL/+8BC7PvAQp37wEI9+8BCCPvA
QgD7wEIAAAAAAAAAAAD7wEIA+8BCAPvAQmj7wEL8+8BC//vAQvn7wEJI+8BCAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCkPvAQvj7wEKq+8BCO/vAQgX7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
+8BCAPvAQhT7wEK8+8BC//vAQvv7wEJP+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCa/vAQmb7
wEIK+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEI2+8BC2PvA
Qv/7wEJl+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCCPvAQgL7wEIAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCPfvAQtT7wEKN+8BCAPvAQgAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAD7wEIA+8BCAPvAQjL7wEJ3+8BCCPvAQgAAAAAAAAAAAAAAAAAAAAAA4f//AOD/
/wDAP/8AwAA/AOAAHwDgAA8A/AAHAP+ABwD/AAcA/AADAPgAAwDwAAMA4AABAMAAAACAAAAAgAAR
AAAAPwAAAD8AADA/AAH4PwAH+D8AH/w/AD/+PwD//x8AKAAAACAAAABAAAAAAQAgAAAAAAAAEAAA
ww4AAMMOAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCDPvAQob7wEKg+8BCDfvAQgAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgX7wEKF+8BC
+fvAQvn7wEJ2+8BCBPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEIA+8BCSfvAQvH7wEL/+8BC//vAQvL7wEJw+8BCBvvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCAPvAQgD7wEKU+8BC//vAQv/7wEL/+8BC//vAQvX7wEKP+8BCHfvAQgD7wEIA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAfvAQqL7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv77wELR+8BCfPvAQkH7wEIi+8BCEvvAQgv7wEIH+8BCBvvAQgb7wEIG+8BCAfvAQgAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCgvvAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC9fvAQuL7wELQ+8BCwvvAQrn7wEK2+8BCt/vAQrf7
wEKZ+8BCW/vAQhf7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvA
QgD7wEIk+8BCe/vAQrL7wELi+8BC/PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL7+8BCyfvAQkv7wEIC+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCBvvAQiX7wEJh+8BCsPvAQu37wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC6vvAQln7wEIA+8BCAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIH+8BC
OfvAQpn7wELs+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC4PvAQjT7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAD7wEIA+8BCBPvAQkD7wEK8+8BC/fvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BCpfvAQgf7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQh37wEK0+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wELu+8BCOvvAQgAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhP7wEJY+8BCq/vA
Quj7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEKE+8BC
APvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhD7wEJi
+8BCx/vAQvn7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQsD7wEIM+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvA
QgP7wEJB+8BCuvvAQvr7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC5fvAQib7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAPvAQgD7wEIN+8BCefvAQuv7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL3+8BCRfvAQgAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQgD7wEIA+8BCGPvAQqD7wEL7+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvn7wEKy+8BC2PvAQv/7wEL/+8BC//vAQv/7wEJn
+8BCAPvAQgAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhn7wEKu+8BC/vvAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC8fvAQjn7wEI0+8BC0/vA
Qv/7wEL/+8BC//vAQqv7wEIM+8BCAAAAAAAAAAAAAAAAAPvAQgD7wEIO+8BCovvAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wELm
+8BCRfvAQlT7wEJQ+8BC7fvAQv/7wEL/+8BC+fvAQqD7wEI1+8BCCAAAAAD7wEIA+8BCAfvAQnv7
wEL8+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQrr7wEI4+8BC0PvAQjP7wEJv+8BC8/vAQv/7wEL/+8BC//vAQrj7wEId+8BC
APvAQgD7wEI8+8BC6PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wELz+8BCU/vAQlf7wELa+8BCIvvAQgT7wEJa+8BCvfvAQs/7
wEKW+8BCKPvAQgD7wEIA+8BCCPvAQqn7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC7vvAQnL7wEIV+8BCuvvAQrD7wEIF+8BC
APvAQgD7wEIL+8BCEfvAQgP7wEIAAAAAAPvAQgD7wEI8+8BC7/vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL6+8BC5fvAQqj7wEI/+8BCEfvAQo/7
wEL++8BCevvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQoj7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvH7wELG+8BChvvAQk/7wEIo+8BC
F/vAQkf7wEK2+8BC/PvAQvv7wEJQ+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIQ
+8BCxPvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC9vvAQsr7wEKD+8BCPPvAQg/7
wEIA+8BCAPvAQl77wELN+8BC9fvAQv/7wEL/+8BC8PvAQjX7wEIAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQi77wELm+8BC//vAQv/7wEL/+8BC//vAQv/7wEL++8BC4/vAQp37wEJK+8BC
EvvAQgD7wEIAAAAAAPvAQgD7wEIA+8BCbfvAQv/7wEL/+8BC//vAQv/7wELm+8BCJfvAQgAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCTPvAQvX7wEL/+8BC//vAQv/7wEL8+8BC1PvAQnz7
wEIp+8BCA/vAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIt+8BC5vvAQv/7wEL/+8BC//vA
QuD7wEIe+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEJg+8BC+vvAQv/7wEL++8BC
1PvAQnH7wEIc+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgP7wEKV
+8BC//vAQv/7wEL/+8BC4PvAQh77wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQmb7
wEL8+8BC6PvAQoP7wEIe+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAA+8BCAPvAQij7wELW+8BC//vAQv/7wELm+8BCJvvAQgAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCXvvAQrj7wEI7+8BCAvvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQlD7wELq+8BC//vAQvH7wEI3+8BCAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIZ+8BCFvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAfvAQl77wELr+8BC
/fvAQlX7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7
wEIA+8BCAvvAQk/7wELb+8BChPvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQjf7wEJ0+8BCB/vAQgAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAD4f///8D////Af///wD///4AAD//AAAP/wAAA//AAAP/+AAB//4AAP//gAD//gAA//
gAAH/gAAB/wAAAf4AAAH8AAAA+AAAADAAAAAwAAAAYAAAGOAAAD/gAAA/wABgP8AD4D/AD+A/wH/
gP8H/8D/D//g/z//4P////D////8fygAAAAwAAAAYAAAAAEAIAAAAAAAACQAAMMOAADDDgAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIu+8BCr/vAQmT7wEIA
+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BC
APvAQj/7wELR+8BC//vAQtr7wEIz+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQgD7wEIA+8BCMPvAQtb7wEL/+8BC//vAQv/7wELC+8BCIvvAQgD7wEIAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIK+8BCq/vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BCt/vAQiH7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7
wEJC+8BC8vvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQsD7wEIx+8BCAPvAQgAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAA+8BCAPvAQgD7wEJz+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wELb+8BCYPvAQgz7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEKA+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC9/vAQrT7wEJX+8BCHvvAQgb7wEIA+8BCAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BC
APvAQgD7wEJu+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL5
+8BC3PvAQrT7wEKO+8BCb/vAQlf7wEJH+8BCPPvAQjX7wEIy+8BCMvvAQjT7wEI4+8BCKvvAQhH7
wEIC+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEJF+8BC9fvAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv37wEL4+8BC9PvAQvH7wELv
+8BC7/vAQvH7wELy+8BC6PvAQsz7wEKT+8BCQ/vAQgn7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIR+8BCf/vA
Qrz7wELj+8BC+/vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC8vvAQqb7wEIt
+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAD7wEIA+8BCAPvAQgn7wEIm+8BCWPvAQpr7wELW+8BC+fvAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wELY+8BCSvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgL7
wEIa+8BCVvvAQqf7wELp+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC4vvAQkT7wEIA+8BC
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgb7wEIy+8BCjPvAQuL7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQs/7wEIk+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA
+8BCAvvAQiz7wEKW+8BC7/vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEKW+8BCBfvAQgAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIF+8BCSfvAQsn7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wELt+8BCPfvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BC
APvAQhz7wEKj+8BC/PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BCm/vAQgP7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAPvAQgD7wEIA+8BCC/vAQjn7wEKS+8BC9vvAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC4PvAQiX7wEIA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCAPvAQhn7wEJj+8BCuvvAQvD7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC/fvAQmL7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIZ+8BCcPvAQs/7
wEL7+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQqH7wEIC+8BCAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA
+8BCDfvAQmD7wELN+8BC/PvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
QtD7wEIU+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAA+8BCAPvAQgH7wEI1+8BCr/vAQvj7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQu37wEIy+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCCvvAQmr7wELi+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvv7wEJU+8BCAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIY+8BCmPvA
Qvf7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEJ3+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7
wEIA+8BCAPvAQiX7wEK2+8BC/vvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvv7wEKS+8BC
jfvAQuv7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEKa+8BCAPvAQgAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIA+8BCKfvAQsL7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQvf7wEJE+8BCAPvAQlb7wELp+8BC//vAQv/7wEL/+8BC//vAQv/7wELO+8BC
GPvAQgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIi+8BCwPvAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQvX7wEI/+8BCJfvAQgz7wEJr+8BC+PvA
Qv/7wEL/+8BC//vAQv/7wEL9+8BCk/vAQhL7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAA+8BC
APvAQhP7wEKt+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQuf7
wEIm+8BCd/vAQmz7wEIK+8BCn/vAQv/7wEL/+8BC//vAQv/7wEL/+8BC+/vAQrr7wEJR+8BCFvvA
QgEAAAAAAAAAAAAAAAD7wEIA+8BCBPvAQof7wEL9+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQr77wEIK+8BCkPvAQuf7wEI0+8BCHPvAQr/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL4+8BCg/vAQgUAAAAAAAAAAPvAQgD7wEIA+8BCTvvAQvD7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC/PvAQmj7wEIE+8BCs/vAQvr7wEJH
+8BCAPvAQif7wEK3+8BC/fvAQv/7wEL/+8BC//vAQvf7wEKg+8BCHPvAQgAAAAAAAAAAAPvAQgD7
wEIX+8BCxfvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
tfvAQhD7wEIo+8BC5fvAQtP7wEIX+8BCAPvAQgD7wEIV+8BCb/vAQrr7wELL+8BCrfvAQlj7wEIL
+8BCAAAAAAAAAAAA+8BCAPvAQgD7wEJx+8BC/fvAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vA
Qv/7wEL/+8BC//vAQv/7wELD+8BCKfvAQgD7wEKC+8BC//vAQpz7wEIB+8BCAAAAAAD7wEIA+8BC
APvAQgn7wEIQ+8BCBfvAQgD7wEIAAAAAAAAAAAAAAAAA+8BCAPvAQhr7wELR+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7
wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC8vvAQpz7wEIh+8BCAPvAQkj7wELo+8BC//vA
QmT7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BC
APvAQmL7wEL8+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/
+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC+fvAQt/7wEKh+8BCRvvAQgf7
wEIB+8BCSfvAQtr7wEL/+8BC8PvAQjj7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAD7wEIA+8BCB/vAQrH7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC
//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL/+8BC//vAQv/7wEL8+8BC4vvAQq37wEJ2
+8BCTfvAQiD7wEID+8BCAPvAQh77wEKA+8BC6fvAQv/7wEL/+8BC2vvAQhv7wEIAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCKfvAQuX7wEL/+8BC//vA
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
QhH7wEKh+8BC/vvAQv/7wEL/+8BCxPvAQgz7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAD7wEID+8BCCvvAQgD7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA+8BCAPvAQgD7wEIV+8BCofvAQvz7wEL/+8BC3/vAQiD7wEIAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD7wEIA+8BCEfvAQo37
wEL2+8BC9fvAQkL7wEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAA+8BCAPvAQgj7wEJl+8BC4fvAQnb7wEIA+8BCAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAPvAQgD7wEIB+8BCPvvAQm/7wEIE
+8BCAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/j/////8AAP8H////
/wAA/gP/////AAD8Af////8AAPwA/////wAA/AA/////AAD8AAf///8AAPwAAAA//wAA/AAAAA//
AAD8AAAAB/8AAP8AAAAD/wAA/+AAAAH/AAD//AAAAP8AAP//AAAAfwAA///AAAB/AAD///AAAD8A
AP//4AAAPwAA//+AAAA/AAD//gAAAB8AAP/4AAAAHwAA/+AAAAAfAAD/wAAAAB8AAP+AAAAAHwAA
/wAAAAAfAAD+AAAAIA8AAPwAAAAABwAA+AAAAAAAAADwAAAAAAAAAPAAAAAEAQAA4AAAAAYDAADg
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
itEAAAAASUVORK5CYIIL'))
	#endregion
	$Remote_USMT_FirstRun.Icon = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$Remote_USMT_FirstRun.Margin = '5, 6, 5, 6'
	$Remote_USMT_FirstRun.MaximizeBox = $False
	$Remote_USMT_FirstRun.Name = 'Remote_USMT_FirstRun'
	$Remote_USMT_FirstRun.StartPosition = 'CenterScreen'
	$Remote_USMT_FirstRun.Text = 'USMT RemoteGUI First Run Wizard'
	$Remote_USMT_FirstRun.add_Load($Remote_USMT_FirstRun_Load)
	#
	# buttonCancel
	#
	$buttonCancel.Anchor = 'Bottom, Right'
	$buttonCancel.DialogResult = 'Cancel'
	$buttonCancel.Location = New-Object System.Drawing.Point(615, 543)
	$buttonCancel.Margin = '5, 6, 5, 6'
	$buttonCancel.Name = 'buttonCancel'
	$buttonCancel.Size = New-Object System.Drawing.Size(125, 42)
	$buttonCancel.TabIndex = 4
	$buttonCancel.Text = '&Cancel'
	$buttonCancel.UseCompatibleTextRendering = $True
	$buttonCancel.UseVisualStyleBackColor = $True
	#
	# buttonBack
	#
	$buttonBack.Anchor = 'Bottom, Left'
	$buttonBack.Location = New-Object System.Drawing.Point(22, 543)
	$buttonBack.Margin = '5, 6, 5, 6'
	$buttonBack.Name = 'buttonBack'
	$buttonBack.Size = New-Object System.Drawing.Size(125, 42)
	$buttonBack.TabIndex = 1
	$buttonBack.Text = '< &Back'
	$buttonBack.UseCompatibleTextRendering = $True
	$buttonBack.UseVisualStyleBackColor = $True
	$buttonBack.add_Click($buttonBack_Click)
	#
	# buttonBegin
	#
	$buttonBegin.Anchor = 'Bottom, Right'
	$buttonBegin.DialogResult = 'OK'
	$buttonBegin.Location = New-Object System.Drawing.Point(750, 543)
	$buttonBegin.Margin = '5, 6, 5, 6'
	$buttonBegin.Name = 'buttonBegin'
	$buttonBegin.Size = New-Object System.Drawing.Size(125, 42)
	$buttonBegin.TabIndex = 3
	$buttonBegin.Text = '&Begin'
	$buttonBegin.UseCompatibleTextRendering = $True
	$buttonBegin.UseVisualStyleBackColor = $True
	$buttonBegin.Visible = $False
	$buttonBegin.add_Click($buttonBegin_Click)
	#
	# tabcontrolWizard
	#
	$tabcontrolWizard.Controls.Add($tabpageStep1)
	$tabcontrolWizard.Controls.Add($tabpageStep2)
	$tabcontrolWizard.Anchor = 'Top, Bottom, Left, Right'
	$tabcontrolWizard.Font = [System.Drawing.Font]::new('Franklin Gothic Medium', '14.25')
	$tabcontrolWizard.ForeColor = [System.Drawing.SystemColors]::ControlText 
	$tabcontrolWizard.Location = New-Object System.Drawing.Point(22, 22)
	$tabcontrolWizard.Margin = '5, 6, 5, 6'
	$tabcontrolWizard.Name = 'tabcontrolWizard'
	$tabcontrolWizard.SelectedIndex = 0
	$tabcontrolWizard.Size = New-Object System.Drawing.Size(853, 510)
	$tabcontrolWizard.TabIndex = 0
	$tabcontrolWizard.add_Selecting($tabcontrolWizard_Selecting)
	$tabcontrolWizard.add_Deselecting($tabcontrolWizard_Deselecting)
	#
	# tabpageStep1
	#
	$tabpageStep1.Controls.Add($labelThisWillRunOnlyWhenA)
	$tabpageStep1.Controls.Add($buttonBrowse2)
	$tabpageStep1.Controls.Add($textboxFile)
	$tabpageStep1.Controls.Add($textbox1)
	$tabpageStep1.Controls.Add($labelRequiredDomainComput)
	$tabpageStep1.Controls.Add($labelOnASharedDriveBothYo)
	$tabpageStep1.Controls.Add($labelScanstateexeLocation)
	$tabpageStep1.Controls.Add($labelFirstStartWizard)
	$tabpageStep1.Controls.Add($labelUSMTRemoteGUI)
	$tabpageStep1.Location = New-Object System.Drawing.Point(4, 33)
	$tabpageStep1.Margin = '5, 6, 5, 6'
	$tabpageStep1.Name = 'tabpageStep1'
	$tabpageStep1.Padding = '5, 6, 5, 6'
	$tabpageStep1.Size = New-Object System.Drawing.Size(845, 473)
	$tabpageStep1.TabIndex = 0
	$tabpageStep1.Text = 'Step1'
	$tabpageStep1.UseVisualStyleBackColor = $True
	#
	# labelThisWillRunOnlyWhenA
	#
	$labelThisWillRunOnlyWhenA.AutoSize = $True
	$labelThisWillRunOnlyWhenA.ForeColor = [System.Drawing.Color]::Tomato 
	$labelThisWillRunOnlyWhenA.Location = New-Object System.Drawing.Point(383, 18)
	$labelThisWillRunOnlyWhenA.Margin = '5, 0, 5, 0'
	$labelThisWillRunOnlyWhenA.Name = 'labelThisWillRunOnlyWhenA'
	$labelThisWillRunOnlyWhenA.Size = New-Object System.Drawing.Size(436, 24)
	$labelThisWillRunOnlyWhenA.TabIndex = 13
	$labelThisWillRunOnlyWhenA.Text = 'This will run only when a configuration is not present'
	#
	# buttonBrowse2
	#
	$buttonBrowse2.Location = New-Object System.Drawing.Point(627, 160)
	$buttonBrowse2.Margin = '5, 6, 5, 6'
	$buttonBrowse2.Name = 'buttonBrowse2'
	$buttonBrowse2.Size = New-Object System.Drawing.Size(50, 42)
	$buttonBrowse2.TabIndex = 1
	$buttonBrowse2.Text = '...'
	$buttonBrowse2.UseVisualStyleBackColor = $True
	$buttonBrowse2.add_Click($buttonBrowse2_Click)
	#
	# textboxFile
	#
	$textboxFile.AutoCompleteMode = 'SuggestAppend'
	$textboxFile.AutoCompleteSource = 'FileSystem'
	$textboxFile.Location = New-Object System.Drawing.Point(33, 166)
	$textboxFile.Margin = '5, 6, 5, 6'
	$textboxFile.Name = 'textboxFile'
	$textboxFile.Size = New-Object System.Drawing.Size(584, 29)
	$textboxFile.TabIndex = 0
	#
	# textbox1
	#
	$textbox1.BackColor = [System.Drawing.Color]::Wheat 
	$textbox1.Location = New-Object System.Drawing.Point(26, 220)
	$textbox1.Margin = '5, 6, 5, 6'
	$textbox1.Multiline = $True
	$textbox1.Name = 'textbox1'
	$textbox1.ScrollBars = 'Horizontal'
	$textbox1.Size = New-Object System.Drawing.Size(651, 133)
	$textbox1.TabIndex = 12
	$textbox1.Text = 'This directory contains files such as scanstate.exe and loadstate.exe.  This is best located on a shared drive both yourself and the target PC can access.  Special permissions are  required.  "Domain computers" should have Read access to this directory and child objects.  This was likely already setup.  The path will resemble \\hostname\share'
	$textbox1.add_TextChanged($textbox1_TextChanged)
	#
	# labelRequiredDomainComput
	#
	$labelRequiredDomainComput.AutoSize = $True
	$labelRequiredDomainComput.Location = New-Object System.Drawing.Point(23, 316)
	$labelRequiredDomainComput.Margin = '5, 0, 5, 0'
	$labelRequiredDomainComput.Name = 'labelRequiredDomainComput'
	$labelRequiredDomainComput.Size = New-Object System.Drawing.Size(0, 24)
	$labelRequiredDomainComput.TabIndex = 11
	#
	# labelOnASharedDriveBothYo
	#
	$labelOnASharedDriveBothYo.AutoSize = $True
	$labelOnASharedDriveBothYo.Location = New-Object System.Drawing.Point(21, 277)
	$labelOnASharedDriveBothYo.Margin = '5, 0, 5, 0'
	$labelOnASharedDriveBothYo.Name = 'labelOnASharedDriveBothYo'
	$labelOnASharedDriveBothYo.Size = New-Object System.Drawing.Size(0, 24)
	$labelOnASharedDriveBothYo.TabIndex = 10
	#
	# labelScanstateexeLocation
	#
	$labelScanstateexeLocation.AutoSize = $True
	$labelScanstateexeLocation.Location = New-Object System.Drawing.Point(21, 136)
	$labelScanstateexeLocation.Margin = '5, 0, 5, 0'
	$labelScanstateexeLocation.Name = 'labelScanstateexeLocation'
	$labelScanstateexeLocation.Size = New-Object System.Drawing.Size(198, 24)
	$labelScanstateexeLocation.TabIndex = 8
	$labelScanstateexeLocation.Text = 'Scanstate.exe Location'
	#
	# labelFirstStartWizard
	#
	$labelFirstStartWizard.AutoSize = $True
	$labelFirstStartWizard.ForeColor = [System.Drawing.Color]::DarkOrange 
	$labelFirstStartWizard.Location = New-Object System.Drawing.Point(100, 30)
	$labelFirstStartWizard.Margin = '5, 0, 5, 0'
	$labelFirstStartWizard.Name = 'labelFirstStartWizard'
	$labelFirstStartWizard.Size = New-Object System.Drawing.Size(151, 24)
	$labelFirstStartWizard.TabIndex = 7
	$labelFirstStartWizard.Text = 'First Start Wizard'
	#
	# labelUSMTRemoteGUI
	#
	$labelUSMTRemoteGUI.AutoSize = $True
	$labelUSMTRemoteGUI.ForeColor = [System.Drawing.Color]::DarkOrange 
	$labelUSMTRemoteGUI.Location = New-Object System.Drawing.Point(23, 6)
	$labelUSMTRemoteGUI.Margin = '5, 0, 5, 0'
	$labelUSMTRemoteGUI.Name = 'labelUSMTRemoteGUI'
	$labelUSMTRemoteGUI.Size = New-Object System.Drawing.Size(159, 24)
	$labelUSMTRemoteGUI.TabIndex = 6
	$labelUSMTRemoteGUI.Text = 'USMT Remote GUI'
	#
	# tabpageStep2
	#
	$tabpageStep2.Controls.Add($picturebox1)
	$tabpageStep2.Controls.Add($textbox2)
	$tabpageStep2.Controls.Add($buttonBrowseFolder)
	$tabpageStep2.Controls.Add($textboxFolder)
	$tabpageStep2.Controls.Add($label1)
	$tabpageStep2.Controls.Add($labelWhichTheyWillBeTheOw)
	$tabpageStep2.Controls.Add($labelDomainComputersShoul)
	$tabpageStep2.Controls.Add($labelUntilTheyAreNeededTo)
	$tabpageStep2.Controls.Add($labelThisIsTheLocationWhe)
	$tabpageStep2.Controls.Add($labelUSMTProfileStorageLo)
	$tabpageStep2.Location = New-Object System.Drawing.Point(4, 33)
	$tabpageStep2.Margin = '5, 6, 5, 6'
	$tabpageStep2.Name = 'tabpageStep2'
	$tabpageStep2.Padding = '5, 6, 5, 6'
	$tabpageStep2.Size = New-Object System.Drawing.Size(845, 473)
	$tabpageStep2.TabIndex = 1
	$tabpageStep2.Text = 'Step2'
	$tabpageStep2.UseVisualStyleBackColor = $True
	#
	# picturebox1
	#
	$picturebox1.Anchor = 'Top, Right'
	#region Binary Data
	$Formatter_binaryFomatter = New-Object System.Runtime.Serialization.Formatters.Binary.BinaryFormatter
	$System_IO_MemoryStream = New-Object System.IO.MemoryStream (,[byte[]][System.Convert]::FromBase64String('
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'))
	#endregion
	$picturebox1.Image = $Formatter_binaryFomatter.Deserialize($System_IO_MemoryStream)
	$Formatter_binaryFomatter = $null
	$System_IO_MemoryStream = $null
	$picturebox1.Location = New-Object System.Drawing.Point(692, 336)
	$picturebox1.Name = 'picturebox1'
	$picturebox1.Size = New-Object System.Drawing.Size(145, 109)
	$picturebox1.SizeMode = 'StretchImage'
	$picturebox1.TabIndex = 15
	$picturebox1.TabStop = $False
	#
	# textbox2
	#
	$textbox2.BackColor = [System.Drawing.Color]::Wheat 
	$textbox2.Location = New-Object System.Drawing.Point(42, 166)
	$textbox2.Margin = '5, 6, 5, 6'
	$textbox2.Multiline = $True
	$textbox2.Name = 'textbox2'
	$textbox2.ReadOnly = $True
	$textbox2.Size = New-Object System.Drawing.Size(643, 186)
	$textbox2.TabIndex = 11
	$textbox2.Text = 'This is the location where your backed up profiles will stay until they are needed to restore the profile on another PC. ''Domain computers'' should have write access to this location to create folders Which they will be the owner of.  
This is also likely already setup.  The path will also resemble \\hostname\sharename
'
	#
	# buttonBrowseFolder
	#
	$buttonBrowseFolder.Location = New-Object System.Drawing.Point(664, 80)
	$buttonBrowseFolder.Margin = '5, 6, 5, 6'
	$buttonBrowseFolder.Name = 'buttonBrowseFolder'
	$buttonBrowseFolder.Size = New-Object System.Drawing.Size(50, 42)
	$buttonBrowseFolder.TabIndex = 4
	$buttonBrowseFolder.Text = '...'
	$buttonBrowseFolder.UseVisualStyleBackColor = $True
	$buttonBrowseFolder.add_Click($buttonBrowseFolder_Click3)
	#
	# textboxFolder
	#
	$textboxFolder.AutoCompleteMode = 'SuggestAppend'
	$textboxFolder.AutoCompleteSource = 'FileSystemDirectories'
	$textboxFolder.Location = New-Object System.Drawing.Point(42, 86)
	$textboxFolder.Margin = '5, 6, 5, 6'
	$textboxFolder.Name = 'textboxFolder'
	$textboxFolder.Size = New-Object System.Drawing.Size(612, 29)
	$textboxFolder.TabIndex = 3
	#
	# label1
	#
	$label1.AutoSize = $True
	$label1.ForeColor = [System.Drawing.Color]::DarkOrange 
	$label1.Location = New-Object System.Drawing.Point(39, 16)
	$label1.Margin = '5, 0, 5, 0'
	$label1.Name = 'label1'
	$label1.Size = New-Object System.Drawing.Size(151, 24)
	$label1.TabIndex = 10
	$label1.Text = 'First Start Wizard'
	#
	# labelWhichTheyWillBeTheOw
	#
	$labelWhichTheyWillBeTheOw.AutoSize = $True
	$labelWhichTheyWillBeTheOw.Location = New-Object System.Drawing.Point(39, 228)
	$labelWhichTheyWillBeTheOw.Margin = '5, 0, 5, 0'
	$labelWhichTheyWillBeTheOw.Name = 'labelWhichTheyWillBeTheOw'
	$labelWhichTheyWillBeTheOw.Size = New-Object System.Drawing.Size(0, 24)
	$labelWhichTheyWillBeTheOw.TabIndex = 9
	#
	# labelDomainComputersShoul
	#
	$labelDomainComputersShoul.AutoSize = $True
	$labelDomainComputersShoul.Location = New-Object System.Drawing.Point(39, 190)
	$labelDomainComputersShoul.Margin = '5, 0, 5, 0'
	$labelDomainComputersShoul.Name = 'labelDomainComputersShoul'
	$labelDomainComputersShoul.Size = New-Object System.Drawing.Size(0, 24)
	$labelDomainComputersShoul.TabIndex = 8
	#
	# labelUntilTheyAreNeededTo
	#
	$labelUntilTheyAreNeededTo.AutoSize = $True
	$labelUntilTheyAreNeededTo.Location = New-Object System.Drawing.Point(39, 155)
	$labelUntilTheyAreNeededTo.Margin = '5, 0, 5, 0'
	$labelUntilTheyAreNeededTo.Name = 'labelUntilTheyAreNeededTo'
	$labelUntilTheyAreNeededTo.Size = New-Object System.Drawing.Size(0, 24)
	$labelUntilTheyAreNeededTo.TabIndex = 7
	#
	# labelThisIsTheLocationWhe
	#
	$labelThisIsTheLocationWhe.AutoSize = $True
	$labelThisIsTheLocationWhe.Location = New-Object System.Drawing.Point(39, 120)
	$labelThisIsTheLocationWhe.Margin = '5, 0, 5, 0'
	$labelThisIsTheLocationWhe.Name = 'labelThisIsTheLocationWhe'
	$labelThisIsTheLocationWhe.Size = New-Object System.Drawing.Size(0, 24)
	$labelThisIsTheLocationWhe.TabIndex = 6
	#
	# labelUSMTProfileStorageLo
	#
	$labelUSMTProfileStorageLo.AutoSize = $True
	$labelUSMTProfileStorageLo.Location = New-Object System.Drawing.Point(39, 55)
	$labelUSMTProfileStorageLo.Margin = '5, 0, 5, 0'
	$labelUSMTProfileStorageLo.Name = 'labelUSMTProfileStorageLo'
	$labelUSMTProfileStorageLo.Size = New-Object System.Drawing.Size(256, 24)
	$labelUSMTProfileStorageLo.TabIndex = 5
	$labelUSMTProfileStorageLo.Text = 'USMT Profile Storage Location'
	#
	# buttonNext
	#
	$buttonNext.Anchor = 'Bottom, Right'
	$buttonNext.Location = New-Object System.Drawing.Point(480, 543)
	$buttonNext.Margin = '5, 6, 5, 6'
	$buttonNext.Name = 'buttonNext'
	$buttonNext.Size = New-Object System.Drawing.Size(125, 42)
	$buttonNext.TabIndex = 2
	$buttonNext.Text = '&Next >'
	$buttonNext.UseCompatibleTextRendering = $True
	$buttonNext.UseVisualStyleBackColor = $True
	$buttonNext.add_Click($buttonNext_Click)
	#
	# scanstatelocation
	#
	$scanstatelocation.DefaultExt = 'exe'
	$scanstatelocation.Filter = 'scanstate.exe|scanstate.exe|All Files|*.*'
	$scanstatelocation.InitialDirectory = 'C:\'
	$scanstatelocation.ShowHelp = $True
	#
	# folderbrowsermoderndialog1
	#
	$picturebox1.EndInit()
	$tabpageStep2.ResumeLayout()
	$tabpageStep1.ResumeLayout()
	$tabcontrolWizard.ResumeLayout()
	$Remote_USMT_FirstRun.ResumeLayout()
	#endregion Generated Form Code

	#----------------------------------------------

	#Save the initial state of the form
	$InitialFormWindowState = $Remote_USMT_FirstRun.WindowState
	#Init the OnLoad event to correct the initial state of the form
	$Remote_USMT_FirstRun.add_Load($Form_StateCorrection_Load)
	#Clean up the control events
	$Remote_USMT_FirstRun.add_FormClosed($Form_Cleanup_FormClosed)
	#Store the control values when form is closing
	$Remote_USMT_FirstRun.add_Closing($Form_StoreValues_Closing)
	#Show the Form
	return $Remote_USMT_FirstRun.ShowDialog()

}
#endregion Source: starting.psf

#Start the application
Main ($CommandLine)
