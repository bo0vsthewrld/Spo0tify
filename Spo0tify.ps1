param
(
    [Parameter(HelpMessage = 'Xoá podcasts khỏi màn hình chính.')]
    [switch]$podcasts_off,
    
    [Parameter(HelpMessage = 'Không xoá podcasts khỏi màn hình chính.')]
    [switch]$podcasts_on,
    
    [Parameter(HelpMessage = 'Ngăn Spotify tự động cập nhật phiên bản mới.')]
    [switch]$block_update_on,
    
    [Parameter(HelpMessage = 'Cho phép Spotify tự động cập nhật phiên bản mới.')]
    [switch]$block_update_off,
    
    [Parameter(HelpMessage = 'Bật tự động dọn cache của Spotify.')]
    [switch]$cache_on,
    
    [Parameter(HelpMessage = 'Số ngày tự động xoá cache. Mặc định là 7 ngày.')]
    [int16]$number_days = 7,
    
    [Parameter(HelpMessage = 'Không tự động dọn cache của Spotify.')]
    [switch]$cache_off,
    
    [Parameter(HelpMessage = 'Tự động gỡ cài đặt các phiên bản Spotify nếu có trong máy.')]
    [switch]$confirm_uninstall_ms_spoti,
    
    [Parameter(HelpMessage = 'Cài đặt lại phiên bản Spotify đã lỗi thời hoặc không được hỗ trợ bằng phiên bản được đề xuất.')]
    [switch]$confirm_spoti_recomended_over,
    
    [Parameter(HelpMessage = 'Gỡ cài đặt phiên bản Spotify đã lỗi thời hoặc không được hỗ trợ và cài đặt phiên bản được đề xuất.')]
    [switch]$confirm_spoti_recomended_unistall,
    
    [Parameter(HelpMessage = 'Cài đặt cho người dùng Premium (không có tính năng chặn quảng cáo)')]
    [switch]$premium,
    
    [Parameter(HelpMessage = 'Tự động khởi chạy Spotify sau khi cài đặt xong.')]
    [switch]$start_spoti,
    
    [Parameter(HelpMessage = 'Tắt tất cả các tính năng thử nghiệm.')]
    [switch]$exp_off,

    [Parameter(HelpMessage = 'Các tính năng thử nghiệm nổi bật.')]
    [switch]$exp_standart,
    
    [Parameter(HelpMessage = 'Không ẩn icon của các collaborations trong playlists.')]
    [switch]$hide_col_icon_off,
    
    [Parameter(HelpMessage = 'Không kích hoạt nút Made For You.')]
    [switch]$made_for_you_off,
    
    [Parameter(HelpMessage = 'Không kích hoạt tính năng Enhance Playlist.')]
    [switch]$enhance_playlist_off,
    
    [Parameter(HelpMessage = 'Không kích hoạt tính năng Enhance Like Songs')]
    [switch]$enhance_like_off,
    
    [Parameter(HelpMessage = 'Không kích hoạt tính năng New Artist Pages.')]
    [switch]$new_artist_pages_off,
    
    [Parameter(HelpMessage = 'Không bật New lyrics.')]
    [switch]$new_lyrics_off,
    
    [Parameter(HelpMessage = 'Không bật danh sách phát ngoại lệ từ các đề xuất.')]
    [switch]$ignore_in_recommendations_off,

    [Parameter(HelpMessage = 'Bật Audio Equalizer')]
    [switch]$equalizer_off,
    
    [Parameter(HelpMessage = 'cak lỏ')]
    [switch]$device_new_off,

    [Parameter(HelpMessage = 'cak lỏ')]
    [switch]$enablenavalt,
    
    [Parameter(HelpMessage = 'cak lỏ')]
    [Alias('l')]
    [string]$Language
)

$PSDefaultParameterValues['Stop-Process:ErrorAction'] = [System.Management.Automation.ActionPreference]::SilentlyContinue

function Format-LanguageCode {
    

    [CmdletBinding()]
    [OutputType([string])]
    param
    (
        [string]$LanguageCode
    )
    
    begin {
        $supportLanguages = @(
            'en',
            'ru'
        )
    }
    
    process {
        switch -Regex ($LanguageCode) {
            '^en' {
                $returnCode = 'en'
                break
            }
            '^(ru|py)' {
                $returnCode = 'ru'
                break
            }
            Default {
                $returnCode = $PSUICulture.Remove(2)
                break
            }
        }
        
        if ($returnCode -NotIn $supportLanguages) {
            $returnCode = 'en'
        }
    }
    
    end {
        return $returnCode
    }
}

