# Usage:
## .\winhash.ps1 <FILE> <ALGO>
## Algos Supported:
### MD5
### SHA1
### SHA256
### SHA384
### SHA512
## Example:
### .\winhash.ps1 sillyfilly.bin SHA256
## Outputs to terminal and to a text file
### Text file name format <input filepath>.<unix epoch microseconds>.<hashing algorithm>.txt

param (
    [Parameter(Mandatory=$true)]
    [string]$infile,

    [Parameter(Mandatory=$true)]
    [string]$algo
)

function Get-UnixMicroseconds {
    $unixEpoch = [DateTimeOffset]'1970-01-01T00:00:00Z' # unix epoch constant
    $currentTime = [DateTimeOffset]::UtcNow # current utc time
    $timeDifferenceTicks = $currentTime.Ticks - $unixEpoch.Ticks # subtract current time from unix epoch constant in ticks
    $microseconds = [Int64]($timeDifferenceTicks / 10) # use 64bit int, divide ticks by 10 to give microseconds

    return $microseconds
}

$hash = $(Get-FileHash -Path $infile -Algorithm $algo | Format-List) # do da fookin hashin right dafucc here
echo $hash # show user
echo $hash > "$infile.$(Get-UnixMicroseconds).$algo.txt" 