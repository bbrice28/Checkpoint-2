# Q.1.1

Après avoir fait `ipconfig` dans l’invite de commande du Windows client, je tape `ping 172.16.100.50` dans l’invite de commande du serveur. Et le ping échoue.

<img width="637" alt="Capture d’écran 2024-07-19 à 09 17 54" src="https://github.com/user-attachments/assets/4c9329a4-75cc-4fc7-a032-02698232141c">

Après vérification sur le serveur avec un `ipconfig`, je remarque que les ne sont pas sur le même réseau. Je modifie donc l’adresse du client en 172.16.10.13 et j’active les pare-feux pour être sûr que tout fonctionne avec la commande :
New-NetFirewallRule -Name "Allow-ICMPv4-In" -DisplayName "Allow ICMPv4 Inbound" -Protocol ICMPv4 -IcmpType 8 -Direction Inbound -Action Allow

<img width="618" alt="Capture d’écran 2024-07-19 à 09 40 25" src="https://github.com/user-attachments/assets/a82d6eeb-459c-4d7e-88d7-88fa0fd9734a">

# Q.1.2

Après avoir récupéré le nom de la machine cliente avec la commande `hostname`, je fais un ping avec la commande `ping client1` sur le serveur. Le ping marche.

<img width="526" alt="Capture d’écran 2024-07-19 à 09 44 41" src="https://github.com/user-attachments/assets/50e153a1-6815-4d2f-b4be-8758bdf3eb6a">

# Q.1.3

Je vais dans les paramètres réseaux, je clique sur "propriétés" sur mon interface Ethernet et je décoche IPV6.

<img width="290" alt="Capture d’écran 2024-07-19 à 09 47 20" src="https://github.com/user-attachments/assets/4aa6e2a4-7481-4cba-82c8-b83391bba388">

Je refais mon ping vers Client1 depuis le serveur. Le ping marche toujours.

# Q.1.4

Je vois sur mon serveur manager que le DHCP est activé.

<img width="580" alt="Capture d’écran 2024-07-19 à 09 50 51" src="https://github.com/user-attachments/assets/dc3cdb1f-d800-4c8a-ac97-f7df8cd96ea3">

Sur le client, je vais dans les paramètres réseaux, je clique sur "propriétés" sur mon interface Ethernet, et je switch en "Automatique (DHCP)".

<img width="320" alt="Capture d’écran 2024-07-19 à 12 22 42" src="https://github.com/user-attachments/assets/4facdb88-84a3-46e1-93c0-e83ba9119fda">


Je fais un `ipconfig` sur le client et j’obtiens une nouvelle adresse IPv4 : 172.16.10.20.

# Q.1.5

<img width="480" alt="Capture d’écran 2024-07-19 à 09 52 21" src="https://github.com/user-attachments/assets/75d78c08-83b6-4c71-86ed-ecd7b83c9b59">

# Q.1.6

Sur le server manager, je vais dans Tools, puis je navigue dans les menus du serveur jusqu’à "IPV4" puis "Scope" puis "réservations". Là, je fais une nouvelle réservation dans laquelle je note l’adresse MAC relevée dans le menu Ethernet du client, la nouvelle adresse IPv4 et le nom "client1". Je coche DHCP et je valide le tout.

<img width="444" alt="Capture d’écran 2024-07-19 à 10 03 53" src="https://github.com/user-attachments/assets/e91c077f-aa22-43b4-8060-893b30c57398">

# Q.1.7

Passer ce réseau en IPV6 permet d’automatiser immédiatement l’adressage sans avoir à passer par le DHCP. L’adressage se fait automatiquement.

# Q.1.8

Le serveur DHCP n’est pour autant pas obsolète, puisqu’il permet de centraliser les adressages, mais aussi de pouvoir générer des adresses supplémentaires si cela est nécessaire. Pour ce faire, il suffit de naviguer dans le menu DHCP comme précédemment, mais d’ajouter une nouvelle plage dans le sous-menu IPV6.
