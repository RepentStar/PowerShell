function File {
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
        [string]$file
    )
    process {
        Get-Item -Path $file | Format-List *
    }
}
