#!/usr/bin/env bash
#
# insert_header.sh
#
# Insère le contenu d'un fichier d'en-tête au début de fichiers correspondant
# à un motif (pattern).
# Exemple d'utilisation :
#   ./insert_header.sh src/standard_header_fr.md "FR_fr/*.md"
# 
# ATTENTION : ce script modifie directement les fichiers originaux.
# Assurez-vous d'avoir fait une sauvegarde ou un commit Git préalable.

fichier_entete="$1"
motif="$2"

# Vérification des paramètres
if [ -z "$fichier_entete" ] || [ -z "$motif" ]; then
  echo "Utilisation : $0 <fichier_entete> <motif_fichiers>"
  exit 1
fi

# Vérifie que le fichier d'en-tête existe
if [ ! -f "$fichier_entete" ]; then
  echo "Fichier d'en-tête introuvable : $fichier_entete"
  exit 1
fi

# Parcourt chaque fichier correspondant au motif
for fichier_cible in $motif; do
  # Vérifie qu'il s'agit bien d'un fichier et qu'il n'est pas le fichier d'en-tête lui-même
  if [ -f "$fichier_cible" ] && [ "$fichier_cible" != "$fichier_entete" ]; then
    # Crée un fichier temporaire
    temp_file="$(mktemp)"

    # Concatène l'en-tête + le contenu original
    cat "$fichier_entete" "$fichier_cible" > "$temp_file"

    # Remplace le fichier cible par la nouvelle version
    mv "$temp_file" "$fichier_cible"

    echo "En-tête inséré dans : $fichier_cible"
  fi
done 