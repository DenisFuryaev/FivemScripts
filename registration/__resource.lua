client_script "registration_client.lua"

server_scripts {
     "registration_server.lua",
     "@mysql-async/lib/MySQL.lua"
}

ui_page "html/index.html"

files {
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/reset.css'
}