# GitHub Token (Replace with your new valid token)
$TOKEN = "YOUR_NEW_GITHUB_TOKEN_HERE"

# API URL
$url = "https://api.github.com/gists"

# Headers
$headers = @{
    "Authorization" = "Bearer $TOKEN"
    "Accept" = "application/vnd.github+json"
    "Content-Type" = "application/json"
}

# Gist description and files
$body = @{
    description = "🇧🇩 Bangla Prompts - Complete Deployment Package for banglaprompts.com"
    public = $true
    files = @{
        "00-README.md" = @{
            content = "# 🇧🇩 বাংলা প্রম্পট (Bangla Prompts)`n`nComplete deployment package for banglaprompts.com with all files ready to use."
        }
        "01-messages-bn.json" = @{
            content = (Get-Content -Path "messages/bn.json" -Raw)
        }
        "02-config.ts" = @{
            content = "// i18n configuration with Bangla as default`nexport const defaultLocale = `"bn`";"
        }
    }
} | ConvertTo-Json -Depth 10

# Create gist
$response = Invoke-WebRequest -Uri $url -Method Post -Headers $headers -Body $body

# Display result
$gist = $response.Content | ConvertFrom-Json
Write-Host "✅ Gist created successfully!" -ForegroundColor Green
Write-Host "🔗 URL: $($gist.html_url)" -ForegroundColor Cyan
