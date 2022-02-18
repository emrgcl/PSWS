Configuration MyApplicationServer {
    [CmdletBinding()]
    Param(
        $HostName,
        $FolderName
    )
    Import-DscResource -ModuleName PSDesiredStateConfiguration
    Node $HostName {

        File TempFolder {
            DestinationPath = $FolderName
            Ensure = 'Present'
            Type = 'Directory'
        }

    }
}