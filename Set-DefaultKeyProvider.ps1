function Set-DefaultKeyProvider {
    try {
        # Get a list of key providers
        $keyProviders = Get-KeyProvider

        # Select the key provider with the name 'ABCD'
        $selectedKeyProvider = $keyProviders | Where-Object { $_.Name -eq 'ABCD' }

        if ($selectedKeyProvider -ne $null) {
            # Set the selected key provider as default for the system
            Set-KeyProvider -KeyProvider $selectedKeyProvider -DefaultForSystem
            Write-Host "KeyProvider 'ABCD' set as default for the system."
        }
        else {
            Write-Host "KeyProvider 'ABCD' not found."
            return $null
        }
    } catch {
        Write-Host "An error occurred while setting the default key provider: $_"
        return $null
    }
    
    return $selectedKeyProvider
}

function Update-ClusterDefaultKeyProvider {
    param (
        [Parameter(Mandatory=$true)]
        [object]$KeyProvider,
        
        [Parameter(Mandatory=$true)]
        [string]$ClusterName
    )

    try {
        # Update 'ABCD' as the default key provider for the specified cluster
        Add-EntityDefaultKeyProvider -KeyProvider $KeyProvider -Entity $ClusterName
        Write-Host "KeyProvider 'ABCD' set as default for cluster '$ClusterName'."
    } catch {
        Write-Host "An error occurred while updating the default key provider for cluster '$ClusterName': $_"
    }
}

# Example usage:
$kProvider = Set-DefaultKeyProvider
if ($kProvider -ne $null) {
    Update-ClusterDefaultKeyProvider -KeyProvider $kProvider -ClusterName 'BYCD'
} else {
    Write-Host "Unable to proceed with updating the cluster default key provider due to an earlier error."
}
