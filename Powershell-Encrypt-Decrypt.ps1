Function Encrypt{
    Param(
        [Parameter(Mandatory=$true)]
        [string]$decrypted_pass,
        [Parameter(Mandatory=$true)]
        [string]$encryption_key
    )
    $move_by=0
    for ($i = 0; $i -le $encryption_key.Length; $i++){
        $move_by+=[byte][char]$encryption_key[$i]
    }
    $encrypt_by=($move_by % 94)-32
    $temp=@{}
    for ($j = 0; $j -le $decrypted_pass.Length; $j++){
        $temp[$j]=[byte][char]$decrypted_pass[$j] + $encrypt_by
        if($temp[$j] -gt 126){
            $temp[$j]=$temp[$j]-126+32
        }
    }
    $encrypted_pass=""
    for ($k = 0; $k -le $temp.Count; $k++){
        $encrypted_pass+=[char]$temp[$k]
    }
    Set-Clipboard $encrypted_pass
}
Function Decrypt($encrypted_pass, $encryption_key){

    Set-Clipboard $decrypted_pass
}

# MIGHT BE WORTH TO USE PASSWORD PROMPT AS PER BELOW 
#$password_input=Read-Host -Prompt "Password to encrypt" -AsSecureString
#[byte][char]$Char
#in test123
#in abcd
#convert test123 to t e s t 1 2 3
#convert abcd to a+b+c+d = x
#move t by x move e by x move s by x
#65-90
#97-122
#32-126
#
#
#
#
#
#