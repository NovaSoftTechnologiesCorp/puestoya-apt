#!/bin/sh
# Agrega el repositorio de PuestoYa a apt (Ubuntu 22.04+ y Debian 12+).
# Después: sudo apt install puestoya. Las actualizaciones llegan con apt upgrade.
set -e
URL=https://novasofttechnologiescorp.github.io/puestoya-apt
[ "$(id -u)" = 0 ] || { echo "Corre este instalador con sudo." >&2; exit 1; }
install -d -m 0755 /etc/apt/keyrings
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$URL/puestoya.gpg" -o /etc/apt/keyrings/puestoya.gpg
else
  wget -qO /etc/apt/keyrings/puestoya.gpg "$URL/puestoya.gpg"
fi
chmod 0644 /etc/apt/keyrings/puestoya.gpg
cat > /etc/apt/sources.list.d/puestoya.sources <<SRC
Types: deb
URIs: $URL
Suites: stable
Components: main
Architectures: amd64
Signed-By: /etc/apt/keyrings/puestoya.gpg
SRC
apt-get update -o Dir::Etc::sourcelist=sources.list.d/puestoya.sources -o Dir::Etc::sourceparts=- -o APT::Get::List-Cleanup=0 >/dev/null
echo "Listo. Ahora: sudo apt install puestoya"
