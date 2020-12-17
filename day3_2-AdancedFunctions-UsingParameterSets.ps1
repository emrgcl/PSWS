Function test-parametersets {

[CmdletBinding(

    DefaultParameterSetName = 'FullName'

)]
Param(
    
    [Parameter(ParameterSetName='Name')]
    [string]$Name,
    [Parameter(ParameterSetName='FullName')]
    [string]$FullName,
    [int32]$Age

)

switch ($PSCmdlet.ParameterSetName)
{
    'Name' {"Merhaba $Name!"}
    'FullName' {"Merhaba Sayın, $FullName"}
}



}