function Set-ScriptLanguageStrings {
    
    
    [CmdletBinding()]
    [OutputType([object])]
    param
    (
        [Parameter(Mandatory = $true,
            HelpMessage = 'language')]
        [string]$LanguageCode
    )
    
    begin {
        $langStringsEN = [PSCustomObject]@{
            Author          = "Discord:"
            Incorrect       = "Nhập sai dữ liệu rồi bạn chẻ"
            Incorrect2      = "chuẩn bị nhập lại nhé :D "
            CuttError       = "Gặp lỗi khi Request cutt"
            Download        = "Gặp lỗi khi tải script"
            Download2       = "Sẽ tải lại trong 5s.."
            Download3       = "Lỗi lần nữa :("
            Download4       = "Kiểm tra lại kết nối đường truyền của bạn và thử lại hoặc liên hệ bo0 :("
            Download5       = "Đang tải Spotify"
            StopScrpit      = "Script đã bị dừng"
            MsSpoti         = "Phát hiện bạn đã cài Spotify từ Microsoft Store (Không tương thích)"
            MsSpoti2        = "Có muốn gỡ cài đặt Spotify từ Microsoft Store? [Y/N]"
            MsSpoti3        = "Đang tự động gỡ cài đặt Spotify MS..."
            MsSpoti4        = "Đang gỡ cài đặt Spotify MS..."
            Prem            = "Đang tuỳ chỉnh cho người dùng Premium.."
            DownBts         = "Đang tải dữ liệu để mod Spotify..."
            OldV            = "Phát hiện phiên bản Spotify đã lỗi thời"
            OldV2           = "Phiên bản Spotify {0} của bạn đã lỗi thời, tớ khuyên cậu nên cập nhật lên phiên bản này {1}"
            OldV3           = "Muốn cập nhật khum? [Y/N]"
            AutoUpd         = "Đang tự động cập nhật lên phiên bản được đề xuất ^^ "
            DelOrOver       = "Bạn có muốn gỡ cài đặt phiên bản Spotify {0} này không hay muốn cài đè lên? Y [Gỡ cài đặt] / N [Cài đè]"
            DelOld          = "Đang gỡ cài đặt phiên bản Spotify cũ.."
            NewV            = "Phát hiện phiên bản Spotify không được hỗ trợ trên máy của bạn"
            NewV2           = "Phiên bản Spotify này {0} vẫn chưa được test :( Hiện tại bản này {1} ổn định hơn nè"
            NewV3           = "Bạn có muốn tiếp tục với phiên bản {0} không? (có thể phát sinh lỗi) [Y/N]"
            Recom           = "Bạn có muốn cài đặt phiên bản được đề xuất này {0} không? [Y/N]"
            DelNew          = "Đang gỡ cài đặt phiên bản Spotify chưa được test :("
            DownSpoti       = "Tớ đang tải và cài đặt Spotify phiên bản"
            DownSpoti2      = "Chờ xíu ik đừng quạo TvT.."
            PodcatsOff      = "Tắt Podcasts"
            PodcastsOn      = "Bật Podcasts"
            PodcatsSelect   = "Bạn có muốn tắt tính năng podcasts không? [Y/N]"
            DowngradeNote   = "Nên chặn tự động cập nhật vì trên máy bạn đã có Spotify được hỗ trợ"
            UpdBlock        = "Chặn tự động cập nhật Spotify thành công :D"
            UpdUnblock      = "Chưa chặn tự động cập nhật Spotify :("
            UpdSelect       = "Bạn có muốn chặn tự động cập nhật hem? [Y/N]"
            CacheOn         = "Đã bật tự động xoá cache ({0})"
            CacheOff        = "Không bật tự động xoá cache"
            CacheSelect     = "Bạn muốn xếp lịch để tự động dọn cache hem? [Y/N]"
            CacheDays       = "Cache cũ: XX ngày sẽ được xóa "
            CacheDays2      = "Nhập số ngày từ 1 đến 100"
            NoVariable      = "Không tìm thấy biến"
            NoVariable2     = "trong file xpui.js"
            NoVariable3     = "trong file licenses.html"
            NoVariable4     = "trong file html"
            ModSpoti        = "Đang mod Spotify..:D"
            Error           = "Lỗi cmnr"
            FileLocBroken   = "Đường dẫn Spotify bị ngu, vui lòng gỡ Spotify ra khỏi máy rồi dùng lại script này"
            Spicetify       = "Đã phát hiện Spicetify"
            NoRestore       = "Bạn đã mod Spotify bằng script này rồi, và tôi không thể tìm thấy file xpui.js và xpui.css `nHãy gỡ cài đặt Spotify rồi dùng lại script này"
            ExpOff          = "Đã tắt tính năng Experimental"
            NoRestore2      = "Bạn đã mod Spotify bằng script này rồi, và tôi không thể tìm thấy file xpui.bak `nHãy gỡ cài đặt Spotify rồi dùng lại script này"
            UpdateBlocked   = "Đã chặn tự động cập nhật từ Spotify rồi (ẩu nka pà)"
            UpdateError     = "Gặp lỗi trong quá trình chặn tự động cập nhật"
            NoSpotifyExe    = "Không tìm thấy Spotify.exe (giấu ở đâu :D?)"
            InstallComplete = "Cài đặt hoàn tất và thành công ~.~"
            HostDel         = "Tìm thấy URLs độc hại trong file host, tôi sẽ xoá chúng..."
            HostError       = "Đã xảy ra lỗi khi edit file host"
        }
        
        $langStringsRU = [PSCustomObject]@{
            Author          = "Discord:"
            Incorrect       = "Nhập sai dữ liệu rồi bạn chẻ"
            Incorrect2      = "chuẩn bị nhập lại nhé :D "
            CuttError       = "Gặp lỗi khi Request cutt"
            Download        = "Gặp lỗi khi tải script"
            Download2       = "Sẽ tải lại trong 5s.."
            Download3       = "Lỗi lần nữa :("
            Download4       = "Kiểm tra lại kết nối đường truyền của bạn và thử lại hoặc liên hệ bo0 :("
            Download5       = "Đang tải Spotify"
            StopScrpit      = "Script đã bị dừng"
            MsSpoti         = "Phát hiện bạn đã cài Spotify từ Microsoft Store (Không tương thích)"
            MsSpoti2        = "Có muốn gỡ cài đặt Spotify từ Microsoft Store? [Y/N]"
            MsSpoti3        = "Đang tự động gỡ cài đặt Spotify MS..."
            MsSpoti4        = "Đang gỡ cài đặt Spotify MS..."
            Prem            = "Đang tuỳ chỉnh cho người dùng Premium.."
            DownBts         = "Đang tải dữ liệu để mod Spotify..."
            OldV            = "Phát hiện phiên bản Spotify đã lỗi thời"
            OldV2           = "Phiên bản Spotify {0} của bạn đã lỗi thời, tớ khuyên cậu nên cập nhật lên phiên bản này {1}"
            OldV3           = "Muốn cập nhật khum? [Y/N]"
            AutoUpd         = "Đang tự động cập nhật lên phiên bản được đề xuất ^^ "
            DelOrOver       = "Bạn có muốn gỡ cài đặt phiên bản Spotify {0} này không hay muốn cài đè lên? Y [Gỡ cài đặt] / N [Cài đè]"
            DelOld          = "Đang gỡ cài đặt phiên bản Spotify cũ.."
            NewV            = "Phát hiện phiên bản Spotify không được hỗ trợ trên máy của bạn"
            NewV2           = "Phiên bản Spotify này {0} vẫn chưa được test :( Hiện tại bản này {1} ổn định hơn nè"
            NewV3           = "Bạn có muốn tiếp tục với phiên bản {0} không? (có thể phát sinh lỗi) [Y/N]"
            Recom           = "Bạn có muốn cài đặt phiên bản được đề xuất này {0} không? [Y/N]"
            DelNew          = "Đang gỡ cài đặt phiên bản Spotify chưa được test :("
            DownSpoti       = "Tớ đang tải và cài đặt Spotify phiên bản"
            DownSpoti2      = "Chờ xíu ik đừng quạo TvT.."
            PodcatsOff      = "Tắt Podcasts"
            PodcastsOn      = "Bật Podcasts"
            PodcatsSelect   = "Bạn có muốn tắt tính năng podcasts không? [Y/N]"
            DowngradeNote   = "Nên chặn tự động cập nhật vì trên máy bạn đã có Spotify được hỗ trợ"
            UpdBlock        = "Chặn tự động cập nhật Spotify thành công :D"
            UpdUnblock      = "Chưa chặn tự động cập nhật Spotify :("
            UpdSelect       = "Bạn có muốn chặn tự động cập nhật hem? [Y/N]"
            CacheOn         = "Đã bật tự động xoá cache ({0})"
            CacheOff        = "Không bật tự động xoá cache"
            CacheSelect     = "Bạn muốn xếp lịch để tự động dọn cache hem? [Y/N]"
            CacheDays       = "Cache cũ: XX ngày sẽ được xóa "
            CacheDays2      = "Nhập số ngày từ 1 đến 100"
            NoVariable      = "Không tìm thấy biến"
            NoVariable2     = "trong file xpui.js"
            NoVariable3     = "trong file licenses.html"
            NoVariable4     = "trong file html"
            ModSpoti        = "Đang mod Spotify..:D"
            Error           = "Lỗi cmnr"
            FileLocBroken   = "Đường dẫn Spotify bị ngu, vui lòng gỡ Spotify ra khỏi máy rồi dùng lại script này"
            Spicetify       = "Đã phát hiện Spicetify"
            NoRestore       = "Bạn đã mod Spotify bằng script này rồi, và tôi không thể tìm thấy file xpui.js và xpui.css `nHãy gỡ cài đặt Spotify rồi dùng lại script này"
            ExpOff          = "Đã tắt tính năng Experimental"
            NoRestore2      = "Bạn đã mod Spotify bằng script này rồi, và tôi không thể tìm thấy file xpui.bak `nHãy gỡ cài đặt Spotify rồi dùng lại script này"
            UpdateBlocked   = "Đã chặn tự động cập nhật từ Spotify rồi (ẩu nka pà)"
            UpdateError     = "Gặp lỗi trong quá trình chặn tự động cập nhật"
            NoSpotifyExe    = "Không tìm thấy Spotify.exe (giấu ở đâu :D?)"
            InstallComplete = "Cài đặt hoàn tất và thành công ~.~"
            HostDel         = "Tìm thấy URLs độc hại trong file host, tôi sẽ xoá chúng..."
            HostError       = "Đã xảy ra lỗi khi edit file host"
        }
    }
    
    process {
        switch ($LangCode) {
            'en' {
                $langStrings = $langStringsEN
                break
            }
            'ru' {
                $langStrings = $langStringsRU
                break
            }
            Default {
                $langStrings = $langStringsEN
                break
            }
        }
    }
    end {
        return $langStrings
    }
}

$langCode = Format-LanguageCode -LanguageCode $Language

$lang = Set-ScriptLanguageStrings -LanguageCode $langCode

if ($langCode -eq 'ru') { $ru = $true }


