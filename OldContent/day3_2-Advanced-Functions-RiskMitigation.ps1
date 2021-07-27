# whatif ve confirm desteği ekleyerek risk mitigationı hayata geçireceğiz.
Function do-sth {

[CmdletBinding(

    SupportsShouldProcess=$true,
    ConfirmImpact='Medium'  # 'High' yaparsanız mecburen confirm etttirtirsiniz
)]
Param(
    #[Parameter(Mandatory=$true)]
    [ValidateNotNullOrEmpty()]
    [string]$Name,
    #[Parameter(Mandatory=$true)]
    [ValidateRange(7,47)]
    [int32]$Age,
    [ValidatePattern('\S+@\S+\.\S{3}')]
    [string]$UserName,
    [ValidateScript({
        
        if ($_ -eq $env:windir) {

        $false


        } else {test-path $_
        }
    
    })]
    [string]$HomeFolder,
    [ValidateSet('A','B','C','D','E')]
    [string]$PerformanceGrade



)


        if ($pscmdlet.ShouldProcess($Name, "Reporting Confidential Info"))
        {
            
            "$Name is $Age years old and his username is $USerName. Home folder for $Name is: $HomeFolder. Performance Grade: $PerformanceGrade"
            
        }



}
