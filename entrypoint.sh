#!/bin/sh
echo
echo "  ____  _ _   _        ";
echo " |  _ \(_) |_| |_ ___  ";
echo " | | | | | __| __/ _ \ ";
echo " | |_| | | |_| || (_) |";
echo " |____/|_|\__|\__\___/ ";
echo "                       ";
echo "Ditto's website: https://docs.soapbox.pub/ditto"
echo "Ditto's documentation: https://docs.soapbox.pub/ditto"
echo "Ditto's Nostr: https://njump.me/npub10qdp2fc9ta6vraczxrcs8prqnv69fru2k6s2dj48gqjcylulmtjsg9arpj"
echo
ENV_NSEC=$(grep "^DITTO_NSEC=" .env)
DITTO_NSEC=$(echo "$ENV_NSEC" | cut -d'=' -f2)
echo "Docker compose variables provided:"
echo "SENTRY_DSN    : $SENTRY_DSN"
echo "DITTO_NSEC    : $DITTO_NSEC"
echo "ADMIN_HEX_KEY : $ADMIN_HEX_KEY"
echo
if [ -f "docker_setup_done" ]; then
    echo "Ditto has already been configured. Nothing to do."
else
    echo "Starting Ditto for the first time..."
    echo "Starting Ditto's configuration..."
    echo "Making user $ADMIN_HEX_KEY Ditto's admin..."
    echo
    deno task admin:role $ADMIN_HEX_KEY admin
    echo
    echo "Copying Ditto images..."
    cp favicon.ico static/
    cp favicon.ico public/
    mkdir public/instance/images
    echo "Renaming public/instance/soapbox.example.json to public/instance/soapbox.json..."
    mv public/instance/soapbox.example.json public/instance/soapbox.json 
    echo
    echo "Done ✅"
    echo
    echo "🎉  Ditto has been configured! 🎉"
    touch docker_setup_done
fi
echo
echo "Starting Ditto..."
echo
deno task dev