Write-Host "*****************"
Write-Host ($lang).Author"" -NoNewline
Write-Host "bo0#1629" -ForegroundColor DarkYellow
Write-Host "*****************"`n


$ErrorActionPreference = 'SilentlyContinue'
$cutt_url = "https://cutt.ly/IZrdYB0"
try {  
    Invoke-WebRequest -Uri $cutt_url | Out-Null
}
catch {
    Start-Sleep -Milliseconds 2300
    try { 
        Invoke-WebRequest -Uri $cutt_url | Out-Null
    }
    catch { }
}

$spotifyDirectory = "$env:APPDATA\Spotify"
$spotifyDirectory2 = "$env:LOCALAPPDATA\Spotify"
$spotifyExecutable = "$spotifyDirectory\Spotify.exe"
$chrome_elf = "$spotifyDirectory\chrome_elf.dll"
$chrome_elf_bak = "$spotifyDirectory\chrome_elf_bak.dll"
$cache_folder = "$env:APPDATA\Spotify\cache"
$spotifyUninstall = "$env:TEMP\SpotifyUninstall.exe"
$upgrade_client = $false

function incorrectValue {

    Write-Host ($lang).Incorrect"" -ForegroundColor Red -NoNewline
    Write-Host ($lang).Incorrect2"" -NoNewline
    Start-Sleep -Milliseconds 1000
    Write-Host "3" -NoNewline 
    Start-Sleep -Milliseconds 1000
    Write-Host " 2" -NoNewline
    Start-Sleep -Milliseconds 1000
    Write-Host " 1"
    Start-Sleep -Milliseconds 1000     
    Clear-Host
} 

function Check_verison_clients($param2) {

    if ($param2 -eq "online") {
        $ProgressPreference = 'SilentlyContinue'
        $readme = Invoke-WebRequest -UseBasicParsing -Uri https://raw.githubusercontent.com/amd64fox/SpotX/main/README.md
        $v = $readme.RawContent | Select-String "Recommended official version \[\d+\.\d+\.\d+\.\d+\]" -AllMatches
        $ver = $v.Matches.Value
        $ver = $ver -replace 'Recommended official version \[(\d+\.\d+\.\d+\.\d+)\]', '$1'
        return $ver
    }
    if ($param2 -eq "offline") {
        $check_offline = (Get-Item $spotifyExecutable).VersionInfo.FileVersion
        return $check_offline
    }
}
function unlockFolder {

    $ErrorActionPreference = 'SilentlyContinue'
    $block_File_update = "$env:LOCALAPPDATA\Spotify\Update"
    $Check_folder = Get-ItemProperty -Path $block_File_update | Select-Object Attributes 
    $folder_update_access = Get-Acl $block_File_update

    if ($Check_folder -match '\bDirectory\b') {  

        if ($folder_update_access.AccessToString -match 'Deny') {
                ($ACL = Get-Acl $block_File_update).access | ForEach-Object {
                $Users = $_.IdentityReference 
                $ACL.PurgeAccessRules($Users) }
            $ACL | Set-Acl $block_File_update
        }
    }
}     

function downloadScripts($param1) {

    $webClient = New-Object -TypeName System.Net.WebClient

    if ($param1 -eq "Desktop") {
        Import-Module BitsTransfer
        
        $ver = Check_verison_clients -param2 "online"
        $l = "$PWD\links.tsv"
        $old = [IO.File]::ReadAllText($l)
        $links = $old -match "https:\/\/upgrade.scdn.co\/upgrade\/client\/win32-x86\/spotify_installer-$ver\.g[0-9a-f]{8}-[0-9]{1,3}\.exe" 
        $links = $Matches.Values
    }
    if ($ru -and $param1 -eq "cache-spotify") {
        $links2 = "https://raw.githubusercontent.com/bo0vsthewrld/Spo0tify/main/scripts/cache/cache_spotify_ru.ps1"
    }
    if (!($ru) -and $param1 -eq "cache-spotify" ) { 
        $links2 = "https://raw.githubusercontent.com/bo0vsthewrld/Spo0tify/main/scripts/cache/cache_spotify.ps1"
    }
    
    $web_Url_prev = "https://github.com/mrpond/BlockTheSpot/releases/latest/download/chrome_elf.zip", $links, `
        $links2, "https://raw.githubusercontent.com/bo0vsthewrld/Spo0tify/main/scripts/cache/hide_window.vbs", `
        "https://raw.githubusercontent.com/bo0vsthewrld/Spo0tify/main/scripts/cache/run_ps.bat", "https://docs.google.com/spreadsheets/d/e/2PACX-1vSFN2hWu4UO-ZWyVe8wlP9c0JsrduA49xBnRmSLOt8SWaOfIpCwjDLKXMTWJQ5aKj3WakQv6-Hnv9rz/pub?gid=0&single=true&output=tsv"

    $local_Url_prev = "$PWD\chrome_elf.zip", "$PWD\SpotifySetup.exe", "$cache_folder\cache_spotify.ps1", "$cache_folder\hide_window.vbs", "$cache_folder\run_ps.bat", "$PWD\links.tsv"
    $web_name_file_prev = "chrome_elf.zip", "SpotifySetup.exe", "cache_spotify.ps1", "hide_window.vbs", "run_ps.bat", "links.tsv"

    switch ( $param1 ) {
        "BTS" { $web_Url = $web_Url_prev[0]; $local_Url = $local_Url_prev[0]; $web_name_file = $web_name_file_prev[0] }
        "Desktop" { $web_Url = $web_Url_prev[1]; $local_Url = $local_Url_prev[1]; $web_name_file = $web_name_file_prev[1] }
        "cache-spotify" { $web_Url = $web_Url_prev[2]; $local_Url = $local_Url_prev[2]; $web_name_file = $web_name_file_prev[2] }
        "hide_window" { $web_Url = $web_Url_prev[3]; $local_Url = $local_Url_prev[3]; $web_name_file = $web_name_file_prev[3] }
        "run_ps" { $web_Url = $web_Url_prev[4]; $local_Url = $local_Url_prev[4]; $web_name_file = $web_name_file_prev[4] } 
        "links.tsv" { $web_Url = $web_Url_prev[5]; $local_Url = $local_Url_prev[5]; $web_name_file = $web_name_file_prev[5] }
    }

    if ($param1 -eq "Desktop") {
        try { if (curl.exe -V) { $curl_check = $true } }
        catch { $curl_check = $false }
        $vernew = Check_verison_clients -param2 "online"
    }
    try { 
        if ($param1 -eq "Desktop" -and $curl_check) {
            curl.exe $web_Url -o $local_Url --progress-bar --retry 3 --ssl-no-revoke
        }
        if ($param1 -eq "Desktop" -and $null -ne (Get-Module -Name BitsTransfer -ListAvailable) -and !($curl_check )) {
            Start-BitsTransfer -Source  $web_Url -Destination $local_Url  -DisplayName ($lang).Download5 -Description "$vernew "
        }
        if ($param1 -eq "Desktop" -and $null -eq (Get-Module -Name BitsTransfer -ListAvailable) -and !($curl_check )) {
            $webClient.DownloadFile($web_Url, $local_Url) 
        }
        if ($param1 -ne "Desktop") {
            $ProgressPreference = 'SilentlyContinue' # Hiding Progress Bars
            $webClient.DownloadFile($web_Url, $local_Url) 
        }
    }

    catch [System.Management.Automation.MethodInvocationException] {
        Write-Host ""
        Write-Host ($lang).Download $web_name_file -ForegroundColor RED
        $Error[0].Exception
        Write-Host ""
        Write-Host ($lang).Download2`n
        Start-Sleep -Milliseconds 5000 
        try { 

            if ($param1 -eq "Desktop" -and $curl_check) {
                curl.exe $web_Url -o $local_Url --progress-bar --retry 3 --ssl-no-revoke
            }
            if ($param1 -eq "Desktop" -and $null -ne (Get-Module -Name BitsTransfer -ListAvailable) -and !($curl_check )) {
                Start-BitsTransfer -Source  $web_Url -Destination $local_Url  -DisplayName ($lang).Download5 -Description "$vernew "
            }
            if ($param1 -eq "Desktop" -and $null -eq (Get-Module -Name BitsTransfer -ListAvailable) -and !($curl_check )) {
                $webClient.DownloadFile($web_Url, $local_Url) 
            }
            if ($param1 -ne "Desktop") {
                $ProgressPreference = 'SilentlyContinue'
                $webClient.DownloadFile($web_Url, $local_Url) 
            }

        }
        
        catch [System.Management.Automation.MethodInvocationException] {
            Write-Host ($lang).Download3 -ForegroundColor RED
            $Error[0].Exception
            Write-Host ""
            Write-Host ($lang).Download4`n
            ($lang).StopScrpit
            $tempDirectory = $PWD
            Pop-Location
            Start-Sleep -Milliseconds 200
            Remove-Item -Recurse -LiteralPath $tempDirectory
            Pause
            Exit
        }
    }
} 

function DesktopFolder {

    
    $ErrorActionPreference = 'SilentlyContinue' 
    if (Test-Path "$env:USERPROFILE\Desktop") {  
        $desktop_folder = "$env:USERPROFILE\Desktop"  
    }

    $regedit_desktop_folder = Get-ItemProperty -Path "Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders\"
    $regedit_desktop = $regedit_desktop_folder.'{754AC886-DF64-4CBA-86B5-F7FBF4FBCEF5}'
 
    if (!(Test-Path "$env:USERPROFILE\Desktop")) {
        $desktop_folder = $regedit_desktop
    }
    return $desktop_folder
}

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Stop-Process -Name Spotify

if ($PSVersionTable.PSVersion.major -ge 7) {
    Import-Module Appx -UseWindowsPowerShell -WarningAction:SilentlyContinue
}

$win_os = (get-itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName).ProductName
$win11 = $win_os -match "\windows 11\b"
$win10 = $win_os -match "\windows 10\b"
$win8_1 = $win_os -match "\windows 8.1\b"
$win8 = $win_os -match "\windows 8\b"

if ($win11 -or $win10 -or $win8_1 -or $win8) {

    if (Get-AppxPackage -Name SpotifyAB.SpotifyMusic) {
        Write-Host ($lang).MsSpoti`n
        
        if (!($confirm_uninstall_ms_spoti)) {
            do {
                $ch = Read-Host -Prompt ($lang).MsSpoti2""
                Write-Host ""
                if (!($ch -eq 'n' -or $ch -eq 'y')) {
                    incorrectValue
                }
            }
    
            while ($ch -notmatch '^y$|^n$')
        }
        if ($confirm_uninstall_ms_spoti) { $ch = 'y' }
        if ($ch -eq 'y') {      
            $ProgressPreference = 'SilentlyContinue'
            if ($confirm_uninstall_ms_spoti) { Write-Host ($lang).MsSpoti3`n }
            if (!($confirm_uninstall_ms_spoti)) { Write-Host ($lang).MsSpoti4`n }
            Get-AppxPackage -Name SpotifyAB.SpotifyMusic | Remove-AppxPackage
        }
        if ($ch -eq 'n') {
            Read-Host ($lang).StopScrpit 
            Pause
            Exit
        }
    }
}

$pathHosts = "$Env:windir\System32\Drivers\Etc\hosts"
$ErrorActionPreference = 'SilentlyContinue'
$testHosts = Test-Path -Path $pathHosts

if ($testHosts) {
    $hosts = Get-Content -Path $pathHosts

    if ($hosts -match '.+scdn.+' -or $hosts -match '.+spotify.+' ) {
        Write-Host ($lang).HostDel`n

        try {
            $hosts = $hosts -replace '.+scdn.+', '' -replace '.+spotify.+', ''
            Set-Content -Path $pathHosts -Value $hosts -Force
            $hosts | Where-Object { $_.trim() -ne "" } | Set-Content -Path $pathHosts -Force
        }
        catch {
            Write-Host ($lang).HostError`n -ForegroundColor Red
        }
    }
}

Push-Location -LiteralPath $env:TEMP
New-Item -Type Directory -Name "bo0_Temp-$(Get-Date -UFormat '%Y-%m-%d_%H-%M-%S')" | Convert-Path | Set-Location

if ($premium) {
    Write-Host ($lang).Prem`n
}
if (!($premium)) {
    Write-Host ($lang).DownBts`n
    downloadScripts -param1 "BTS"
    Add-Type -Assembly 'System.IO.Compression.FileSystem'
    $zip = [System.IO.Compression.ZipFile]::Open("$PWD\chrome_elf.zip", 'read')
    [System.IO.Compression.ZipFileExtensions]::ExtractToDirectory($zip, $PWD)
    $zip.Dispose()
}
downloadScripts -param1 "links.tsv"


