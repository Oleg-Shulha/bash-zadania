if [ $# -ne 1 ]; then
    echo "Použitie: $0 <URL>" >&2
    exit 1
fi

# Fáza 5: názov servera
SERVER=$(echo "$1" | cut -d / -f 3)

# Fázy 1–4, 6
curl -s "$1" \
    | tr -d '\n' \
    | tr '<' '\n' \
    | grep -i '^img ' \
    | sed -n 's/.*src="\([^"]*\)".*/\1/p' \
    | while read -r LINE
do
    if echo "$LINE" | grep '^https:' > /dev/null
    then
        curl -s -O "$LINE"
    else
        curl -s -O "https://${SERVER}${LINE}"
    fi
done

