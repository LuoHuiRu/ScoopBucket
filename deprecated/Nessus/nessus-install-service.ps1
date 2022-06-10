$params = @{
  Name           = 'Nessus'
  DisplayName    = 'Nessus'
  BinaryPathName = '&NessusPath'
  Description    = 'Tenable Nessus Network Security Scanner'
  StartupType    = 'Manual'
}

New-Service @params