$online = Check_verison_clients -param2 "online"

$spotifyInstalled = (Test-Path -LiteralPath $spotifyExecutable)

if ($spotifyInstalled) {

    $offline = Check_verison_clients -param2 "offline"

    if ($online -gt $offline) {
        if ($confirm_spoti_recomended_over -or $confirm_spoti_recomended_unistall) {
            Write-Host ($lang).OldV`n
        }
        if (!($confirm_spoti_recomended_over) -and !($confirm_spoti_recomended_unistall)) {
            do {
                Write-Host (($lang).OldV2 -f $offline, $online)
                $ch = Read-Host -Prompt ($lang).OldV3
                Write-Host ""
                if (!($ch -eq 'n' -or $ch -eq 'y')) {
                    incorrectValue
                }
            }
            while ($ch -notmatch '^y$|^n$')
        }
        if ($confirm_spoti_recomended_over -or $confirm_spoti_recomended_unistall) { 
            $ch = 'y' 
            Write-Host ($lang).AutoUpd`n
        }
        if ($ch -eq 'y') { 
            $upgrade_client = $true 

            if (!($confirm_spoti_recomended_over) -and !($confirm_spoti_recomended_unistall)) {
                do {
                    $ch = Read-Host -Prompt (($lang).DelOrOver -f $offline)
                    Write-Host ""
                    if (!($ch -eq 'n' -or $ch -eq 'y')) {
                        incorrectValue
                    }
                }
                while ($ch -notmatch '^y$|^n$')
            }
            if ($confirm_spoti_recomended_unistall) { $ch = 'y' }
            if ($confirm_spoti_recomended_over) { $ch = 'n' }
            if ($ch -eq 'y') {
                Write-Host ($lang).DelOld`n 
                unlockFolder
                cmd /c $spotifyExecutable /UNINSTALL /SILENT
                wait-process -name SpotifyUninstall
                Start-Sleep -Milliseconds 200
                if (Test-Path $spotifyDirectory) { Remove-Item -Recurse -Force -LiteralPath $spotifyDirectory }
                if (Test-Path $spotifyDirectory2) { Remove-Item -Recurse -Force -LiteralPath $spotifyDirectory2 }
                if (Test-Path $spotifyUninstall ) { Remove-Item -Recurse -Force -LiteralPath $spotifyUninstall }
            }
            if ($ch -eq 'n') { $ch = $null }
        }
        if ($ch -eq 'n') { 
            $downgrading = $true
        }
    }

    if ($online -lt $offline) {

        if ($confirm_spoti_recomended_over -or $confirm_spoti_recomended_unistall) {
            Write-Host ($lang).NewV`n
        }
        if (!($confirm_spoti_recomended_over) -and !($confirm_spoti_recomended_unistall)) {
            do {
                Write-Host (($lang).NewV2 -f $offline, $online)
                $ch = Read-Host -Prompt (($lang).NewV3 -f $offline)
                Write-Host ""
                if (!($ch -eq 'n' -or $ch -eq 'y')) {
                    incorrectValue
                }
            }
            while ($ch -notmatch '^y$|^n$')
        }
        if ($confirm_spoti_recomended_over -or $confirm_spoti_recomended_unistall) { $ch = 'n' }
        if ($ch -eq 'y') { $upgrade_client = $false }
        if ($ch -eq 'n') {
            if (!($confirm_spoti_recomended_over) -and !($confirm_spoti_recomended_unistall)) {
                do {
                    $ch = Read-Host -Prompt (($lang).Recom -f $online)
                    Write-Host ""
                    if (!($ch -eq 'n' -or $ch -eq 'y')) {
                        incorrectValue
                    }
                }
                while ($ch -notmatch '^y$|^n$')
            }
            if ($confirm_spoti_recomended_over -or $confirm_spoti_recomended_unistall) { 
                $ch = 'y' 
                Write-Host ($lang).AutoUpd`n
            }
            if ($ch -eq 'y') {
                $upgrade_client = $true
                $downgrading = $true
                if (!($confirm_spoti_recomended_over) -and !($confirm_spoti_recomended_unistall)) {
                    do {
                        $ch = Read-Host -Prompt (($lang).DelOrOver -f $offline)
                        Write-Host ""
                        if (!($ch -eq 'n' -or $ch -eq 'y')) {
                            incorrectValue
                        }
                    }
                    while ($ch -notmatch '^y$|^n$')
                }
                if ($confirm_spoti_recomended_unistall) { $ch = 'y' }
                if ($confirm_spoti_recomended_over) { $ch = 'n' }
                if ($ch -eq 'y') {
                    Write-Host ($lang).DelNew`n
                    unlockFolder
                    cmd /c $spotifyExecutable /UNINSTALL /SILENT
                    wait-process -name SpotifyUninstall
                    Start-Sleep -Milliseconds 200
                    if (Test-Path $spotifyDirectory) { Remove-Item -Recurse -Force -LiteralPath $spotifyDirectory }
                    if (Test-Path $spotifyDirectory2) { Remove-Item -Recurse -Force -LiteralPath $spotifyDirectory2 }
                    if (Test-Path $spotifyUninstall ) { Remove-Item -Recurse -Force -LiteralPath $spotifyUninstall }
                }
                if ($ch -eq 'n') { $ch = $null }
            }

            if ($ch -eq 'n') {
                Write-Host ($lang).StopScrpit
                $tempDirectory = $PWD
                Pop-Location
                Start-Sleep -Milliseconds 200
                Remove-Item -Recurse -LiteralPath $tempDirectory 
                Pause
                Exit
            }
        }
    }
}
if (-not $spotifyInstalled -or $upgrade_client) {

    Write-Host ($lang).DownSpoti"" -NoNewline
    Write-Host  $online -ForegroundColor Green
    Write-Host ($lang).DownSpoti2`n
    
    $ErrorActionPreference = 'SilentlyContinue'
    Stop-Process -Name Spotify 
    Start-Sleep -Milliseconds 600
    unlockFolder
    Start-Sleep -Milliseconds 200
    Get-ChildItem $spotifyDirectory -Exclude 'Users', 'prefs', 'cache' | Remove-Item -Recurse -Force 
    Start-Sleep -Milliseconds 200

    downloadScripts -param1 "Desktop"
    Write-Host ""

    Start-Sleep -Milliseconds 200

    Start-Process -FilePath explorer.exe -ArgumentList $PWD\SpotifySetup.exe
    while (-not (get-process | Where-Object { $_.ProcessName -eq 'SpotifySetup' })) {}
    wait-process -name SpotifySetup


    wait-process -name SpotifySetup
    Stop-Process -Name Spotify 

}

$leveldb = (Test-Path -LiteralPath "$spotifyDirectory2\Browser\Local Storage\leveldb")

if ($leveldb) {
    $ErrorActionPreference = 'SilentlyContinue'
    remove-item "$spotifyDirectory2\Browser\Local Storage\leveldb" -Recurse -Force
}

if (!(Test-Path -LiteralPath $chrome_elf_bak) -and !($premium)) {
    Move-Item $chrome_elf $chrome_elf_bak 
}

$ch = $null

if ($podcasts_off) { 
    Write-Host ($lang).PodcatsOff`n 
    $ch = 'y'
}
if ($podcasts_on) {
    Write-Host ($lang).PodcastsOn`n
    $ch = 'n'
}
if (!($podcasts_off) -and !($podcasts_on)) {

    do {
        $ch = Read-Host -Prompt ($lang).PodcatsSelect
        Write-Host ""
        if (!($ch -eq 'n' -or $ch -eq 'y')) { incorrectValue }
    }
    while ($ch -notmatch '^y$|^n$')
}
if ($ch -eq 'y') { $podcast_off = $true }

$ch = $null

if ($downgrading) { $upd = "`n" + [string]($lang).DowngradeNote }

else { $upd = "" }

if ($block_update_on) { 
    Write-Host ($lang).UpdBlock`n
    $ch = 'y'
}
if ($block_update_off) {
    Write-Host ($lang).UpdUnblock`n
    $ch = 'n'
}
if (!($block_update_on) -and !($block_update_off)) {
    do {
        $text_upd = [string]($lang).UpdSelect + $upd
        $ch = Read-Host -Prompt $text_upd
        Write-Host ""
        if (!($ch -eq 'n' -or $ch -eq 'y')) { incorrectValue } 
    }
    while ($ch -notmatch '^y$|^n$')
}
if ($ch -eq 'y') { $block_update = $true }

$ch = $null

if ($cache_on) { 
    Write-Host (($lang).CacheOn -f $number_days)`n 
    $cache_install = $true
}
if ($cache_off) { 
    Write-Host ($lang).CacheOff`n
    $ErrorActionPreference = 'SilentlyContinue'
    $desktop_folder = DesktopFolder
    if (Test-Path -LiteralPath $cache_folder) {
        remove-item $cache_folder -Recurse -Force
        remove-item $desktop_folder\Spotify.lnk -Recurse -Force
    } 
}
if (!($cache_on) -and !($cache_off)) {

    do {
        $ch = Read-Host -Prompt ($lang).CacheSelect
        Write-Host ""
        if (!($ch -eq 'n' -or $ch -eq 'y')) { incorrectValue }
    }
    while ($ch -notmatch '^y$|^n$')

    if ($ch -eq 'y') {
        $cache_install = $true 

        do {
            Write-Host ($lang).CacheDays
            $ch = Read-Host -Prompt ($lang).CacheDays2
            Write-Host ""
            if (!($ch -match "^[1-9][0-9]?$|^100$")) { incorrectValue }
        }
        while ($ch -notmatch '^[1-9][0-9]?$|^100$')

        if ($ch -match "^[1-9][0-9]?$|^100$") { $number_days = $ch }
    }
    if ($ch -eq 'n') {
        $ErrorActionPreference = 'SilentlyContinue'
        $desktop_folder = DesktopFolder
        if (Test-Path -LiteralPath $cache_folder) {
            remove-item $cache_folder -Recurse -Force
            remove-item $desktop_folder\Spotify.lnk -Recurse -Force
        }
    }
}

function Helper($paramname) {

    switch ( $paramname ) {
        "HtmlLicMin" { 
            $html_lic_min = @{
                HtmlLicMin1 = '\r?\n(?!\(1|\d)', ''
                HtmlLicMin2 = '(?m)(^\s*\r?\n)', ''
                HtmlLicMin3 = '  ', ''
                HtmlLicMin4 = '	', ''
                HtmlLicMin5 = '<li><a href="#6eef7">zlib<\/a><\/li>\n(.|\n)*<\/p><!-- END CONTAINER DEPS LICENSES -->(<\/div>)', ''
            }
            $n = ($lang).NoVariable3
            $contents = $html_lic_min
            $paramdata = $xpuiContents_html
        }
        "OffadsonFullscreen" { 
            $offadson_fullscreen = @{
                EmptyBlockAd        = 'adsEnabled:!0', 'adsEnabled:!1'
                FullScreenAd        = '(return|.=.=>)"free"===(.+?)(return|.=.=>)"premium"===', '$1"premium"===$2$3"free"==='
                PlaylistSponsorsOff = 'allSponsorships' , ''
            }
            $n = ($lang).NoVariable2
            $contents = $offadson_fullscreen
            $paramdata = $xpui_js
        }
        "OffPodcasts" {  
            $podcasts_off = @{
                PodcastsOff1 = 'withQueryParameters\(e\){return this.queryParameters=e,this}', 'withQueryParameters(e){return this.queryParameters=(e.types?{...e, types: e.types.split(",").filter(_ => !["episode","show"].includes(_)).join(",")}:e),this}'
                PodcastsOff2 = ',this[.]enableShows=[a-z]', ''
            }
            $n = ($lang).NoVariable2
            $contents = $podcasts_off
            $paramdata = $xpui_js
        }
        "OffRujs" { 
            $rus_js = @{
                OffRujs = '(en:{displayName:"English",displayNameEn:"English"}).*"Vietnamese"', '$1,ru:{displayName:"Русский",displayNameEn:"Russian"'
            }
            $n = ($lang).NoVariable2
            $contents = $rus_js
            $paramdata = $xpui_js

        }
        "RuTranslate" { 
            $ru_translate = @{
                One                = '"one": "Enhanced with [{]0[}] recommended song."', '"one": "Добавлен {0} рекомендованный трек."' 
                Few                = '"few": "Enhanced with [{]0[}] recommended songs."', '"few": "Добавлено {0} рекомендованных трека."' 
                Many               = '"many": "Enhanced with [{]0[}] recommended songs."', '"many": "Добавлено {0} рекомендованных треков."' 
                Other              = '"other": "Enhanced with [{]0[}] recommended songs."', '"other": "Добавлено {0} рекомендованных трека."' 
                EnhancePlaylist    = '"To Enhance this playlist, you.ll need to go online."', '"Чтобы улучшить этот плейлист, вам нужно подключиться к интернету."'
                ConfirmAge         = '"Confirm your age"', '"Подтвердите свой возраст"' 
                Premium            = '"%price%\/month after. Terms and conditions apply. One month free not available for users who have already tried Premium."', '"%price%/месяц спустя. Принять условия. Один месяц бесплатно, недоступно для пользователей, которые уже попробовали Premium."' 
                AdFreeMusic        = '"Enjoy ad-free music listening, offline listening, and more. Cancel anytime."', '"Наслаждайтесь прослушиванием музыки без рекламы, прослушиванием в офлайн режиме и многим другим. Отменить можно в любое время."' 
                LyricsBy           = '"Lyrics provided by [{]0[}]"', '"Тексты песен предоставлены {0}"' 
                AddPlaylist        = '"Add to another playlist"', '"Добавить в другой плейлист"' 
                OfflineStorage     = '"Offline storage location"', '"Хранилище скачанных треков"' 
                ChangeLocation     = '"Change location"', '"Изменить место"' 
                Linebreaks         = '"Line breaks aren.t supported in the description."', '"В описании не поддерживаются разрывы строк."' 
                PressSave          = '"Press save to keep changes you.ve made."', '"Нажмите «Сохранить», чтобы сохранить внесенные изменения."' 
                NoInternet         = '"No internet connection found. Changes to description and image will not be saved."', '"Подключение к интернету не найдено. Изменения в описании и изображении не будут сохранены."' 
                ImageSmall         = '"Image too small. Images must be at least [{]0[}]x[{]1[}]."', '"Изображение слишком маленькое. Изображения должны быть не менее {0}x{1}."' 
                FailedUpload       = '"Failed to upload image. Please try again."', '"Не удалось загрузить изображение. Пожалуйста, попробуйте снова."' 
                Description        = '"Description"', '"Описание"' 
                ChangePhoto        = '"Change photo"', '"Сменить изображение"' 
                RemovePhoto        = '"Remove photo"', '"Удалить изображение"' 
                Name               = '"Name"', '"Имя"' 
                ChangeSpeed        = '"Change speed"', '"Изменение скорости"' 
                Years19            = '"You need to be at least 19 years old to listen to explicit content marked with"', '"Вам должно быть не менее 19 лет, чтобы слушать непристойный контент, помеченный значком"' 
                AddPlaylist2       = '"Add to this playlist"', '"Добавить в этот плейлист"' 
                Retrying           = '"Retrying in [{]0[}]..."', '"Повторная попытка в {0}..."' 
                NoConnect          = '"Couldn.t connect to Spotify."', '"Не удалось подключиться к Spotify."' 
                Reconnecting       = '"Reconnecting..."', '"Повторное подключение..."' 
                NoConnection       = '"No connection"', '"Нет соединения"' 
                CharacterCounter   = '"Character counter"', '"Счетчик символов"' 
                Lightsaber         = '"Toggle lightsaber hilt. Current is [{]0[}]."', '"Переключить рукоять светового меча. Текущий {0}."' 
                SongAvailable      = '"Song not available"', '"Песня недоступна"' 
                HiFi               = '"The song you.re trying to listen to is not available in HiFi at this time."', '"Песня, которую вы пытаетесь прослушать, в настоящее время недоступна в HiFi."' 
                Quality            = '"Current audio quality:"', '"Текущее качество звука:"' 
                Network            = '"Network connection"', '"Подключение к сети"' 
                Good               = '"Good"', '"Хорошее"' 
                Poor               = '"Poor"', '"Плохое"' 
                Yes                = '"Yes"', '"Да"' 
                No                 = '"No"', '"Нет"' 
                Location           = '"Your Location"', '"Ваше местоположение"'
                NetworkConnection  = '"Network connection failed while playing this content."', '"Сбой сетевого подключения при воспроизведении этого контента."'
                ContentLocation    = '"We.re not able to play this content in your current location."', '"Мы не можем воспроизвести этот контент в вашем текущем местоположении."'
                ContentUnavailable = '"This content is unavailable. Try another\?"', '"Этот контент недоступен. Попробуете другой?"'
                NoContent          = '"Sorry, we.re not able to play this content."', '"К сожалению, мы не можем воспроизвести этот контент."'
                NoContent2         = '"Hmm... we can.t seem to play this content. Try installing the latest version of Spotify."', '"Хм... похоже, мы не можем воспроизвести этот контент. Попробуйте установить последнюю версию Spotify."'
                NoContent3         = '"Please upgrade Spotify to play this content."', '"Пожалуйста, обновите Spotify, чтобы воспроизвести этот контент."'
                NoContent4         = '"This content cannot be played on your operating system version."', '"Этот контент нельзя воспроизвести в вашей версии операционной системы."'
                DevLang            = '"Override certain user attributes to test regionalized content programming. The overrides are only active in this app."', '"Переопределите определенные атрибуты пользователя, чтобы протестировать региональное программирование контента. Переопределения активны только в этом приложении."'
                AlbumRelease       = '"...name... was released this week!"', '"\"%name%\" был выпущен на этой неделе!"'
                AlbumReleaseOne    = '"one": "\\"%name%\\" was released %years% year ago this week!"', '"one": "\"%name%\" был выпущен %years% год назад на этой неделе!"'
                AlbumReleaseFew    = '"few": "\\"%name%\\" was released %years% years ago this week!"', '"few": "\"%name%\" был выпущен %years% года назад на этой неделе!"'
                AlbumReleaseMany   = '"many": "\\"%name%\\" was released %years% years ago this week!"', '"many": "\"%name%\" был выпущен %years% лет назад на этой неделе!"'
                AlbumReleaseOther  = '"other": "\\"%name%\\" was released %years% years ago this week!"', '"other": "\"%name%\" был выпущен %years% года назад на этой неделе!"'
                Speed              = '"Speed [{]0[}]×"', '"Скорость {0}×"'
                SearchEmpty        = '(\")(No \{1\} found for)( \\\"\{0\}\\\"\")', '$1{1} не найдено для$3'
                AudiobookFree      = '"This audiobook is free"', '"Эта аудиокнига бесплатна"'
                AudiobookGet       = '"Get"', '"Получить"'
                AudiobookBy        = '"Buy"', '"Купить"'
            }
            $n = ($lang).NoVariable5
            $contents = $ru_translate
            $paramdata = $xpui_ru
        }

        "ExpFeature" { 
            $exp_features = @{
                ExpFeatures1  = '(Enable Liked Songs section on Artist page",default:)(!1)', '$1!0' 
                ExpFeatures2  = '(Enable block users feature in clientX",default:)(!1)', '$1!0' 
                ExpFeatures3  = '(Enables quicksilver in-app messaging modal",default:)(!0)', '$1!1' 
                ExpFeatures4  = '(With this enabled, clients will check whether tracks have lyrics available",default:)(!1)', '$1!0' 
                ExpFeatures5  = '(Enables new playlist creation flow in Web Player and DesktopX",default:)(!1)', '$1!0'
                ExpFeatures6  = '(Adds a search box so users are able to filter playlists when trying to add songs to a playlist using the contextmenu",default:)(!1)', '$1!0'
                ExpFeatures7  = '(Enable Ignore In Recommendations for desktop and web",default:)(!1)', '$1!0'
                ExpFeatures8  = '(Enable Playlist Permissions flows for Prod",default:)(!1)', '$1!0'
                ExpFeatures9  = '(Enable showing balloons on album release date anniversaries",default:)(!1)', '$1!0'
                ExpFeatures10 = '(Enable Enhance Liked Songs UI and functionality",default:)(!1)', '$1!0'
                ExpFeatures11 = '(Enable Enhance Playlist UI and functionality for end-users",default:)(!1)', '$1!0' 
                ExpFeatures12 = '(Enable a condensed disography shelf on artist pages",default:)(!1)', '$1!0' 
                ExpFeatures13 = '(Enable Lyrics match labels in search results",default:)(!1)', '$1!0'  
                ExpFeatures14 = '(Enable audio equalizer for Desktop and Web Player",default:)(!1)', '$1!0' 
                ExpFeatures15 = '(Enable showing a new and improved device picker UI",default:)(!1)', '$1!0'
                ExpFeatures16 = '(Enable the new home structure and navigation:)(!1)', '$1!0'
                ExpFeatures17 = '(Show "Made For You" entry point in the left sidebar.,default:)(!1)', '$1!0'
            }
            if ($enhance_like_off) { $exp_features.Remove('ExpFeatures10') }
            if ($enhance_playlist_off) { $exp_features.Remove('ExpFeatures11') }
            if ($new_artist_pages_off) { $exp_features.Remove('ExpFeatures12') }
            if ($new_lyrics_off) { $exp_features.Remove('ExpFeatures13') }
            if ($equalizer_off) { $exp_features.Remove('ExpFeatures14') }
            if ($device_new_off) { $exp_features.Remove('ExpFeatures15') }
            if (!($enablenavalt)) { $exp_features.Remove('ExpFeatures16') }
            if ($made_for_you_off) { $exp_features.Remove('ExpFeatures17') }
            if ($exp_standart) {
                $exp_features.Remove('ExpFeatures10'), $exp_features.Remove('ExpFeatures11'), 
                $exp_features.Remove('ExpFeatures12'), $exp_features.Remove('ExpFeatures13'), 
                $exp_features.Remove('ExpFeatures14'), $exp_features.Remove('ExpFeatures15'), 
                $exp_features.Remove('ExpFeatures16'), $exp_features.Remove('ExpFeatures17')
            }
            $n = ($lang).NoVariable2
            $contents = $exp_features
            $paramdata = $xpui_js
        }
    }

    $contents.Keys | ForEach-Object { 
 
        if ($paramdata -match $contents.$PSItem[0]) { 
            $paramdata = $paramdata -replace $contents.$PSItem[0], $contents.$PSItem[1] 
        }
        else { 
            Write-Host ($lang).NoVariable"" -ForegroundColor red -NoNewline 
            Write-Host "`$contents.$PSItem"$n
        }    
    }
    $paramdata
}

Write-Host ($lang).ModSpoti`n

if (!($premium)) {
    $patchFiles = "$PWD\chrome_elf.dll", "$PWD\config.ini"
    Copy-Item -LiteralPath $patchFiles -Destination "$spotifyDirectory"
}
$tempDirectory = $PWD
Pop-Location

Start-Sleep -Milliseconds 200
Remove-Item -Recurse -LiteralPath $tempDirectory 

$xpui_spa_patch = "$env:APPDATA\Spotify\Apps\xpui.spa"
$xpui_js_patch = "$env:APPDATA\Spotify\Apps\xpui\xpui.js"
$xpui_css_patch = "$env:APPDATA\Spotify\Apps\xpui\xpui.css"
$xpui_lic_patch = "$env:APPDATA\Spotify\Apps\xpui\licenses.html"
if ($ru) { $xpui_ru_patch = "$env:APPDATA\Spotify\Apps\xpui\i18n\ru.json" }
$test_spa = Test-Path -Path $xpui_spa_patch
$test_js = Test-Path -Path $xpui_js_patch
$xpui_js_bak_patch = "$env:APPDATA\Spotify\Apps\xpui\xpui.js.bak"
$xpui_css_bak_patch = "$env:APPDATA\Spotify\Apps\xpui\xpui.css.bak"
$xpui_lic_bak_patch = "$env:APPDATA\Spotify\Apps\xpui\licenses.html.bak"
if ($ru) { $xpui_ru_bak_patch = "$env:APPDATA\Spotify\Apps\xpui\i18n\ru.json.bak" }
$spotify_exe_bak_patch = "$env:APPDATA\Spotify\Spotify.bak"


if ($test_spa -and $test_js) {
    Write-Host ($lang).Error -ForegroundColor Red
    Write-Host ($lang).FileLocBroken
    Write-Host ($lang).StopScrpit
    pause
    Exit
}

if (Test-Path $xpui_js_patch) {
    Write-Host ($lang).Spicetify`n

    if ($ru) {
        $patch_lang = "$env:APPDATA\Spotify\Apps\xpui\i18n"
        Remove-Item $patch_lang -Exclude *en*, *ru*, *__longest* -Recurse
    }

    $reader = New-Object -TypeName System.IO.StreamReader -ArgumentList $xpui_js_patch
    $xpui_test_js = $reader.ReadToEnd()
    $reader.Close()
        
    If ($xpui_test_js -match 'patched by bo0') {

        $test_xpui_js_bak = Test-Path -Path $xpui_js_bak_patch
        $test_xpui_css_bak = Test-Path -Path $xpui_css_bak_patch
        $test_xpui_lic_bak = Test-Path -Path $xpui_lic_bak_patch
        if ($ru) { $test_xpui_ru_bak = Test-Path -Path $xpui_ru_bak_patch }
        $test_spotify_exe_bak = Test-Path -Path $spotify_exe_bak_patch

        if ($test_xpui_js_bak -or $test_xpui_css_bak) {
            
            if ($test_xpui_js_bak) { 
                Remove-Item $xpui_js_patch -Recurse -Force
                Rename-Item $xpui_js_bak_patch $xpui_js_patch
            }
            if ($test_xpui_css_bak) {
                Remove-Item $xpui_css_patch -Recurse -Force
                Rename-Item $xpui_css_bak_patch $xpui_css_patch
            }
            if ($test_xpui_lic_bak) {
                Remove-Item $xpui_lic_patch -Recurse -Force
                Rename-Item $xpui_lic_bak_patch $xpui_lic_patch
            }
            if ($test_xpui_ru_bak -and $ru) {
                Remove-Item $xpui_ru_patch -Recurse -Force
                Rename-Item $xpui_ru_bak_patch $xpui_ru_patch
            }
            if ($test_spotify_exe_bak) {
                Remove-Item $spotifyExecutable -Recurse -Force
                Rename-Item $spotify_exe_bak_patch $spotifyExecutable
            }

        }
        else {
            Write-Host ($lang).NoRestore`n
            Pause
            Exit
        }

    }

    Copy-Item $xpui_js_patch $xpui_js_bak_patch
    Copy-Item $xpui_css_patch $xpui_css_bak_patch
    Copy-Item $xpui_lic_patch $xpui_lic_bak_patch
    if ($ru) { Copy-Item $xpui_ru_patch $xpui_ru_bak_patch }

    $reader = New-Object -TypeName System.IO.StreamReader -ArgumentList $xpui_js_patch
    $xpui_js = $reader.ReadToEnd()
    $reader.Close()

    if ($Podcast_off) { $xpui_js = Helper -paramname "OffPodcasts" }
    
    if (!($premium)) { $xpui_js = Helper -paramname "OffadsonFullscreen" } 

    if ($exp_off) { Write-Host ($lang).ExpOff`n }
    if (!($exp_off)) { $xpui_js = Helper -paramname "ExpFeature" }

    if ($ru) { $xpui_js = Helper -paramname "OffRujs" }

    $writer = New-Object System.IO.StreamWriter -ArgumentList $xpui_js_patch
    $writer.BaseStream.SetLength(0)
    $writer.Write($xpui_js)
    $writer.Write([System.Environment]::NewLine + '// Patched by bo0') 
    $writer.Close()  

    if ($ru) {
        $file_ru = get-item $env:APPDATA\Spotify\Apps\xpui\i18n\ru.json
        $reader = New-Object -TypeName System.IO.StreamReader -ArgumentList $file_ru
        $xpui_ru = $reader.ReadToEnd()
        $reader.Close()
        $xpui_ru = Helper -paramname "RuTranslate"
        $writer = New-Object System.IO.StreamWriter -ArgumentList $file_ru
        $writer.BaseStream.SetLength(0)
        $writer.Write($xpui_ru)
        $writer.Close()  
    }

    # xpui.css
    $file_xpui_css = get-item $env:APPDATA\Spotify\Apps\xpui\xpui.css
    $reader = New-Object -TypeName System.IO.StreamReader -ArgumentList $file_xpui_css
    $xpuiContents_xpui_css = $reader.ReadToEnd()
    $reader.Close()

    $writer = New-Object System.IO.StreamWriter -ArgumentList $file_xpui_css
    $writer.BaseStream.SetLength(0)
    $writer.Write($xpuiContents_xpui_css)
    if (!($premium)) {
        $writer.Write([System.Environment]::NewLine + ' .BKsbV2Xl786X9a09XROH{display:none}')
        $writer.Write([System.Environment]::NewLine + ' button.wC9sIed7pfp47wZbmU6m.pzkhLqffqF_4hucrVVQA{display:none}')
    }
    if (!($hide_col_icon_off) -and !($exp_off)) {
        $writer.Write([System.Environment]::NewLine + ' .X1lXSiVj0pzhQCUo_72A{display:none}')
    }
    if ($podcast_off) { 
        $writer.Write([System.Environment]::NewLine + ' li.OEFWODerafYHGp09iLlA [href="/collection/podcasts"]{display:none}')
    }
    $writer.Close()

    $file_licenses = get-item $env:APPDATA\Spotify\Apps\xpui\licenses.html
    $reader = New-Object -TypeName System.IO.StreamReader -ArgumentList $file_licenses
    $xpuiContents_html = $reader.ReadToEnd()
    $reader.Close()
    $xpuiContents_html = Helper -paramname "HtmlLicMin" 
    $writer = New-Object System.IO.StreamWriter -ArgumentList $file_licenses
    $writer.BaseStream.SetLength(0)
    $writer.Write($xpuiContents_html)
    $writer.Close()
}  

If (Test-Path $xpui_spa_patch) {

    $bak_spa = "$env:APPDATA\Spotify\Apps\xpui.bak"
    $test_bak_spa = Test-Path -Path $bak_spa

    Add-Type -Assembly 'System.IO.Compression.FileSystem'
    $zip = [System.IO.Compression.ZipFile]::Open($xpui_spa_patch, 'update')
    $entry = $zip.GetEntry('xpui.js')
    $reader = New-Object System.IO.StreamReader($entry.Open())
    $patched_by_bo0 = $reader.ReadToEnd()
    $reader.Close()

    If ($patched_by_bo0 -match 'patched by bo0') {
        $zip.Dispose()    

        if ($test_bak_spa) {
            Remove-Item $xpui_spa_patch -Recurse -Force
            Rename-Item $bak_spa $xpui_spa_patch

            $spotify_exe_bak_patch = "$env:APPDATA\Spotify\Spotify.bak"
            $test_spotify_exe_bak = Test-Path -Path $spotify_exe_bak_patch
            if ($test_spotify_exe_bak) {
                Remove-Item $spotifyExecutable -Recurse -Force
                Rename-Item $spotify_exe_bak_patch $spotifyExecutable
            }
        }
        else {
            Write-Host ($lang).NoRestore2`n
            Pause
            Exit
        }
        $spotify_exe_bak_patch = "$env:APPDATA\Spotify\Spotify.bak"
        $test_spotify_exe_bak = Test-Path -Path $spotify_exe_bak_patch
        if ($test_spotify_exe_bak) {
            Remove-Item $spotifyExecutable -Recurse -Force
            Rename-Item $spotify_exe_bak_patch $spotifyExecutable
        }
    }
    $zip.Dispose()
    Copy-Item $xpui_spa_patch $env:APPDATA\Spotify\Apps\xpui.bak

    if ($ru) {
        [Reflection.Assembly]::LoadWithPartialName('System.IO.Compression') | Out-Null

        $files = 'af.json', 'am.json', 'ar.json', 'az.json', 'bg.json', 'bho.json', 'bn.json', `
            'cs.json', 'da.json', 'de.json', 'el.json', 'es-419.json', 'es.json', 'et.json', 'fa.json', `
            'fi.json', 'fil.json', 'fr-CA.json', 'fr.json', 'gu.json', 'he.json', 'hi.json', 'hu.json', `
            'id.json', 'is.json', 'it.json', 'ja.json', 'kn.json', 'ko.json', 'lt.json', 'lv.json', `
            'ml.json', 'mr.json', 'ms.json', 'nb.json', 'ne.json', 'nl.json', 'or.json', 'pa-IN.json', `
            'pl.json', 'pt-BR.json', 'pt-PT.json', 'ro.json', 'sk.json', 'sl.json', 'sr.json', 'sv.json', `
            'sw.json' , 'ta.json' , 'te.json' , 'th.json' , 'tr.json' , 'uk.json' , 'ur.json' , 'vi.json', `
            'zh-CN.json', 'zh-TW.json' , 'zu.json' , 'pa-PK.json' , 'hr.json'

        $stream = New-Object IO.FileStream($xpui_spa_patch, [IO.FileMode]::Open)
        $mode = [IO.Compression.ZipArchiveMode]::Update
        $zip_xpui = New-Object IO.Compression.ZipArchive($stream, $mode)

    ($zip_xpui.Entries | Where-Object { $files -contains $_.Name }) | ForEach-Object { $_.Delete() }

        $zip_xpui.Dispose()
        $stream.Close()
        $stream.Dispose()
    }

    Add-Type -Assembly 'System.IO.Compression.FileSystem'
    $zip = [System.IO.Compression.ZipFile]::Open($xpui_spa_patch, 'update')
    
    # xpui.js
    $entry_xpui = $zip.GetEntry('xpui.js')
    $reader = New-Object System.IO.StreamReader($entry_xpui.Open())
    $xpui_js = $reader.ReadToEnd()
    $reader.Close()

    if ($podcast_off) { $xpui_js = Helper -paramname "OffPodcasts" }
    
    if (!($premium)) {
        $xpui_js = Helper -paramname "OffadsonFullscreen"
    }

    if ($exp_off) { Write-Host ($lang).ExpOff`n }
    if (!($exp_off)) { $xpui_js = Helper -paramname "ExpFeature" }

    if ($ru) { $xpui_js = Helper -paramname "OffRujs" }

    $xpui_js = $xpui_js -replace "sp://logging/v3/\w+", ""
   
    $writer = New-Object System.IO.StreamWriter($entry_xpui.Open())
    $writer.BaseStream.SetLength(0)
    $writer.Write($xpui_js)
    $writer.Write([System.Environment]::NewLine + '// Patched by bo0') 
    $writer.Close()

    $entry_vendor_xpui = $zip.GetEntry('vendor~xpui.js')
    $reader = New-Object System.IO.StreamReader($entry_vendor_xpui.Open())
    $xpuiContents_vendor = $reader.ReadToEnd()
    $reader.Close()

    $xpuiContents_vendor = $xpuiContents_vendor `
        -replace "prototype\.bindClient=function\(\w+\)\{", '${0}return;'
    $writer = New-Object System.IO.StreamWriter($entry_vendor_xpui.Open())
    $writer.BaseStream.SetLength(0)
    $writer.Write($xpuiContents_vendor)
    $writer.Close()

    $zip.Entries | Where-Object FullName -like '*.js' | ForEach-Object {
        $readerjs = New-Object System.IO.StreamReader($_.Open())
        $xpuiContents_js = $readerjs.ReadToEnd()
        $readerjs.Close()

        $xpuiContents_js = $xpuiContents_js `
            -replace "[/][/][#] sourceMappingURL=.*[.]map", "" -replace "\r?\n(?!\(1|\d)", ""

        $writer = New-Object System.IO.StreamWriter($_.Open())
        $writer.BaseStream.SetLength(0)
        $writer.Write($xpuiContents_js)
        $writer.Close()
    }

    $entry_xpui_css = $zip.GetEntry('xpui.css')
    $reader = New-Object System.IO.StreamReader($entry_xpui_css.Open())
    $xpuiContents_xpui_css = $reader.ReadToEnd()
    $reader.Close()
        
    $writer = New-Object System.IO.StreamWriter($entry_xpui_css.Open())
    $writer.BaseStream.SetLength(0)
    $writer.Write($xpuiContents_xpui_css)
    if (!($premium)) {
        $writer.Write([System.Environment]::NewLine + ' .BKsbV2Xl786X9a09XROH {display: none}')
        $writer.Write([System.Environment]::NewLine + ' button.wC9sIed7pfp47wZbmU6m.pzkhLqffqF_4hucrVVQA {display: none}')
    }
    if (!($hide_col_icon_off) -and !($exp_off)) {
        $writer.Write([System.Environment]::NewLine + ' .X1lXSiVj0pzhQCUo_72A{display:none}')
    }
    if ($podcast_off) { 
        $writer.Write([System.Environment]::NewLine + ' li.OEFWODerafYHGp09iLlA [href="/collection/podcasts"] {display: none}')
    }
    $writer.Close()

    $zip.Entries | Where-Object FullName -like '*.css' | ForEach-Object {
        $readercss = New-Object System.IO.StreamReader($_.Open())
        $xpuiContents_css = $readercss.ReadToEnd()
        $readercss.Close()

        $xpuiContents_css = $xpuiContents_css `
            -replace "}\[dir=ltr\]\s?([.a-zA-Z\d[_]+?,\[dir=ltr\])", '}[dir=str] $1' -replace "}\[dir=ltr\]\s?", "} " -replace "html\[dir=ltr\]", "html" `
            -replace ",\s?\[dir=rtl\].+?(\{.+?\})", '$1' -replace "[\w\-\.]+\[dir=rtl\].+?\{.+?\}", "" -replace "\}\[lang=ar\].+?\{.+?\}", "}" `
            -replace "\}\[dir=rtl\].+?\{.+?\}", "}" -replace "\}html\[dir=rtl\].+?\{.+?\}", "}" -replace "\}html\[lang=ar\].+?\{.+?\}", "}" `
            -replace "\[lang=ar\].+?\{.+?\}", "" -replace "html\[dir=rtl\].+?\{.+?\}", "" -replace "html\[lang=ar\].+?\{.+?\}", "" `
            -replace "\[dir=rtl\].+?\{.+?\}", "" -replace "\[dir=str\]", "[dir=ltr]" `
            -replace "[/]\*([^*]|[\r\n]|(\*([^/]|[\r\n])))*\*[/]", "" -replace "[/][/]#\s.*", "" -replace "\r?\n(?!\(1|\d)", ""
    
        $writer = New-Object System.IO.StreamWriter($_.Open())
        $writer.BaseStream.SetLength(0)
        $writer.Write($xpuiContents_css)
        $writer.Close()
    }
    
    $zip.Entries | Where-Object FullName -like '*licenses.html' | ForEach-Object {
        $reader = New-Object System.IO.StreamReader($_.Open())
        $xpuiContents_html = $reader.ReadToEnd()
        $reader.Close()      
        $xpuiContents_html = Helper -paramname "HtmlLicMin"
        $writer = New-Object System.IO.StreamWriter($_.Open())
        $writer.BaseStream.SetLength(0)
        $writer.Write($xpuiContents_html)
        $writer.Close()
    }

    $entry_blank_html = $zip.GetEntry('blank.html')
    $reader = New-Object System.IO.StreamReader($entry_blank_html.Open())
    $xpuiContents_html_blank = $reader.ReadToEnd()
    $reader.Close()

    $html_min1 = "  "
    $html_min2 = "(?m)(^\s*\r?\n)"
    $html_min3 = "\r?\n(?!\(1|\d)"
    if ($xpuiContents_html_blank -match $html_min1) { $xpuiContents_html_blank = $xpuiContents_html_blank -replace $html_min1, "" } else { Write-Host ($lang).NoVariable"" -ForegroundColor red -NoNewline; Write-Host "`$html_min1 "($lang).NoVariable4 }
    if ($xpuiContents_html_blank -match $html_min2) { $xpuiContents_html_blank = $xpuiContents_html_blank -replace $html_min2, "" } else { Write-Host ($lang).NoVariable"" -ForegroundColor red -NoNewline; Write-Host "`$html_min2 "($lang).NoVariable4 }
    if ($xpuiContents_html_blank -match $html_min3) { $xpuiContents_html_blank = $xpuiContents_html_blank -replace $html_min3, "" } else { Write-Host ($lang).NoVariable"" -ForegroundColor red -NoNewline; Write-Host "`$html_min3 "($lang).NoVariable4 }

    $xpuiContents_html_blank = $xpuiContents_html_blank
    $writer = New-Object System.IO.StreamWriter($entry_blank_html.Open())
    $writer.BaseStream.SetLength(0)
    $writer.Write($xpuiContents_html_blank)
    $writer.Close()
    
    if ($ru) {
        $zip.Entries | Where-Object FullName -like '*ru.json' | ForEach-Object {
            $readerjson = New-Object System.IO.StreamReader($_.Open())
            $xpui_ru = $readerjson.ReadToEnd()
            $readerjson.Close()

    
            $xpui_ru = Helper -paramname "RuTranslate"
            $writer = New-Object System.IO.StreamWriter($_.Open())
            $writer.BaseStream.SetLength(0)
            $writer.Write($xpui_ru)
            $writer.Close()
        }
    }
    $zip.Entries | Where-Object FullName -like '*.json' | ForEach-Object {
        $readerjson = New-Object System.IO.StreamReader($_.Open())
        $xpuiContents_json = $readerjson.ReadToEnd()
        $readerjson.Close()

        $xpuiContents_json = $xpuiContents_json `
            -replace "  ", "" -replace "    ", "" -replace '": ', '":' -replace "\r?\n(?!\(1|\d)", "" 

        $writer = New-Object System.IO.StreamWriter($_.Open())
        $writer.BaseStream.SetLength(0)
        $writer.Write($xpuiContents_json)
        $writer.Close()       
    }
    $zip.Dispose()   
}

if ($ru) {
    $patch_lang = "$spotifyDirectory\locales"
    Remove-Item $patch_lang -Exclude *en*, *ru* -Recurse
}

# Shortcut Spotify.lnk
$ErrorActionPreference = 'SilentlyContinue' 

$desktop_folder = DesktopFolder

If (!(Test-Path $desktop_folder\Spotify.lnk)) {
    $source = "$env:APPDATA\Spotify\Spotify.exe"
    $target = "$desktop_folder\Spotify.lnk"
    $WorkingDir = "$env:APPDATA\Spotify"
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($target)
    $Shortcut.WorkingDirectory = $WorkingDir
    $Shortcut.TargetPath = $source
    $Shortcut.Save()      
}

$ErrorActionPreference = 'SilentlyContinue'
$update_test_exe = Test-Path -Path $spotifyExecutable

if ($block_update) {

    if ($update_test_exe) {
        $exe = "$env:APPDATA\Spotify\Spotify.exe"
        $exe_bak = "$env:APPDATA\Spotify\Spotify.bak"
        $ANSI = [Text.Encoding]::GetEncoding(1251)
        $old = [IO.File]::ReadAllText($exe, $ANSI)

        if ($old -match "(?<=wg:\/\/desktop-update\/.)7(\/update)") {
            Write-Host ($lang).UpdateBlocked`n
        }
        elseif ($old -match "(?<=wg:\/\/desktop-update\/.)2(\/update)") {
            copy-Item $exe $exe_bak
            $new = $old -replace "(?<=wg:\/\/desktop-update\/.)2(\/update)", '7/update'
            [IO.File]::WriteAllText($exe, $new, $ANSI)
        }
        else {
            Write-Host ($lang).UpdateError`n -ForegroundColor Red
        }
    }
    else {
        Write-Host ($lang).NoSpotifyExe`n -ForegroundColor Red 
    }
}

if ($cache_install) {
    Start-Sleep -Milliseconds 200
    New-Item -Path $env:APPDATA\Spotify\ -Name "cache" -ItemType "directory" | Out-Null

    downloadScripts -param1 "cache-spotify"
    downloadScripts -param1 "hide_window"
    downloadScripts -param1 "run_ps"

    $source2 = "$cache_folder\hide_window.vbs"
    $target2 = "$desktop_folder\Spotify.lnk"
    $WorkingDir2 = "$cache_folder"
    $WshShell2 = New-Object -comObject WScript.Shell
    $Shortcut2 = $WshShell2.CreateShortcut($target2)
    $Shortcut2.WorkingDirectory = $WorkingDir2
    $Shortcut2.IconLocation = "$env:APPDATA\Spotify\Spotify.exe"
    $Shortcut2.TargetPath = $source2
    $Shortcut2.Save()

    if ($number_days -match "^[1-9][0-9]?$|^100$") {
        $file_cache_spotify_ps1 = Get-Content $cache_folder\cache_spotify.ps1 -Raw
        $new_file_cache_spotify_ps1 = $file_cache_spotify_ps1 -replace '7', $number_days
        Set-Content -Path $cache_folder\cache_spotify.ps1 -Force -Value $new_file_cache_spotify_ps1
        $contentcache_spotify_ps1 = [System.IO.File]::ReadAllText("$cache_folder\cache_spotify.ps1")
        $contentcache_spotify_ps1 = $contentcache_spotify_ps1.Trim()
        [System.IO.File]::WriteAllText("$cache_folder\cache_spotify.ps1", $contentcache_spotify_ps1)

        $infile = "$cache_folder\cache_spotify.ps1"
        $outfile = "$cache_folder\cache_spotify2.ps1"

        $sr = New-Object System.IO.StreamReader($infile) 
        $sw = New-Object System.IO.StreamWriter($outfile, $false, [System.Text.Encoding]::Default)
        $sw.Write($sr.ReadToEnd())
        $sw.Close()
        $sr.Close() 
        $sw.Dispose()
        $sr.Dispose()

        Start-Sleep -Milliseconds 200
        Remove-item $infile -Recurse -Force
        Rename-Item -path $outfile -NewName $infile
    }
}

if ($start_spoti) { Start-Process -WorkingDirectory $spotifyDirectory -FilePath $spotifyExecutable }

Write-Host ($lang).Đã cài đặt xong và thành công ~.~`n -ForegroundColor Green
