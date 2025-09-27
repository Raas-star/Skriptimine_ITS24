#!/bin/bash
# Skript: loo uus kasutaja ja kodukataloog koos tervitusfailiga
# Lisaks saab käsurealt määrata grupi, vaikimisi on "kylaline"

# Käsurealt argument: grupp (kui ei anta, kasutatakse vaikimisi "kylaline")
GROUP=${1:-kylaline}

# Küsi kasutajanime
read -p "Sisesta kasutajanimi: " USERNAME

# Küsi parooli, trükkimisel ei kuvata
read -s -p "Sisesta parool: " PASSWORD
echo  # lihtsalt reavahetus, et prompt järgmisele reale läheks

# Loo uus kasutaja ja määra parool
# -m loob kodukataloogi /home/kasutajanimi
# -G lisab kasutaja määratud gruppi
sudo useradd -m -G "$GROUP" "$USERNAME"
echo "$USERNAME:$PASSWORD" | sudo chpasswd

# Loo kataloog kodukataloogis (nt /home/kasutajanimi/kataloog)
sudo mkdir -p "/home/$USERNAME/kataloog"

# Loo tervitusfail kataloogi
echo "Tere tulemast, $USERNAME!" | sudo tee "/home/$USERNAME/kataloog/teretulemast_$USERNAME.txt"

# Muuda fail ja kataloogi omanikuks vastav kasutaja
sudo chown -R "$USERNAME:$GROUP" "/home/$USERNAME/kataloog"

# Teade lõpetamisest
echo "Kasutaja $USERNAME loodud, kataloog ja tervitusfail valmis."

