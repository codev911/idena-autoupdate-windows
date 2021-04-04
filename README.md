# idena-autoupdate-windows
Ini adalah script powershell auto update untuk idena client dan node internal idena client untuk windows, cocok untuk RDP y kawan-kawan. Sudah saya test di RDP Azure windows 10 pro saya. Dikhususkan hanya untuk pengguna RDP yang nodenya pakai internal, kalau node remote bakal sia" update node localnya.

yg baik hati tlng donasinya hehe :3

DNA => 0x56114513608565e4f8161b8faebb96fe37f13d83

usage :

1. Download repo ini sebagai zip, atau clone dengan cara :
    ```
    git clone https://github.com/codev911/idena-autoupdate-node
    ```
2. Jalankan `autoupdate.ps1` dengan cara `Klik kanan > Run with PowerShell` bersama dengan Client Wallet idenanya.
3. Biarkan berjalan.

fix jika tidak jalan :

To remove the execution policy for a Scope:
```
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser
```
fix source : https://docs.microsoft.com/en-gb/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-7
