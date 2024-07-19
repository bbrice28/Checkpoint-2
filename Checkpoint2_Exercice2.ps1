Start-Process -FilePath "powershell.exe" -ArgumentList "C:\Temp\AddLocalUsers.ps1" -Verb RunAs -WindowStyle Maximized

#Q2.1
#Sur le serveur, je mets dans une variable “$session” la commande de remoting vers le client.
#Puis je copie chaque fichier depuis le serveur vers le dossier scripts sur le client, en précisant avec “to session” la session de remoting.

#Q2.2
#Il ne se passe rien à l'exécution.
#Il y a une erreur sur le chemin du script. Une fois modifié le script se lance

#Q2.3
#L’option “Verb RunAs” sert à exécuter un script avec les privilèges administratifs.

#Q2.4
#L’option “WindowsStyle Maximized” permet d’ouvrir la fenêtre en grand écran.



SCRIPT2:


Write-Host "--- D�but du script ---"

Function Random-Password ($length = 12)
{
    $punc = 46..46
    $digits = 48..57
    $letters = 65..90 + 97..122

    $password = get-random -count $length -input ($punc + $digits + $letters) |`
        ForEach -begin { $aa = $null } -process {$aa += [char]$_} -end {$aa}
    Return $password.ToString()
}

Function ManageAccentsAndCapitalLetters
{
    param ([String]$String)
    
    $StringWithoutAccent = $String -replace '[����]', 'e' -replace '[���]', 'a' -replace '[��]', 'i' -replace '[��]', 'o' -replace '[���]', 'u'
    $StringWithoutAccentAndCapitalLetters = $StringWithoutAccent.ToLower()
    $StringWithoutAccentAndCapitalLetters
}

$Path = "C:\Scripts"
$CsvFile = "$Path\Users.csv"
$LogFile = "$Path\Log.log"

$Users = Import-Csv -Path $CsvFile -Delimiter ";" -Header "prenom","nom","societe","fonction","service","description","mail","mobile","scriptPath","telephoneNumber" -Encoding UTF8  | Select-Object -Skip 1

foreach ($User in $Users)
{
    $Prenom = ManageAccentsAndCapitalLetters -String $User.prenom
    $Nom = ManageAccentsAndCapitalLetters -String $User.Nom
    $Name = "$Prenom.$Nom"
    If (-not(Get-LocalUser -Name "$Prenom.$Nom" -ErrorAction SilentlyContinue))
    {
        $Pass = Random-Password
        $Password = (ConvertTo-secureString $Pass -AsPlainText -Force)
        $Description = "$($user.description) - $($User.fonction)"
        $UserInfo = @{
            Name                 = "$Name"
            FullName             = "$Name"
            Password             = $Password
            AccountNeverExpires  = $true
            PasswordNeverExpires = $false
            Description          =  -String $User.description
            societe              = -String $User.societe
            fontion              = -String $User.fonction

            service              = -String $User.service
            mail                 = -String $User.mail
            mobile               = -String $User.mobile
            telephonenumber      = -String $User.TelephoneNumber
        }

        New-LocalUser @UserInfo -PasswordNeverExpires Strue
        Add-LocalGroupMember -Group "Utilisateur" -Member "$Name"
        Write-Host "L'utilisateur $Name a �t� cr�e"
    }
    Else {
    Write-host "l'utilisateur $user existe déjà" -ForegroundColor Red
}
Import-Module "C:\Scripts\Functions.psm1"|
Log -Message
"Lescript Addlocalusers.ps1 a été executé avec succès" -Level "Info" 
pause
 Write-host "Le compte $user a été crée avec le mot de passe $password"  -ForegroundColor Green
Write-Host "--- Fin du script ---"
Start-Sleep 

#Q2.1
#Sur le serveur, je mets dans une variable “$session” la commande de remoting vers le client.
#Puis je copie chaque fichier depuis le serveur vers le dossier scripts sur le client, en précisant avec “to session” la session de remoting.

#Q2.2
#Il ne se passe rien à l'exécution.
#Il y a une erreur sur le chemin du script. Une fois modifié le script se lance

#Q2.3
#L’option “Verb RunAs” sert à exécuter un script avec les privilèges administratifs.

#Q2.4
#L’option “WindowsStyle Maximized” permet d’ouvrir la fenêtre en grand écran.

#Q2.5
#L’option “select object” est en “skip 2”, soit “commencer la lecture du fichier à la ligne 3”. Il faudrait le modifier en “skip 1” pour qu’il prenne en compte le premier nom, soit la ligne 2.

#Q2.9
#Il faut importer la fonction avec “Import-Module “C:\Scripts\Functions.psm1” .
#Puis, Option 1, à l’issue du script appeler cette fonction Log en y ajoutant un message.
#Ou, Option 2, Appeler la fonction log Étape par étape dans le script.
# Je pars sur l'option 1 dans le script.

#Q2.11
#Je ne sais pas comment faire autrement que la manière déjà présente dans le script.


#Q2.16
#Il permet à powershell de comprendre que les accents et majuscules dans les cellules du CSV font partie des paramètres et non un commande powershell.
#Par exemple “Anaïs” restera “Anaïs” et non “Anais”.
